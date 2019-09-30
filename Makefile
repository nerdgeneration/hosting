ifeq ($(PREFIX),)
    PREFIX := /usr/local
endif
ifeq ($(shell which docker),)
	$(warning "Docker is required if you want to run tests")
endif
INSTALLOPS := --owner=root --group=root --mode=u=rw,go=r

.PHONY: hosting install test

hosting:
	@echo " _                  _    _"
	@echo "| |__    ___   ___ | |_ (_) _ __    __ _"
	@echo "| '_ \  / _ \ / __|| __|| || '_ \  / _' |"
	@echo "| | | || (_) |\__ \| |_ | || | | || (_| |"
	@echo "|_| |_| \___/ |___/ \__||_||_| |_| \__, |"
	@echo "© n e r d g e n e r a t i o n 2019 |___/"
	@echo ""
	@echo "Really simple AWS/AMI multi-tenant hosting"
	@echo "@author Mark Griffin <mark.griffin@linux.com>"
	@echo ""
	@echo "make install - install to PREFIX, defaults to /usr/local"
	@echo "make test    - run a testsuite in a Docker container"

install:
	install ${INSTALLOPTS} --directory ${PREFIX}/lib/hosting{,/assets,/assets/skel,/assets/skel/public}
	install ${INSTALLOPTS} lib ${PREFIX}/hosting

test-deps/bats:
	printf "\e[34mInfo:\e[0m %s\n" "Downloading bats testing framework into deps..."
	git clone https://github.com/sstephenson/bats.git test-deps/bats

test: test-deps/bats
	docker build -f test-assets/Dockerfile -t nerdgeneration/hosting-testsuite . \
		&& docker run --cap-add SYS_ADMIN -it nerdgeneration/hosting-testsuite