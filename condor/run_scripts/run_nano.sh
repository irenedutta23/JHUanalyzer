#!/bin/bash
echo "Run script starting"
source /cvmfs/cms.cern.ch/cmsset_default.sh
xrdcp root://cmseos.fnal.gov//store/user/lcorcodi/10XwithNano.tgz ./
export SCRAM_ARCH=slc6_amd64_gcc700
scramv1 project CMSSW CMSSW_10_2_13
tar -xzf 10XwithNano.tgz
rm 10XwithNano.tgz

mkdir tardir; cp tarball.tgz tardir/; cd tardir
tar -xzf tarball.tgz
cp -r hhTrees/* ../CMSSW_10_2_13/src/JHUanalyzer/hhTrees/
cd ../CMSSW_10_2_13/src/JHUanalyzer/hhTrees
ls ../../PhysicsTools/NanoAODTools
eval `scramv1 runtime -sh`

echo hhTreeMaker.py $*
python hhTreeMaker.py $*
# dirname="$1-$4_$2-$3/*.root"
# echo $dirname
# outname="bstarTrees_$1-$4_$2-$3.root"
# python haddnano.py $outname $dirname
# xrdcp -f $outname root://cmseos.fnal.gov//store/user/lcorcodi/bstar_nano/
