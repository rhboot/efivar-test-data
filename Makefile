#
# Makefile
# Peter Jones, 2020-02-24 14:42
#

TESTDIRS =

test:
	@for x in $(TESTDIRS) ; do \
		echo $${x} ; \
		EFIVARFS_PATH=./$${x}/sys/firmware/efi/efivars/ efibootmgr -v ; \
	done

all : test

# vim:ft=make
#
