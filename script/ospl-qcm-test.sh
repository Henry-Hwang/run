#!/bin/bash
tinymix "FBProtect Port" "SEC_MI2S_RX"
sleep 1
tinymix "CIRRUS GB ENABLE" "Config GB Disable"
sleep 1
tinymix "SEC_MI2S_RX Audio Mixer MultiMedia1" 1
sleep 1
tinymix "CIRRUS GB ENABLE" "Config GB Enable"
sleep 1
tinymix "CIRRUS GB EXT CONFIG" "Config RX New"
sleep 1
tinymix "CIRRUS GB EXT CONFIG" "Config TX New"
sleep 1
tinymix "CIRRUS GB CONFIG" "Path_for_Music"
sleep 1	
tinyplay /data/cirrus/NanHaiGuNiang.wav