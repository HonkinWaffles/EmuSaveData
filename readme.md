### EmuSaveData

Note: Emudeck has not baked this feature into the product. 

This script syncs some Emulator save data between the Steam Deck and a local NAS. Not only does this provide a good backup for your important save data but allows for save data sync between the Steam deck and other devices (Such as desktop or even mobile).

The script can be run every time you open and close the emulator to create a seamless experience between the Steam Deck and other devices 

---

## Warning
The script makes some bold assumptions and is tailored for my specific setup. This means you MUST edit the script to suit your needs.

---

### Instructions

1. Clone this repository into your Documents folder on the steam deck
1. Setup `fstab` to automount your NAS on boot
    * Example: `//10.69.1.2/storage/ /mnt/storage/ cifs credentials=/home/deck/Documents/smb_credentials.txt,guest,iocharset=utf8,file_mode=0777,dir_mode=0777,x-systemd.automount,x-systemd.mount-timeout=30,_netdev 0 0`
1. Update the `NAS` variable with the local path to your NAS
    * It is a good idea to check the paths in all the variables to ensure that they are correct
1. For each launch script created by [EmuDeck](https://github.com/dragoonDorise/EmuDeck) (located in `Emulation/tools/launchers/`) Add the following to the top, `/bin/bash /home/deck/Documents/EmuSaveData/SaveSyncScript.sh EMULATOR_NAME`
    * Currently setup Emulators
        * `cemu.sh`
        * `yuzu.sh`
        * `dolphin-emu.sh`
1. In Steam edit the launch options to include `; /bin/bash /dome/deck/Documents/EmuSaveData/SaveSyncScript.sh EMULATOR_NAME` (You must include the `;`)
1. Launch the Emulator and check the logs for `rsync` status


---

### ToDo:
1. Add error correction
1. Add more emulators 
1. Add a VPN connection script for remote updating
