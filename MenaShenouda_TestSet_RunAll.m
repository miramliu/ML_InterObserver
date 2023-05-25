% Cases run
addpath /Users/neuroimaging/Desktop/MR-Code/IVIM_MachineLearning

%[~, ~, ~, ~, DA_model] = Binary_QDA_Classification('IVIM_Features_Day1_Normo_Updated_Handdrawn', 'Quadratic',3);
%% normo
% 22N
MenaShenouda_TestSet_ROIs('22','Scan 1_sorted', [23], 'Normo')
% 23N
MenaShenouda_TestSet_ROIs('23', 'Scan 1_sorted',[29,27,23], 'Normo' )
% 24N
MenaShenouda_TestSet_ROIs('24','Scan 2_sorted', [26,27,23], 'Normo' )
% 25N
MenaShenouda_TestSet_ROIs('25','Scan 2_sorted', [27,21,18], 'Normo' )
% 26N
MenaShenouda_TestSet_ROIs('26','Scan 07 IVIM_sorted', [26,23], 'Normo' )


%[~, ~, ~, ~, DA_model] = Binary_QDA_Classification('IVIM_Features_Day1_Hypercap_Updated_Handdrawn', 'Quadratic',3);
%% hyper
%21H
MenaShenouda_TestSet_ROIs('21','Scan 34 IVIM_sorted', [28,24,20], 'Hyper' )
%22H
MenaShenouda_TestSet_ROIs('22','Scan 2_sorted', [23], 'Hyper' )
% 23H
MenaShenouda_TestSet_ROIs('23','Scan 2_sorted', [29,27,23], 'Hyper' )
% 25H
MenaShenouda_TestSet_ROIs('25','Scan 4_sorted', [27,21,18], 'Hyper' )
% 26H
MenaShenouda_TestSet_ROIs('26','Scan 25 IVIM_sorted', [26, 23], 'Hyper' )


%[~, ~, ~, ~, DA_model] = Binary_QDA_Classification('IVIM_Features_Day2_Updated_Handdrawn', 'Quadratic',3);
%% post mcao
% 21P
MenaShenouda_TestSet_ROIs('21','Scan 28 IVIM_sorted', [27, 23, 21], 'PMCAO' )
% 22P
MenaShenouda_TestSet_ROIs('22','Scan2_sorted', [19], 'PMCAO' )

% 23P
MenaShenouda_TestSet_ROIs('23','Scan 2_sorted', [29,24,19], 'PMCAO' )
%24P
MenaShenouda_TestSet_ROIs('24','Scan 1_sorted', [21,18,15], 'PMCAO' )
%26P
MenaShenouda_TestSet_ROIs('26','Scan 23 IVIM_sorted', [25,19], 'PMCAO' )