#!/bin/bash

rootdir=/srv/cst/mapping

cd $rootdir

echo "Pulling update (If available)"
git pull

if ! [ -z $1 ]; then
  worldPath=$1
fi

if ! [ -z $2 ]; then
  outputPath=$2
fi

#create a lockfile
if [ -f $rootdir/lockfile ]; then
  echo "Lockfile exists, exiting"
  exit 1
else
  touch $rootdir/lockfile
fi

echo "Running Unmined"

# Zip Template:
mkdir -p $rootdir/software/unmined/templates #create dir if not exists
rm -f $rootdir/software/unmined/templates/default.web.template.zip #remove old template
cd $rootdir/config/unmined/templates/default.web.template #change into template folder
zip -r $rootdir/software/unmined/templates/default.web.template.zip ./* #zip contents of folder

cd $rootdir

# collect playernames for unmined display:
./scripts/uuid_to_name

# unmined Config:
um_cli_bin="/srv/cst/mapping/software/unmined/unmined-cli"
unminedConfigDir="/srv/cst/mapping/config/unmined"
um_cfg_ow="$unminedConfigDir/worldsettings/overworld.json"
um_cfg_ow_night="$unminedConfigDir/worldsettings/overworld_night.json"
um_cfg_ow_inh="$unminedConfigDir/worldsettings/overworld_inhabited.json"
um_cfg_nt="$unminedConfigDir/worldsettings/nether.json"
um_cfg_nt_roof="$unminedConfigDir/worldsettings/nether_roof.json"
um_cfg_nt_inh="$unminedConfigDir/worldsettings/nether_inhabited.json"
um_cfg_end="$unminedConfigDir/worldsettings/the_end.json"
um_common_options="--zoomout=6 --zoomin=3 --background=#000000 --chunkprocessors=6 --players"

#unmined worlds
um_wld="--world=$worldPath"
um_wld_nt="$um_wld --dimension=-1"
um_wld_end="$um_wld --dimension=1"

$um_cli_bin web render $um_wld_testing --mapsettings=$um_cfg_ow $um_common_options --output=$outputPath/overworld
$um_cli_bin web render $um_wld_testing --mapsettings=$um_cfg_ow_night $um_common_options --output=$outputPath/overworld_night
$um_cli_bin web render $um_wld_testing_nt --mapsettings=$um_cfg_nt_roof $um_common_options --output=$outputPath/nether_roof
$um_cli_bin web render $um_wld_testing_nt --mapsettings=$um_cfg_nt $um_common_options --output=$outputPath/nether
$um_cli_bin web render $um_wld_testing_end --mapsettings=$um_cfg_end $um_common_options --output=$outputPath/theend

# remove lockfile
rm -f /srv/cst/mapping/lockfile
