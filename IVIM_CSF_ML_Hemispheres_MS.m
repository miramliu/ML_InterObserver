% draw hemispheres on IVIM to compare to CSF
% draw it on mono-exp image (to minimize bias)

function IVIM_CSF_ML_Hemispheres(CaseNumber,ScanName, slices, physiostate, DA_model)
addpath '/Users/neuroimaging/Desktop/MR-Code/IVIM_MachineLearning'

if physiostate == 'Normo'
    Day = 'Day1';
elseif physiostate == 'Hyper'
    Day = 'Day1';
elseif physiostate == 'PMCAO'
    Day = 'Day2';
else
    error('Check Physiostate, must be Normo, Hyper, or MCAO')
end


targetpath = ['/Users/neuroimaging/Desktop/DATA/IVIM_PD/IVIM_', CaseNumber]
Filename = '/Users/neuroimaging/Desktop/MR-Code/MachineLearning_Analysis/IVIMHemispheric_Comparisons_ALL.xlsx';
IVIM_name = [targetpath,'/',Day,'/', ScanName,'_2step.mat'];
monoexp_name = [targetpath,'/',Day,'/', ScanName,'_monoexp.mat'];
load(monoexp_name,'Dcsf')
load(IVIM_name,'f','Dstar','D')

[~,nx,ny] = size(f);
%% Check does ROI mat file exist?
if ~exist([targetpath,'/',Day,'/', 'Hemisphere_ROIs_',ScanName, '_MS.mat'],'file')
    % if not, first draw the normal hemispheric 
    LeftHems = zeros(3,nx,ny);
    RightHems = zeros(3,nx,ny);
    for slicenum = 1:length(slices)
        slice = slices(slicenum);
        
        
        figure, imshow(squeeze(Dcsf(slice,:,:)),[]),truesize([500 500])
        
        disp('Draw Left hemisphere, excluding ventricles')
        [LeftHem,xL,yL] = roipoly;
        hold on; 
        plot(xL, yL, 'w.-', 'MarkerSize', 15);
        hold on
        disp('Draw Right hemisphere, excluding ventricles')
        [RightHem,xR,yR] = roipoly;
        plot(xR, yR, 'w.-', 'MarkerSize', 15);
        hold off
        
        close()
        
    
        LeftHems(slicenum,:,:) = LeftHem;
        RightHems(slicenum,:,:) = RightHem;
    end
    
    save([targetpath,'/',Day,'/', 'Hemisphere_ROIs_',ScanName, '_MS.mat'],'LeftHems','RightHems')
else % check for total hemispheric ROIs (ventricles not excluded)
    disp('ROIs found, now checking true hemispheric: ')
end

%% now test and see if there are the hemispheric ROIs with the ventricles removed
try %if it works, whoo, go to analysis
    warning('off','all') %turn off warning because it's annoying
    load([targetpath,'/',Day,'/', 'Hemisphere_ROIs_',ScanName, '.mat'],'LeftTotalHems','RightTotalHems')
    A = LeftTotalHems; % just to get the failure lol
catch % if not, draw them and save them
    LeftTotalHems = zeros(3,nx,ny);
    RightTotalHems = zeros(3,nx,ny);

    for slicenum = 1:length(slices)
        slice = slices(slicenum);
        
        
        figure, imshow(squeeze(Dcsf(slice,:,:)),[]),truesize([500 500])
        
        disp('Draw TOTAL Left hemisphere')
        [LeftHem,xL,yL] = roipoly;
        hold on; 
        plot(xL, yL, 'w.-', 'MarkerSize', 15);
        hold on
        disp('Draw TOTAL Right hemisphere')
        [RightHem,xR,yR] = roipoly;
        plot(xR, yR, 'w.-', 'MarkerSize', 15);
        hold off
        
        close()
        
    
        LeftTotalHems(slicenum,:,:) = LeftHem;
        RightTotalHems(slicenum,:,:) = RightHem;
    end
    save([targetpath,'/',Day,'/', 'Hemisphere_ROIs_',ScanName, '.mat'],'LeftTotalHems','RightTotalHems','-append')
end
disp('Got Total hemispheres')
warning('on','all') %turn em back on now


%% now the analysis of the ROIs
load([targetpath,'/',Day,'/', 'Hemisphere_ROIs_',ScanName, '.mat'],'LeftHems','RightHems','LeftTotalHems','RightTotalHems')

% get model from day 1 , LDA, seed = 3?


AverageHem_All = zeros(3,2);
AverageHem_ML = zeros(3,2);
AverageHem_LOOCV = zeros(3,2);
AverageHem_T2 = zeros(3,2);
AverageHem_Hand_And_ML = zeros(3,2);
AverageHem_Hand = zeros(3,2);


for slicenum = 1:length(slices)
    slice = slices(slicenum);
    
    % get with the signal with the ventricles included ('TOTAL' hemispheric)
    LeftHem = squeeze(LeftTotalHems(slicenum,:,:));
    RightHem = squeeze(RightTotalHems(slicenum,:,:));

    %% first just raw average (no csf removal from fD*)
    Dstarthresholded = squeeze(Dstar(slice,:,:) < .09999) ; % to remove those weirdly high values
    fdstarslice = squeeze(f(slice,:,:).*Dstar(slice,:,:)).*Dstarthresholded;
    AverageHem_All(slicenum,:) = [mean(nonzeros(fdstarslice.*LeftHem),'all'),mean(nonzeros(fdstarslice.*RightHem),'all')];
    
    %figure, subplot(3,2,1),imshow(fdstarslice,[0 120/93000]),colormap(gca,'jet')

    %% now nested loocv CSF removed
    Dcsfslice = squeeze(Dcsf(slice,:,:)).*Dstarthresholded;
    Dcsf_thresholded2 = Dcsfslice<0.001560803738740; % everything NOT csf here. 
    LOOCV_img = fdstarslice.*Dcsf_thresholded2;
    
    %{
    subplot(3,2,2),imshow(LOOCV_img,[0 120/51000]), colormap(gca,'jet')
    subplot(3,2,3),imshow(LOOCV_img.*LeftHem,[0 120/51000]),colormap(gca,'jet')
    subplot(3,2,4),imshow(LOOCV_img.*RightHem,[0 120/51000]),colormap(gca,'jet')
    %}
    AverageHem_LOOCV(slicenum,:) = [mean(nonzeros(LOOCV_img.*LeftHem),'all'),mean(nonzeros(LOOCV_img.*RightHem),'all')];

    %% now apply this model to the image and remove those labeled CSF with ML? 
    matrix_stacked = zeros(nx,ny,3);
    matrix_stacked(:,:,1) = squeeze(f(slice,:,:));
    matrix_stacked(:,:,2) = squeeze(Dstar(slice,:,:));
    matrix_stacked(:,:,3) = squeeze(D(slice,:,:));
    DiscriminantMask = GetDiscriminantMask(DA_model,matrix_stacked);
    ML_img = fdstarslice.*(~DiscriminantMask);

    %{
    subplot(3,2,5),imshow(ML_img.*LeftHem,[0 120/51000]),colormap(gca,'jet')
    subplot(3,2,6),imshow(ML_img.*RightHem,[0 120/51000]),colormap(gca,'jet')
    %}
    AverageHem_ML(slicenum,:) = [mean(nonzeros(ML_img.*LeftHem),'all'),mean(nonzeros(ML_img.*RightHem),'all')];


    %% now get T2 thresholded
    % for T2 thresholding
    image_number = (slice-1)*37 + 28; % to get the IM_X number
    fname = fullfile(targetpath, '/', Day,'/',ScanName, '/IM_'+string(image_number)+'.dcm');
    ImageB0 = double(dicomread(fname));
    if physiostate == 'Normo'
        threshold = 323;
    elseif physiostate == 'Hyper'
        threshold = 337;
    elseif physiostate == 'PMCAO'
        threshold = 331;
    end

    T2Thresholdmask = (ImageB0<threshold); % this gives the  thresholded mask from T2 nested LOOCV!
    T2_img = fdstarslice.*(T2Thresholdmask); 
    AverageHem_T2(slicenum,:) = [mean(nonzeros(T2_img.*LeftHem),'all'),mean(nonzeros(T2_img.*RightHem),'all')];

    %{
    subplot(3,2,2),imshow(T2_img,[0 120/93000]), colormap(gca,'jet')
    subplot(3,2,3),imshow(T2_img.*LeftHem,[0 120/93000]),colormap(gca,'jet')
    subplot(3,2,4),imshow(T2_img.*RightHem,[0 120/93000]),colormap(gca,'jet')
    disp('Got All, LOOCV, ML, and T2 for a slice')
    %}

    %% now both hand-drawn avoidance + ML removal
    % get with the signal with the ventricles left out
    LeftHem_hand = squeeze(LeftHems(slicenum,:,:));
    RightHem_hand = squeeze(RightHems(slicenum,:,:));
    AverageHem_Hand_And_ML(slicenum,:) = [mean(nonzeros(ML_img.*LeftHem_hand),'all'),mean(nonzeros(ML_img.*RightHem_hand),'all')];

    %% just hand-drawn avoidance
    AverageHem_Hand(slicenum,:) = [mean(nonzeros(fdstarslice.*LeftHem_hand),'all'),mean(nonzeros(fdstarslice.*RightHem_hand),'all')];


end


%reshape across rows, multiply by scaling factor, and convert to cell
Export1 = num2cell(reshape(AverageHem_All.',1,[]).*93000);
Export2 = num2cell(reshape(AverageHem_LOOCV.',1,[]).*93000);
Export3 = num2cell(reshape(AverageHem_ML.',1,[]).*93000);
Export4 = num2cell(reshape(AverageHem_T2.',1,[]).*93000);
Export5 = num2cell(reshape(AverageHem_Hand_And_ML.',1,[]).*93000);
Export6 = num2cell(reshape(AverageHem_Hand.',1,[]).*93000);

disp('writing up data')
Identifying_Info = {CaseNumber,ScanName, physiostate};
Export_Cell = [Identifying_Info,'All',Export1]; % create one row to add to excel, and include pixel number
writecell(Export_Cell,Filename,'WriteMode','append')
Export_Cell = [Identifying_Info,'LOOCV',Export2]; % create one row to add to excel, and include pixel number
writecell(Export_Cell,Filename,'WriteMode','append')
Export_Cell = [Identifying_Info,'ML',Export3]; % create one row to add to excel, and include pixel number
writecell(Export_Cell,Filename,'WriteMode','append')
Export_Cell = [Identifying_Info,'T2',Export4]; % create one row to add to excel, and include pixel number
writecell(Export_Cell,Filename,'WriteMode','append')
Export_Cell = [Identifying_Info,'Hand And ML',Export5]; % create one row to add to excel, and include pixel number
writecell(Export_Cell,Filename,'WriteMode','append')
Export_Cell = [Identifying_Info,'HandAvoided',Export6]; % create one row to add to excel, and include pixel number
writecell(Export_Cell,Filename,'WriteMode','append')
%}




end