UBUNTU_VERSION := 16.04
cn := openbts-b210

build:
	docker build --build-arg UBUNTU_VERSION=$(UBUNTU_VERSION) -t $(cn) .

shell:
	docker run --name $(cn) --rm -ti --network=host --privileged -v $$PWD:/data -v /dev:/dev $(cn) /bin/bash

shellanother:
	docker exec -ti $(cn) /bin/bash

run:
	docker run --name $(cn) --rm -ti --network=host --privileged -v $$PWD:/data -v /dev:/dev $(cn)

