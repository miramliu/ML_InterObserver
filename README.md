# ML_InterObserver
 
Machine Learning analysis for adding inter-observer comparison. 

This is to get a second trained human operator to draw ROIs of both training/testing set used...
in nested loocv & discriminant analysis... and the independent testing-only set for publication. 


# MenaShenouda_TestSet_RunAll
This is called for MS to run hemispheric ROIs that AVOID CSF.\ 
Runs MenaShenouda_TestSet_ROIs on list of cases and slices per\
These were done on the ROIs for testing on completely independent data (was not in nested loocv training or testing sets)







# MenaShenouda_Training_CSF_RunAll
This is used to get the CSF ROIs that were used for LOOCV discriminant analysis\
Calls on MenaShenouda_Training_CSF_ROIs\
to run (not neatly at all), copy paste each section of four lines into commmand line. 
done just for checks and balances and to be able to take a break and stuff. 

Example: 

>> tp = '/Users/neuroimaging/Desktop/DATA/IVIM_PD/IVIM_13/Day1/'
>> nm = 'SE02_IVIM_sorted'
>> slcs = {21, 19, 17} %this is from All_IVIMvDSC
>> mask = MenaShenouda_Training_CSF_ROIs(tp,nm,slcs);

Should then save CSF mask volume. CSF_Mask_foldername_MS.mat



# IVIMHemCasesRun_MS
These are used to get the hemispheric ROIs that AVOID csf that were used for the final comparison to perfusion. 
It shall be run after MS has completed his ROIs