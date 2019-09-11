all : kernel gadget ubuntu-core-image
.PHONY: all gadget kernel ubuntu-core-image clean-gadget clean-kernel clean-ubuntu-core-image

kernel: 
	@echo "Building kernel snap"
	@cd kernel && sudo snapcraft --target-arch armhf

clean-kernel:
	@echo "Cleaning kernel snap"
	@cd kernel && sudo snapcraft clean
	@rm -r kernel/*.snap

gadget: 
	@echo "Building gadget snap"
	@cd gadget && sudo snapcraft

clean-gadget:
	@echo "cleaning gadget snap"
	@cd gadget && sudo snapcraft clean
	@rm -r gadget/*.snap

ubuntu-core-image: kernel gadget 
	@echo "Building Ubuntu Core Image"
	@sudo ubuntu-image -d -c stable -O imagefile --extra-snaps kernel/altran-olimex-kernel_0.1_armhf.snap --extra-snaps gadget/altran-olimex-gadget_0.1_armhf.snap \
	       	model/olimex-lime2.model -w prepare/
clean-ubuntu-core-image:
	@echo "Cleaning Ubuntu Core Image"
	@rm -r imagefile

clean: clean-kernel clean-gadget clean-ubuntu-core-image
