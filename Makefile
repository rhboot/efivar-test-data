#
# Makefile
# Peter Jones, 2020-02-24 14:42
#

TESTDIRS = \
	   cmurf \
	   fedora-fwupd-lenovo \
	   mtd \
	   nvme-and-sata-0 \
	   nvme-and-sata-1 \
	   pmem-btt \
	   sata-and-4k-sas \
	   sata-on-sas-expander \
	   virtio \
	   virtio-and-ide-and-scsi \
	   vm-baytrail-x64-nosb \
	   vm-baytrail-x64-sb \
	   windows-ubuntu-manjaro-fedora \
	   xps13-9350 \
	   xps13-9380

test:
	@for x in $(TESTDIRS) ; do \
		echo $${x} ; \
		EFIVARFS_PATH=./$${x}/sys/firmware/efi/efivars/ efibootmgr -v ; \
	done

all : test

# vim:ft=make
#
