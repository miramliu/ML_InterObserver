% March 2nd 2023
% draw CSF masks on t2 maps by hand on the Day 2 data... 
% to add to the ROI stuff, rather than just automatic mono-exponential. 

% sorry mira. 


% updated: can also be run on hypercapnia and normocapnia... 
% make sure to make it Day1 in targetpath or Day 2 if post-occlusion

function GetTraining_Data()

    %OriginalFilename = '/Users/neuroimaging/Desktop/MR-Code/IVIM_MachineLearning/IVIM_Features_Day2_Updated_Handdrawn.xlsx';
    %OriginalFilename = '/Users/neuroimaging/Desktop/MR-Code/IVIM_MachineLearning/IVIM_Features_Day1_Hypercap_Updated_Handdrawn.xlsx';
    OriginalFilename = '/Users/neuroimaging/Desktop/MR-Code/IVIM_MachineLearning/IVIM_Features_Day1_Normo_Updated_Handdrawn.xlsx';


    % get the new cases
    Existing_Data = readcell(OriginalFilename,'Range','A:C'); %read only identifying info that already exists
    charArr = cellfun(@num2str, Existing_Data, 'UniformOutput', false);
    T = cell2table(charArr);
    UniqueCases = unique(T, 'rows'); % this returns the individual cases, nammes, and slice numbers to run!
    CasesToRun = table2cell(UniqueCases);%
    
    
    for i =1:size(UniqueCases,1) 
        Identifying_Info = CasesToRun(i,:); %for each unique row
        if strmatch(Identifying_Info{1},'13')
            if strmatch(Identifying_Info{3},'14')
                Identifying_Info{3} = '15'; % just to move slice up by one 
            end
        end
        if strmatch(Identifying_Info{1},'Case Number')
            disp('header case')
        else
            disp(Identifying_Info)
            %DrawROIsNow(Identifying_Info) %nested function to upload the data to the excel sheet!
        end
    end
end

function DrawROIsNow(IdentifyingInfo)
    
    CaseNumber = IdentifyingInfo{1};
    ScanName = IdentifyingInfo{2};
    slice = str2num(IdentifyingInfo{3});
    
    targetpath = ['/Users/neuroimaging/Desktop/DATA/IVIM_PD/IVIM_', CaseNumber];
    if exist([targetpath, '/Day1/ROIs_For_Average_IVIM_Curves_',num2str(slice),'.mat'],"file") % make sure this name matches the state of interest
        image_number = (slice-1)*37 + 28; % to get the IM_X number
        fname = fullfile(targetpath, '/Day1/',ScanName, '/IM_'+string(image_number)+'.dcm');
        ImageB0 = double(dicomread(fname));
        load([targetpath, '/Day1/ROIs_For_Average_IVIM_Curves_',num2str(slice),'.mat'])
        if exist('CSF_Mask','var') 
            disp('already loaded')
        else
            figure,imshow(ImageB0,[0 500]),colorbar,truesize([500 500]); %show image, with brain mask applied
            disp('Draw mask, press enter when ready... ')
            pause; % hold figure until ready to draw mask
            [CSF_Mask,x,y] = roipoly;
            hold on;
            plot(x, y, 'w.-', 'MarkerSize', 15);
            disp('press enter if you want to save...')
            pause;
            save([targetpath, '/Day1/ROIs_For_Average_IVIM_Curves_' num2str(slice),'.mat'],'CSF_Mask', '-append')
        end


       figure,
       subplot(1,2,1),imshow(ImageB0,[0 500]),
       subplot(1,2,2), imshow(ImageB0.*CSF_Mask, [0 500])
       pause(1)
       close all
    else
        disp(IdentifyingInfo)
        disp('file not found')
    end
end