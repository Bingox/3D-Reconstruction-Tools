# 3D-Reconstruction-Tools
Some shell scripts for 3d reconstruction, using VLFeat, Bundler and PMVS/CMVS.

We combine the following software to do 3d reconstruction.

VLFeat: http://www.vlfeat.org/
---for SIFT(Scale-Invariant Feature Transform).

Bundler: https://github.com/snavely/bundler_sfm
Bundler cmake version: https://github.com/TheFrenchLeaf/Bundler
---for SFM sparse reconstruction.

PMVS/CMVS: http://www.di.ens.fr/cmvs/
---for dense reconstruction.

We also reference the Nghia Ho's RunSFM software (http://nghiaho.com/)

Here we only give our modification and patches.
We replace the UBC (D. Lowe's) sift tool with the VLFeat in the software Bundler. Since they have different data structures of SIFT descriptor, we give a script to convert the VLFeat's to D. Lowe's to fit the Bundler. In addition, the VLFeat supports controling the number of SIFT keypoints by providing a parameter named peak_threshold.

These shells support parallel computing of SIFT.

Usage: run the following command in image folder.
> mRunSFM.sh [PEAK_THRESH] [IMAGES_PER_CLUSTER] [CPU_CORES] [MAX_MATCHING_SEQ]


Thanks all the people who have contributed to the 3d reconstruction.
