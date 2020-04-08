#!/usr/bin/env python
import nibabel as nb
import numpy as np
import os
from glob import glob

#We need to convert all of the eddy-corrected images to 'ints', and remove the decimal place
#The reason for this is that dtiprep doesn't allow for decimal places that eddy produces???

input_dir   = "/scratch/mjoseph/bids/STOPPD/derivatives/tractography/eddy"
output_dir  = "/scratch/mjoseph/bids/STOPPD/derivatives/tractography/float"

eddy_files = sorted(glob(f"{input_dir}/*nii.gz"))
for f in eddy_files:

    base_file = os.path.basename(f).replace("_desc-preproc_dwi.nii.gz", "")
    output_file = os.path.join(output_dir, base_file + "_eddy_fixed.nii.gz")

    if not os.path.isfile(output_file):
        img = nb.load(f)
        data = img.get_fdata().astype(np.int16)
        new_img = nb.Nifti1Image(data, img.affine, img.header)
        new_img.header.set_data_dtype(np.int16)
        new_img.to_filename(output_file)
