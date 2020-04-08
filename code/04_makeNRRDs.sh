#!/usr/bin/env bash

#We need to convert to .nrrds

module load slicer/0,nightly

input_files=`ls /scratch/mjoseph/bids/STOPPD/derivatives/tractography/float/*nii.gz`
output_dir="/scratch/mjoseph/bids/STOPPD/derivatives/tractography/nrrd"
data_dir="/scratch/mjoseph/bids/STOPPD"

mkdir -vp $output_dir

for f in $input_files; do

  output_file=`echo ${output_dir}/$(basename ${f}) | sed 's/_eddy_fixed.nii.gz/_eddy_fixed.nrrd/'`
  if [ ! -e ${output_file} ]; then

    base_file=`echo $(basename ${f})`
    subject=`echo ${base_file} | head -n1 | cut -d "_" -f1`
    session=`echo ${base_file} | head -n1 | cut -d "_" -f2`
    data_file=`echo ${base_file} | sed 's/_eddy_fixed.nii.gz//'`

    DWIConvert \
      --inputVolume ${f} \
      --conversionMode FSLToNrrd \
      --inputBValues "${data_dir}/${subject}/${session}/dwi/${data_file}_dwi.bval" \
      --inputBVectors "${data_dir}/${subject}/${session}/dwi/${data_file}_dwi.bvec" \
      --outputVolume ${output_file}
  fi

done
