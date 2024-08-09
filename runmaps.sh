#!/bin/bash

rootdir=/srv/cst/mapping

cd $rootdir

echo "Pulling update (If available)"
git pull

if ! [ -z $1 ]; then
  onlyConfigX=$1
fi

#create a lockfile
if [ -f $rootdir/lockfile ]; then
  echo "Lockfile exists, exiting"
  exit 1
else
  touch $rootdir/lockfile
fi

#echo "Running mapcrafter"

#/srv/cst/mapping/software/mapcrafter-world113/src/mapcrafter --config /srv/cst/mapping/config/mapcrafter/main.conf

# lol

#echo "Running MC Overviewer"

#/srv/cst/mapping/software/overviewer/overviewer --config /srv/cst/mapping/config/overviewer/main.py

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
um_output_dir="/srv/cst/mapping/output/unmined"
um_cfg_ow="$unminedConfigDir/worldsettings/overworld.json"
um_cfg_ow_night="$unminedConfigDir/worldsettings/overworld_night.json"
um_cfg_ow_inh="$unminedConfigDir/worldsettings/overworld_inhabited.json"
um_cfg_nt="$unminedConfigDir/worldsettings/nether.json"
um_cfg_nt_roof="$unminedConfigDir/worldsettings/nether_roof.json"
um_cfg_nt_inh="$unminedConfigDir/worldsettings/nether_inhabited.json"
um_cfg_end="$unminedConfigDir/worldsettings/the_end.json"
um_common_options="--zoomout=6 --zoomin=3 --background=#000000 --chunkprocessors=6 --players"

#unmined worlds
um_wld_survival="--world=/srv/cst/survival/world"
um_wld_survival_nt="$um_wld_survival --dimension=-1"
um_wld_survival_end="$um_wld_survival --dimension=1"

um_wld_creative="--world=/srv/cst/creative/world"
um_wld_creative_nt="$um_wld_creative --dimension=-1"
um_wld_creative_end="$um_wld_creative --dimension=1"

um_wld_testing="--world=/srv/cst/testing/world"
um_wld_testing_nt="$um_wld_testing --dimension=-1"
um_wld_testing_end="$um_wld_testing --dimension=1"

if [ -z $onlyConfigX ] || [ "$onlyConfigX" = "survival" ]; then
  $um_cli_bin web render $um_wld_survival --mapsettings=$um_cfg_ow $um_common_options --output=$um_output_dir/survival/overworld
  $um_cli_bin web render $um_wld_survival --mapsettings=$um_cfg_ow_night $um_common_options --output=$um_output_dir/survival/overworld_night
  $um_cli_bin web render $um_wld_survival_nt --mapsettings=$um_cfg_nt_roof $um_common_options --output=$um_output_dir/survival/nether_roof
  $um_cli_bin web render $um_wld_survival_nt --mapsettings=$um_cfg_nt $um_common_options --output=$um_output_dir/survival/nether
  $um_cli_bin web render $um_wld_survival_end --mapsettings=$um_cfg_end $um_common_options --output=$um_output_dir/survival/theend
fi

if [ -z $onlyConfigX ] || [ "$onlyConfigX" = "creative" ]; then
  $um_cli_bin web render $um_wld_creative --mapsettings=$um_cfg_ow $um_common_options --output=$um_output_dir/creative/overworld
  $um_cli_bin web render $um_wld_creative --mapsettings=$um_cfg_ow_night $um_common_options --output=$um_output_dir/creative/overworld_night
  $um_cli_bin web render $um_wld_creative_nt --mapsettings=$um_cfg_nt_roof $um_common_options --output=$um_output_dir/creative/nether_roof
  $um_cli_bin web render $um_wld_creative_nt --mapsettings=$um_cfg_nt $um_common_options --output=$um_output_dir/creative/nether
  $um_cli_bin web render $um_wld_creative_end --mapsettings=$um_cfg_end $um_common_options --output=$um_output_dir/creative/theend
fi

if [ -z $onlyConfigX ] || [ "$onlyConfigX" = "testing" ]; then
  $um_cli_bin web render $um_wld_testing --mapsettings=$um_cfg_ow $um_common_options --output=$um_output_dir/testing/overworld
  $um_cli_bin web render $um_wld_testing --mapsettings=$um_cfg_ow_night $um_common_options --output=$um_output_dir/testing/overworld_night
  $um_cli_bin web render $um_wld_testing_nt --mapsettings=$um_cfg_nt_roof $um_common_options --output=$um_output_dir/testing/nether_roof
  $um_cli_bin web render $um_wld_testing_nt --mapsettings=$um_cfg_nt $um_common_options --output=$um_output_dir/testing/nether
  $um_cli_bin web render $um_wld_testing_end --mapsettings=$um_cfg_end $um_common_options --output=$um_output_dir/testing/theend
fi

# remove lockfile
rm -f /srv/cst/mapping/lockfile
