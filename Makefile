-include .settings.mk

help:
	@echo The following makefile targets are available:
	@echo
	@grep -e '^\w\S\+\:' Makefile | sed 's/://g' | cut -d ' ' -f 1
		
all: clean build publish refresh-ipns ipfs-pin
	@echo OK

clean:
	@rm -rf _site _build

build:
	@echo "build start"
	@./bin/build-pandoc.sh $(STYLE)
	@echo "build finished"
	@echo

publish:
	@echo "publish start"
	@IPFS_API=$(IPFS_API) ./bin/add-ipfs.sh -k $(IPFS_KEY) -f _site/index.html
	@echo "publish finished"
	@echo

refresh-ipns:
	@IPFS_API=$(IPFS_API) ./bin/add-ipfs.sh -k $(IPFS_KEY) -p

ipfs-pin:
	./bin/ipfs-pin.sh $(IPFS_HOST_1)
	./bin/ipfs-pin.sh $(IPFS_HOST_2)
	./bin/ipfs-pin.sh $(IPFS_HOST_3)

key:
	@ipfs --api=$(IPFS_API) key gen $(IPFS_KEY)

open:
	@open _site/index.html

.PHONY: assets
assets:
	@IPFS_API=$(IPFS_API) ./bin/add-ipfs.sh -k $(IPFS_KEY) -f assets/arbitrum-dao-stip-results.html
	@IPFS_API=$(IPFS_API) ./bin/add-ipfs.sh -k $(IPFS_KEY) -p

build-readme:
	@./bin/build-pandoc.sh default Readme.md
