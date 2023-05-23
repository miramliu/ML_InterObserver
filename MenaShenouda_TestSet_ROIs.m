%% THIS IS TO DRAW AN ROI THAT AVOIDS THE CSF 
% sorry for the complication :P This is NON-CSF 


function MenaShenouda_TestSet_ROIs(CaseNumber,ScanName, slices, physiostate)

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
%Filename = '/Users/neuroimaging/Desktop/MR-Code/MachineLearning_Analysis/IVIMHemispheric_Comparisons_ALL.xlsx';
IVIM_name = [targetpath,'/',Day,'/', ScanName,'_2step.mat'];
monoexp_name = [targetpath,'/',Day,'/', ScanName,'_monoexp.mat'];
load(monoexp_name,'Dcsf')
%load(IVIM_name,'f','Dstar','D') 

[~,nx,ny] = size(f);
%% Check does ROI mat file exist?
if ~exist([targetpath,'/',Day,'/', 'Hemisphere_ROIs_',ScanName, '_MS.mat'],'file')
    % if not, first draw the normal hemispheric 
    LeftHems = zeros(3,nx,ny);
    RightHems = zeros(3,nx,ny);
    for slicenum = 1:length(slices)
        slice = slices(slicenum);
        
        
        figure, imshow(squeeze(Dcsf(slice,:,:)),[]),truesize([500 500])
        
        disp('Draw Left hemisphere, EXCLUDING CSF')
        [LeftHem,xL,yL] = roipoly;
        hold on; 
        plot(xL, yL, 'w.-', 'MarkerSize', 15);
        hold on
        disp('Draw Right hemisphere, EXCLUDING CSF')
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

end