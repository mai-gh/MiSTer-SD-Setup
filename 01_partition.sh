export DISK=/dev/mmcblk0
export UBOOT_PART="$DISK"p2
export DATA_PART="$DISK"p1
export MNT_DIR=/mnt/usb

echo -e "4096;\n2048,2048" | sfdisk --wipe always $DISK
sfdisk --part-type $DISK 1 7
sfdisk --part-type $DISK 2 a2
dd if=./release_20220413/files/linux/uboot.img of=$UBOOT_PART bs=32k
mkfs.exfat -s 32 -n "MiSTer_Data" $DATA_PART
sync
mount -t exfat $DATA_PART $MNT_DIR
cp -Rv ./release_20220413/files/* $MNT_DIR
sync
umount $MNT_DIR
