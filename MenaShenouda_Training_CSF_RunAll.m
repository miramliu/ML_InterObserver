%% these are the normocapnia ROIs for CSF on T2 weighted images


% to run (not neatly at all), copy past each section of four lines into commmand line. 
% done just for checks and balances and to be able to take a break and stuff. 


tp = '/Users/neuroimaging/Desktop/DATA/IVIM_PD/IVIM_13/Day1/'
nm = 'SE02_IVIM_sorted'
slcs = {21, 19, 17} %this is from All_IVIMvDSC
mask = MenaShenouda_Training_CSF_ROIs(tp,nm,slcs);

tp = '/Users/neuroimaging/Desktop/DATA/IVIM_PD/IVIM_14/Day1/'
nm = 'SE03_IVIM_sorted'
slcs = {33, 31, 27} %this is from All_IVIMvDSC
mask = MenaShenouda_Training_CSF_ROIs(tp,nm,slcs);

tp = '/Users/neuroimaging/Desktop/DATA/IVIM_PD/IVIM_15/Day1/'
nm = 'Scan 02 IVIM_sorted'
slcs = {25, 21, 19} %this is from All_IVIMvDSC
mask = MenaShenouda_Training_CSF_ROIs(tp,nm,slcs);

tp = '/Users/neuroimaging/Desktop/DATA/IVIM_PD/IVIM_16/Day1/'
nm = 'Scan 02 IVIM_sorted'
slcs = {25, 23, 19} %this is from All_IVIMvDSC
mask = MenaShenouda_Training_CSF_ROIs(tp,nm,slcs);

tp = '/Users/neuroimaging/Desktop/DATA/IVIM_PD/IVIM_17/Day1/'
nm = 'Scan 02 IVIM_sorted'
slcs = {23, 20, 18} %this is from All_IVIMvDSC
mask = MenaShenouda_Training_CSF_ROIs(tp,nm,slcs);

tp = '/Users/neuroimaging/Desktop/DATA/IVIM_PD/IVIM_18/Day1/'
nm = 'Scan 02 IVIM_sorted'
slcs = {24, 22, 21} %this is from All_IVIMvDSC
mask = MenaShenouda_Training_CSF_ROIs(tp,nm,slcs);

tp = '/Users/neuroimaging/Desktop/DATA/IVIM_PD/IVIM_19/Day1/'
nm = 'Scan 02 IVIM_sorted'
slcs = {23, 21, 17} %this is from All_IVIMvDSC
mask = MenaShenouda_Training_CSF_ROIs(tp,nm,slcs);

tp = '/Users/neuroimaging/Desktop/DATA/IVIM_PD/IVIM_20/Day1/'
nm = 'Scan 02 IVIM_sorted'
slcs = {25, 21, 19} %this is from All_IVIMvDSC
mask = MenaShenouda_Training_CSF_ROIs(tp,nm,slcs);

tp = '/Users/neuroimaging/Desktop/DATA/IVIM_PD/IVIM_21/Day1/'
nm = 'Scan 34 IVIM_sorted'
slcs = {28, 24, 20} %this is from All_IVIMvDSC
mask = MenaShenouda_Training_CSF_ROIs(tp,nm,slcs);

tp = '/Users/neuroimaging/Desktop/DATA/IVIM_PD/IVIM_23/Day1/'
nm = 'Scan 1_sorted'
slcs = {29, 27, 23} %this is from All_IVIMvDSC
mask = MenaShenouda_Training_CSF_ROIs(tp,nm,slcs);

tp = '/Users/neuroimaging/Desktop/DATA/IVIM_PD/IVIM_24/Day1/'
nm = 'Scan 2_sorted'
slcs = {23, 21, 18} %this is from All_IVIMvDSC
mask = MenaShenouda_Training_CSF_ROIs(tp,nm,slcs);

tp = '/Users/neuroimaging/Desktop/DATA/IVIM_PD/IVIM_25/Day1/'
nm = 'Scan 2_sorted'
slcs = {27, 21, 18} %this is from All_IVIMvDSC
mask = MenaShenouda_Training_CSF_ROIs(tp,nm,slcs);





%% these are the hypercapnia ROIs for CSF on T2-weighted images
% these are the normocapnia ROIs for CSF on T2 weighted images

tp = '/Users/neuroimaging/Desktop/DATA/IVIM_PD/IVIM_13/Day1/'
nm = 'SE24_IVIM_sorted'
slcs = {21, 19, 17} %this is from All_IVIMvDSC
mask = MenaShenouda_Training_CSF_ROIs(tp,nm,slcs);

%tp = '/Users/neuroimaging/Desktop/DATA/IVIM_PD/IVIM_14/Day1/'
%nm = 'SE03_IVIM_sorted'
%slcs = {33, 31, 27} %this is from All_IVIMvDSC
%mask = MenaShenouda_Training_CSF_ROIs(tp,nm,slcs);

tp = '/Users/neuroimaging/Desktop/DATA/IVIM_PD/IVIM_15/Day1/'
nm = 'Scan 53 IVIM_sorted'
slcs = {25, 21, 19} %this is from All_IVIMvDSC
mask = MenaShenouda_Training_CSF_ROIs(tp,nm,slcs);

tp = '/Users/neuroimaging/Desktop/DATA/IVIM_PD/IVIM_16/Day1/'
nm = 'Scan 29 IVIM_sorted'
slcs = {25, 23, 19} %this is from All_IVIMvDSC
mask = MenaShenouda_Training_CSF_ROIs(tp,nm,slcs);

tp = '/Users/neuroimaging/Desktop/DATA/IVIM_PD/IVIM_17/Day1/'
nm = 'Scan 54 IVIM_sorted'
slcs = {23, 20, 18} %this is from All_IVIMvDSC
mask = MenaShenouda_Training_CSF_ROIs(tp,nm,slcs);

tp = '/Users/neuroimaging/Desktop/DATA/IVIM_PD/IVIM_18/Day1/'
nm = 'Scan 44 IVIM_sorted'
slcs = {24, 22, 21} %this is from All_IVIMvDSC
mask = MenaShenouda_Training_CSF_ROIs(tp,nm,slcs);

%tp = '/Users/neuroimaging/Desktop/DATA/IVIM_PD/IVIM_19/Day1/'
%nm = 'Scan 02 IVIM_sorted'
%slcs = {23, 21, 17} %this is from All_IVIMvDSC
%mask = MenaShenouda_Training_CSF_ROIs(tp,nm,slcs);

tp = '/Users/neuroimaging/Desktop/DATA/IVIM_PD/IVIM_20/Day1/'
nm = 'Scan 53 IVIM_sorted'
slcs = {25, 21, 19} %this is from All_IVIMvDSC
mask = MenaShenouda_Training_CSF_ROIs(tp,nm,slcs);

%{

tp = '/Users/neuroimaging/Desktop/DATA/IVIM_PD/IVIM_21/Day1/'
nm = 'Scan 34 IVIM_sorted'
slcs = {28, 24, 20} %this is from All_IVIMvDSC
mask = MenaShenouda_Training_CSF_ROIs(tp,nm,slcs);
%}

tp = '/Users/neuroimaging/Desktop/DATA/IVIM_PD/IVIM_23/Day1/'
nm = 'Scan 2_sorted'
slcs = {29, 27, 23} %this is from All_IVIMvDSC
mask = MenaShenouda_Training_CSF_ROIs(tp,nm,slcs);

%{
tp = '/Users/neuroimaging/Desktop/DATA/IVIM_PD/IVIM_24/Day1/'
nm = 'Scan 2_sorted'
slcs = {23, 21, 18} %this is from All_IVIMvDSC
mask = MenaShenouda_Training_CSF_ROIs(tp,nm,slcs);
%}

tp = '/Users/neuroimaging/Desktop/DATA/IVIM_PD/IVIM_25/Day1/'
nm = 'Scan 4_sorted'
slcs = {27, 21, 18} %this is from All_IVIMvDSC
mask = MenaShenouda_Training_CSF_ROIs(tp,nm,slcs);