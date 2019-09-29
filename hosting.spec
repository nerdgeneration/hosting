Name:           hosting
Version:        0.1-alpha
Release:        1%{?dist}
Summary:        Simple (in features, not usability) multi-tenant hosting platform for "Amazon Linux 2"

License:        Not Licenced
URL:            https://github.com/nerdgeneration/hosting.git
Source0:

BuildRequires:
Requires: docker nginx

%description
A simple (in features, not usability) multi-tenant hosting platform for "Amazon
Linux 2". Supports static files, PHP FastCGI, Node and Docker.

%install
rm -rf $RPM_BUILD_ROOT
%make_install

%files
%{_bindir}/%{name}
%{_libdir}/%{name}/assets/skel/public/index.html
%{_libdir}/%{name}/assets/nginx.conf
%{_libdir}/%{name}/assets/systemd.service
%{_libdir}/%{name}/lib/msg.sh

%doc
%{_mandir}/%{name}.1

%changelog
* Tue Oct 1 2019 Mark Griffin <mark.griffin@linux.com>
- Packaging and testing