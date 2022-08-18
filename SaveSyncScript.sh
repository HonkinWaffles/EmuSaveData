#/bin/bash
#Script to sync save data with local server

## Note: There is no error correction


LOG=~/Documents/EmuSaveData/log.txt
EMULATOR=$1

NAS=/mnt/storage/Games/Save\ Data

function cemu {
    #Cemu (WiiU)
    CEMU_LOCAL=/home/deck/.local/share/Steam/steamapps/compatdata/1/pfx/drive_c/usr/save/
    CEMU_REMOTE="$NAS/WiiU/usr/save/"

    rsync -cur  "$CEMU_LOCAL" "$CEMU_REMOTE" 2>> $LOG
    rsync -cur "$CEMU_REMOTE" "$CEMU_LOCAL"  2>> $LOG
    echo $(date -u) "Backed up cemu" >> $LOG

}

function yuzu {
    #Yuzu (Switch)
    YUZU_LOCAL=/run/media/mmcblk0p1/Emulation/storage/yuzu/nand/
    YUZU_REMOTE="$NAS/Switch/"
    rsync -cur  "$YUZU_LOCAL" "$YUZU_REMOTE" 2>> $LOG
    rsync -cur "$YUZU_REMOTE" "$YUZU_LOCAL"  2>> $LOG
    echo $(date -u) "Backed up yuzu" >> $LOG
}

function dolphin {
    #Dolphin (Wii + GC)
    DOLPHIN_GC_LOCAL=/home/deck/.var/app/org.DolphinEmu.dolphin-emu/data/dolphin-emu/GC/
    DOLPHIN_STATESAVES_LOCAL=/home/deck/.var/app/org.DolphinEmu.dolphin-emu/data/dolphin-emu/StateSaves/
    DOLPHIN_WII_LOCAL=/home/deck/.var/app/org.DolphinEmu.dolphin-emu/data/dolphin-emu/Wii/
    DOLPHIN_GC_NAS="$NAS/Dolphin/GC/"
    DOLPHIN_STATESAVES_NAS="$NAS/Dolphin/StateSaves/"
    DOLPHIN_WII_NAS="$NAS/Dolphin/Wii/"

    rsync -cur "$DOLPHIN_GC_LOCAL" "$DOLPHIN_GC_NAS" 2>> $LOG
    rsync -cur "$DOLPHIN_GC_NAS" "$DOLPHIN_GC_LOCAL" 2>> $LOG

    rsync -cur "$DOLPHIN_STATESAVES_LOCAL" "$DOLPHIN_STATESAVES_NAS" 2>> $LOG
    rsync -cur "$DOLPHIN_STATESAVES_NAS" "$DOLPHIN_STATESAVES_LOCAL" 2>> $LOG

    rsync -cur "$DOLPHIN_WII_LOCAL" "$DOLPHIN_WII_NAS" 2>> $LOG
    rsync -cur "$DOLPHIN_WII_NAS" "$DOLPHIN_WII_LOCAL" 2>> $LOG
    echo $(date -u) "Backed up yuzu" >> $LOG
}

if [ -z "$1" ];
then
    echo $(date -u) "No option selected backing up everything" >> $LOG
    cemu
    yuzu
    dolphin
else
    echo $(date -u) "Backing up '$1'" >> $LOG
    $1
fi