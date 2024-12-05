## fMRI Preprocessing Pipeline

The fMRI spatial preprocessing pipeline has been developed based on the [SPM12](https://www.fil.ion.ucl.ac.uk/spm/software/spm12/) and [CAT12](https://neuro-jena.github.io/cat/). 
This pipeline consists of the following steps: 

- Slice Timing Correction 
- Susceptibility distortion correction
  - VDM calculation based on the fieldmap phase and amplitude data. 
- Realignment and Unwarp
  - Simultaneous realignment of functional volumes and applying VDM.
- Segmentation of the structural data
  - It also creates a bias-corrected T1 image, normalizes it and all the extracted tissue masks to the MNI space, and outputs the forward and inverse transformation parameters.
- Coregistration of the functional data into the T1 image.
  - It aligns the functional data to the bias-corrected T1 image.
- Normalization to the MNI space
  - It uses the forward transformation parameters of the segmentation step, to normalize the functional data into the MNI space. 
- Smoothing 

I tried to make this pipeline as automatic as possible. You just need to set some directories and acquisition parameters, run the pipeline, and sit and drink your coffee!

### Practical Info: 

- In this pipeline, the **CAT12** has been used for the segmentation as it gives more precise results than the **SPM** segmentation. So, make sure that you have downloaded the [CAT12](https://neuro-jena.github.io/cat/) package and have put it in the **SPM toolbox** folder.
- In this pipeline, the **ART** toolbox has been used for outlier volume detection. So, make sure that you have downloaded the [Artifact Detection Tools (ART)](https://www.nitrc.org/projects/artifact_detect/) and have added its directory to the Matlab paths.
- Some of the subjects were scanned in a *Prisma* scanner, and others in a *Vida* scanner. This information has been included in the file names as: `acq-pris` and `acq-vida`.   
- The pipeline considers that your data is organized in the BIDS format as follows:
  ```
  Data_dir -->
              sub-XXX
              sub-YYY
              .
              .
              .
              sub-ZZZ -->
                         ses-xxx
                         ses-yyy
                         .
                         .
                         .
                         ses-zzz -->
                                    anat -->
                                            sub-ZZZ_ses-zzz_acq-pris_T1w.json
                                            sub-ZZZ_ses-zzz_acq-pris_T1w.nii
                                    fmap -->
                                            sub-ZZZ_ses-zzz_acq-pris_magnitude1.json
                                            sub-ZZZ_ses-zzz_acq-pris_magnitude1.nii
                                            sub-ZZZ_ses-zzz_acq-pris_magnitude2.json
                                            sub-ZZZ_ses-zzz_acq-pris_magnitude2.nii
                                            sub-ZZZ_ses-zzz_acq-pris_magnitude1.json
                                            sub-ZZZ_ses-zzz_acq-pris_phasediff.json
                                            sub-ZZZ_ses-zzz_acq-pris_phasediff.nii
                                    func -->
                                            sub-ZZZ_ses-zzz_acq-pris_task-rest_bold.json
                                            sub-ZZZ_ses-zzz_acq-pris_task-rest_bold.nii
  ```
- To run the pipeline, open the `preprocessing.m` file, set the requested directories and parameters, and run the file.
- If you need to change the hyperparameters of different preprocessing steps, open the `func_PreprocBatch.m` file and set the parameters with your values accordingly.