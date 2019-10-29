APP=pg-tools
NS=texastribune

VERSIONS = 9.4 9.5 9.6 10 11
SCRIPTS = *.sh

prepare:
	@for version in $(VERSIONS); do \
		mkdir -p $$version; \
		sed "s/%%POSTGRES_VERSION%%/$$version/g" Dockerfile.template > $$version/Dockerfile; \
		cp $(SCRIPTS) $$version; \
	done

build:
	@for version in $(VERSIONS); do \
		docker build --tag=${NS}/${APP}:$$version $$version; \
	done
