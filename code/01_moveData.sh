####################################################################################
#Name:         #01_moveData

#Last updated: #2020-04-22

#Description:  #Find and move preprocessed DWI data

#Submission:   #I run interactively in terminal

#Notes: 
               #Data processed with dmriprep, the 'in-house' DWI preprocessing pipeline
               #Outputs of dmriprep currently in MJ's folder, soon be in archive 
               #Michael's pre-processing code is here: 
               #https://github.com/nipreps/dmriprep/blob/d07d4b090097675ae7de8199963467d4d2258737/dmriprep/workflows/dwi/util.py#L117
####################################################################################

#make a new directory
mkdir -p /projects/ncalarco/thesis/SPINS/Slicer/data/01_dmriprep

#copy all dmriprep directories over to my own
#cp -r /archive/data/SPINS/pipelines/bids_apps /projects/ncalarco/thesis/SPINS/Slicer/data/01_dmriprep
cp -r /scratch/mjoseph/bids/SPINS/derivatives/dmriprep_new/sub-* /projects/ncalarco/thesis/SPINS/Slicer/data/01_dmriprep

#also make a copy of the QC folder, for posterity
cp /scratch/mjoseph/bids/SPINS/derivatives/dmriprep_new/QC /projects/ncalarco/thesis/SPINS/Slicer/data/01_dmriprepQC

#if desired, find all directories of phantoms and tests that should delete (I will keep for now)
cd /projects/ncalarco/thesis/SPINS/Slicer/data/01_dmriprep
find . -type d \( -name "*PHA" -o -name "*P00" -o -name "*999" -o -name "*998" \)

#count how many directories exist
ls | wc -l #468 

#write out the subject names with data
ls > /projects/ncalarco/thesis/SPINS/Slicer/txt_outputs/01_hasData.txt

#are any of these directories empty?
cd /projects/ncalarco/thesis/SPINS/Slicer/data/01_dmriprep
find . -mindepth 3 -type d -empty #none are empty

#count participants that have eddy -- 475 (so, some participants have session 2 data, as more eddy files than directories)
find /projects/ncalarco/thesis/SPINS/Slicer/data/01_dmriprep/*/*/dwi/ -name '*desc-eddy_dwi.nii.gz' | wc -l

#count participants that have brainsuite - 475 (same as eddy)
find /projects/ncalarco/thesis/SPINS/Slicer/data/01_dmriprep/*/*/dwi/ -name '*desc-brainsuite_dwi.nii.gz' | wc -l

#write out these lists, to ensure have all expected data
find /projects/ncalarco/thesis/SPINS/Slicer/data/01_dmriprep/*/*/dwi/ -name '*desc-eddy_dwi.nii.gz' > /projects/ncalarco/thesis/SPINS/Slicer/txt_outputs/01_hasEddy.txt
find /projects/ncalarco/thesis/SPINS/Slicer/data/01_dmriprep/*/*/dwi/ -name '*desc-brainsuite_dwi.nii.gz' > /projects/ncalarco/thesis/SPINS/Slicer/txt_outputs/01_hasBrainsuite.txt

####################################################################################
#in R, double check if raw data exists in archive, but I don't have eddy/brainsuite...
#see script https://github.com/navonacalarco/Slicer/blob/master/01b_checkNumbers.Rmd
####################################################################################

#note: found 4 missing participants as bad FreeSurfer (ZHP0063, ZHP0082, ZHP0125, ZHP0165) - will be re-run by MJ
  #"sub-ZHP0063" 
  #"sub-ZHP0082" 
  #"sub-ZHP0125" 
  #"sub-ZHP0165"

#if required, remove folders from participants with no data
#rm -r /projects/ncalarco/thesis/SPINS/Slicer/data/01_dmriprep/{CMP0198,sub-ZHP0063,sub-ZHP0082,sub-ZHP0125,sub-ZHP0165} #update subject IDs as required
