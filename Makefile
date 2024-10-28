# get raspbian image

old = https://downloads.raspberrypi.org/raspbian_lite/images/raspbian_lite-2017-01-10/2017-01-11-raspbian-jessie-lite.zip
current = https://downloads.raspberrypi.org/raspbian_lite_latest
raspios = https://downloads.raspberrypi.com/raspios_lite_armhf/images/raspios_lite_armhf-2024-07-04/2024-07-04-raspios-bookworm-armhf-lite.img.xz

timestamp = $(date '+%Y%m%d.%H%M%S')


get-all: get get-old get-raspios

get:
	wget $(current) -O raspbian_lite_latest.zip
	unzip raspbian_lite_latest.zip
	rm -f raspbian_lite_latest.zip
	mv *.img images/
	cd images/ && \
	ln -s *.img base.img

get-old:
	wget $(old) -O raspbian_lite-2017-01-10.zip
	unzip raspbian_lite-2017-01-10.zip
	rm -f raspbian_lite-2017-01-10.zip
	mv *.img images/
	cd images && \
	ln -s *.img old.img

get-raspios:
	wget $(raspios) -O raspios_lite_armhf-2024-07-04.img.xz
	unxz raspios_lite_armhf-2024-07-04.img.xz
	rm -f raspios_lite_armhf-2024-07-04.img.xz
	mv *.img images/
	cd images && \
	ln -s *.img raspios.img

base-all: build build-old build-raspios

base:
	cd build/ && \ 
	sudo ./mount-image.sh base.img & \ 
	./base.sh && \
	cp ../images/base.img work/piscan-base.$(timestamp).img

base-old:
	cd build/ && \
	sudo ./mount-image.sh old.img && \
	./base.sh && \
	cp ../images/old.img work/piscan-old.$(timestamp).img

base-raspios:
	cd build/ && \
	sudo ./mount-image.sh raspios.img && \
	./base.sh && \
	cp ../images/raspios.img work/piscan-raspios.$(timestamp).img

piscan:
	cd build/ && \
	sudo ./mount-image.sh work/piscan-base.*.img && \
	./install.sh

release: unmount	
	mv build/work/piscan-base.*.img ../releases/piscan.$(timestamp).img
 
unmount:
	sudo umount build/mnt

clean: unmount
	rm -f *.img *.zip *.xz
	rm -f images/*.img *.zip *.xz
