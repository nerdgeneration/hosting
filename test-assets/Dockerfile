# Dockerfile for hosting tests
# @author Mark Griffn <mark.griffin@linux.com>

FROM amazonlinux:2

COPY src/hosting /usr/bin/hosting
COPY src/lib /usr/lib/hosting
COPY test-assets /root/test-assets
COPY test-deps /root/test-deps

RUN /root/test-deps/bats/install.sh /usr

CMD ["/bin/bash"]
# CMD ["/root/hosting.bats"]