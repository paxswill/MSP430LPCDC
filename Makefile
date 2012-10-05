cwd  := $(shell pwd)

all: build
	# make install - to quickly install in root without using the installer package
	# make pkg     - to make build/USB-CDC-Drivers.pkg
	# make clean   - to delete build and /tmp/AppleUSBCDC.dst

build:
	xcodebuild

install: build
	sudo xcodebuild -buildstyle Deployment install DSTROOT=/
	# clean up root-owned files in build
	sudo rm -rf build
	sudo chown -R root:wheel /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/AppleUSBCDC.kext
	sudo chown -R root:wheel /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/AppleUSBCDCACMControl.kext
	sudo chown -R root:wheel /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/AppleUSBCDCACMData.kext
	sudo chown -R root:wheel /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/AppleUSBCDCECMControl.kext
	sudo chown -R root:wheel /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/AppleUSBCDCECMData.kext
	sudo chown -R root:wheel /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/AppleUSBCDCWCM.kext
	sudo chown -R root:wheel /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/AppleUSBCDCDMM.kext
	sudo rm -rf /System/Library/Caches/com.apple.kernelcaches
	sudo rm -rf /System/Library/Extensions.kextcache
	sudo rm -rf /System/Library/Extensions.mkext

pkg: build
	$(MAKE) -C Package

clean:
	$(MAKE) -C Package clean
	rm -rf build

