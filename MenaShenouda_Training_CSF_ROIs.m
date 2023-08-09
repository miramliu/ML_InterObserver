function CSF_Mask = MenaShenouda_Training_CSF_ROIs(varargin)
% function to draw CSF masks and save in volume to do LOOCV against an automatic threshold 
% 07/14/2022
% ML
addpath('/Users/neuroimaging/Desktop/MR-Code/Diffusion_Volumes'); %to use Find inPath

targetpath = varargin{1}; %path to Collat folder (/Collat_1/Day1/)
foldername = varargin{2}; % name of scan (FOLDER) ('Scan 1 Sorted')
Slices = varargin{3}; %three slices of image (i.e number of whatever slice is chosen)

savename = [targetpath, 'CSF_Mask_',foldername, '_MS.mat']; %added 2, Feb 23rd 2023 this is to include subarachnoid space as well, not just ventricles
savebrainmask = [targetpath, 'Brain_Mask_',foldername, '.mat'];

fmap = load([targetpath, foldername, '_2step.mat'], 'f');
CSF_Mask = zeros(size(fmap.f));


% get brain mask
%{
if ~exist(savebrainmask,'file')
    [imgstack,bvaluelist] = loadIVIM2022(targetpath, foldername);
    b_ind = find([bvaluelist{:}] == 1000); %this is the index for the b-value that is 778 (closest to 800 which is what is used for DTI?)
    brainMask = segmentBrain_IVIM(imgstack,b_ind);
    save (savebrainmask, 'brainMask','b_ind','imgstack')
    fprintf('brainmask saved at %s', brainMask)
else
    fprintf('Already brainmask saved at:\n %s\n', savebrainmask)
    brainMask = load(savebrainmask,'brainMask').brainMask;
end
%}


% Now draw CSF mask on segmented (brain mask) raw B0 image
if ~exist(savename,'file')
    for i = 1:length(Slices) %now for each of the 3 slices
        slice = Slices{i};
        image_number = (slice-1)*37 + 28; % to get the IM_X number
        fname = fullfile(targetpath, foldername, '/IM_'+string(image_number)+'.dcm');
        ImageB0 = double(dicomread(fname));
        if exist(savename,'file')
            error('masks already exist')
        else
            figure,imshow(ImageB0,[0 500]),colorbar,truesize([500 500]); %show image, with brain mask applied
            disp('Draw mask, press enter when ready... ')
            pause; % hold figure until ready to draw mask
            [CSF_Mask(slice,:,:), x,y] = roipoly;
            hold on;
            plot(x, y, 'w.-', 'MarkerSize', 15);
        end
    end
    save(savename, "CSF_Mask")
% if all have been done already, just display themm
else
    fprintf('Already CSF mask saved at:\n %s\n', savename)
    CSF_Mask = load(savename,'CSF_Mask').CSF_Mask;
end

% now show results
for i = 1:length(Slices)
    slice = Slices{i};
    image_number = (slice-1)*37 + 28; % to get the IM_X number
    fname = fullfile(targetpath, foldername, '/IM_'+string(image_number)+'.dcm');
    ImageB0 = double(dicomread(fname));
    figure,
    subplot(1,3,1),imshow(ImageB0,[0 500]),
    subplot(1,3,2), imshow(ImageB0)%.*squeeze(brainMask(:,:,slice)), [0 500])
    subplot(1,3,3), imshow(ImageB0.*squeeze(~CSF_Mask(slice,:,:)), [0 500]) %have removed brainmask here, june 12 2023
    pause;
end

end



%%  Read Me
% ML: below are example run.

%{
tp = '/Users/neuroimaging/Desktop/DATA/IVIM_PD/IVIM_25/Day1/'
nm = 'Scan 2_sorted'
slcs = {27, 21, 18} %this is from All_IVIMvDSC
mask = IVIM_CSF_ROIs(tp,nm,slcs);
%}