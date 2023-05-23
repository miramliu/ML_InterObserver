% Cases run
addpath /Users/neuroimaging/Desktop/MR-Code/IVIM_MachineLearning

[~, ~, ~, ~, DA_model] = Binary_QDA_Classification('IVIM_Features_Day1_Normo_Updated_Handdrawn', 'Quadratic',3);
%% normo
% 22N
IVIM_CSF_ML_Hemispheres('22','Scan 1_sorted', [23], 'Normo', DA_model)
% 23N
IVIM_CSF_ML_Hemispheres('23', 'Scan 1_sorted',[29,27,23], 'Normo',DA_model)
% 24N
IVIM_CSF_ML_Hemispheres('24','Scan 2_sorted', [26,27,23], 'Normo',DA_model)
% 25N
IVIM_CSF_ML_Hemispheres('25','Scan 2_sorted', [27,21,18], 'Normo',DA_model)
% 26N
IVIM_CSF_ML_Hemispheres('26','Scan 07 IVIM_sorted', [26,23], 'Normo',DA_model)


[~, ~, ~, ~, DA_model] = Binary_QDA_Classification('IVIM_Features_Day1_Hypercap_Updated_Handdrawn', 'Quadratic',3);
%% hyper
%21H
IVIM_CSF_ML_Hemispheres('21','Scan 34 IVIM_sorted', [28,24,20], 'Hyper',DA_model)
%22H
IVIM_CSF_ML_Hemispheres('22','Scan 2_sorted', [23], 'Hyper',DA_model)
% 23H
IVIM_CSF_ML_Hemispheres('23','Scan 2_sorted', [29,27,23], 'Hyper',DA_model)
% 25H
IVIM_CSF_ML_Hemispheres('25','Scan 4_sorted', [27,21,18], 'Hyper',DA_model)
% 26H
IVIM_CSF_ML_Hemispheres('26','Scan 25 IVIM_sorted', [26, 23], 'Hyper',DA_model)


[~, ~, ~, ~, DA_model] = Binary_QDA_Classification('IVIM_Features_Day2_Updated_Handdrawn', 'Quadratic',3);
%% post mcao
% 21P
IVIM_CSF_ML_Hemispheres('21','Scan 28 IVIM_sorted', [27, 23, 21], 'PMCAO',DA_model)
% 22P
IVIM_CSF_ML_Hemispheres('22','Scan2_sorted', [19], 'PMCAO',DA_model)

% 23P
IVIM_CSF_ML_Hemispheres('23','Scan 2_sorted', [29,24,19], 'PMCAO',DA_model)
%24P
IVIM_CSF_ML_Hemispheres('24','Scan 1_sorted', [21,18,15], 'PMCAO',DA_model)
%26P
IVIM_CSF_ML_Hemispheres('26','Scan 23 IVIM_sorted', [25,19], 'PMCAO',DA_model)