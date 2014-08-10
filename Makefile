VERSION="Tetra-`git rev-parse --short HEAD`-`uname`-`uname -m`"

.PHONY: build clean run package docker-build docker-run test

build:
	go build

clean:
	rm Tetra

run:
	@make build
	./Tetra

all:
	@make run

package:
	@echo "Building ${VERSION}..."
	@make build
	@echo "Setting up build prefix"
	@mkdir build
	@echo "Packing ${VERSION}..."
	@upx Tetra
	@cp Tetra build
	@echo "Packing modules..."
	@cp -rf modules build
	@rm build/modules/doc.go
	@mkdir build/doc
	@echo "Bundling documentation..."
	@godocdown ./modules > build/doc/modules.md
	@godocdown ./atheme > build/doc/atheme.md
	@godocdown ./1459 > build/doc/1459.md
	@godocdown ./bot > build/doc/bot.md
	@mkdir build/etc
	@cp etc/config.yaml.example build/etc
	@cp README.md build
	@cp LICENSE build
	@mv build ${VERSION}
	@tar czf ${VERSION}.tgz ${VERSION}
	@rm -rf ${VERSION}
	@echo "Package at ${VERSION}.tgz"

docker-build:
	docker build -t xena/tetra .

docker-run:
	@make build
	docker run --rm --link tetra-ircd:ircd -it --name tetra xena/tetra .

test:
	make -C test test-build test-docker

