#!/bin/bash

echo "Pulling update (If available)"
cd /srv/cst/mapping
git pull

#echo "Running mapcrafter"

#/srv/cst/mapping/software/mapcrafter-world113/src/mapcrafter --config /srv/cst/mapping/config/mapcrafter/main.conf

# lol

#echo "Running MC Overviewer"

#/srv/cst/mapping/software/overviewer/overviewer --config /srv/cst/mapping/config/overviewer/main.py

echo "Running Unmined"

# collect playernames for unmined display:
/srv/cst/mapping/scripts/uuid_to_name

# unmined Config:
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

/srv/cst/mapping/software/unmined/unmined-cli web render $um_wld_survival --mapsettings=$um_cfg_ow $um_common_options --output=$um_output_dir/survival/overworld
/srv/cst/mapping/software/unmined/unmined-cli web render $um_wld_survival --mapsettings=$um_cfg_ow_night $um_common_options --output=$um_output_dir/survival/overworld_night
/srv/cst/mapping/software/unmined/unmined-cli web render $um_wld_survival_nt --mapsettings=$um_cfg_nt_roof $um_common_options --output=$um_output_dir/survival/nether_roof
/srv/cst/mapping/software/unmined/unmined-cli web render $um_wld_survival_nt --mapsettings=$um_cfg_nt $um_common_options --output=$um_output_dir/survival/nether
/srv/cst/mapping/software/unmined/unmined-cli web render $um_wld_survival_end --mapsettings=$um_cfg_end $um_common_options --output=$um_output_dir/survival/theend

/srv/cst/mapping/software/unmined/unmined-cli web render $um_wld_creative --mapsettings=$um_cfg_ow $um_common_options --output=$um_output_dir/creative/overworld
/srv/cst/mapping/software/unmined/unmined-cli web render $um_wld_creative --mapsettings=$um_cfg_ow_night $um_common_options --output=$um_output_dir/creative/overworld_night
/srv/cst/mapping/software/unmined/unmined-cli web render $um_wld_creative_nt --mapsettings=$um_cfg_nt_roof $um_common_options --output=$um_output_dir/creative/nether_roof
/srv/cst/mapping/software/unmined/unmined-cli web render $um_wld_creative_nt --mapsettings=$um_cfg_nt $um_common_options $um_common_options --output=$um_output_dir/creative/nether
/srv/cst/mapping/software/unmined/unmined-cli web render $um_wld_creative_end --mapsettings=$um_cfg_end $um_common_options $um_common_options --output=$um_output_dir/creative/theend

/srv/cst/mapping/software/unmined/unmined-cli web render $um_wld_testing --mapsettings=$um_cfg_ow $um_common_options --output=$um_output_dir/testing/overworld
/srv/cst/mapping/software/unmined/unmined-cli web render $um_wld_testing --mapsettings=$um_cfg_ow_night $um_common_options --output=$um_output_dir/testing/overworld_night
/srv/cst/mapping/software/unmined/unmined-cli web render $um_wld_testing_nt --mapsettings=$um_cfg_nt_roof $um_common_options --output=$um_output_dir/testing/nether_roof
/srv/cst/mapping/software/unmined/unmined-cli web render $um_wld_testing_nt --mapsettings=$um_cfg_nt $um_common_options --output=$um_output_dir/testing/nether
/srv/cst/mapping/software/unmined/unmined-cli web render $um_wld_testing_end --mapsettings=$um_cfg_end $um_common_options --output=$um_output_dir/testing/theend
