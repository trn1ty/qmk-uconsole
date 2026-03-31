#!/usr/bin/env -S make -f

clockworkpi_uconsole_default.bin: qmk_firmware/.build/clockworkpi_uconsole_default.bin
	mv qmk_firmware/.build/clockworkpi_uconsole_default.bin $@

qmk_firmware/.build/clockworkpi_uconsole_default.bin: qmk_firmware
	sh -c 'cd qmk_firmware; qmk compile -kb clockworkpi/uconsole -km default'

qmk_firmware:
	rm -rf $@.tmp
	git clone --depth 1 https://github.com/qmk/qmk_firmware.git $@.tmp
	git -C qmk_firmware.tmp submodule sync --recursive
	git -C qmk_firmware.tmp submodule update --init --recursive
	mv $@.tmp $@
	ln -s $(PWD)/clockworkpi $(PWD)/qmk_firmware/keyboards/
