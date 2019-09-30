# Dockerfile for hosting tests
# @author Mark Griffn <mark.griffin@linux.com>

FROM amazonlinux:2

COPY bin/hosting /usr/bin/hosting
COPY lib/hosting /usr/lib/hosting
COPY man/hosting.1 /usr/share/man/hosting.1
COPY test-assets /root/test-assets
COPY test-deps /root/test-deps

RUN /root/test-deps/bats/install.sh /usr
RUN /usr/bin/hosting setup

CMD ["/bin/bash"]
# CMD ["/root/test-assets/hosting.bats"]