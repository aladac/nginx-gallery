Name:           nginx-gallery
Version:        1.0.1
Release:        1%{?dist}
Summary:        Simple photo/video gallery using nginx autoindex and XSLT

License:        MIT
URL:            https://github.com/aladac/nginx-gallery
Source0:        %{name}-%{version}.tar.gz

BuildArch:      noarch
Requires:       nginx

%description
A lightweight gallery solution that uses nginx's built-in autoindex
module with XSLT transformation to display images and videos in a
responsive grid layout.

Features:
- Grid layout for images and videos
- Breadcrumb navigation
- Lazy loading for images
- Dark theme
- Supports mp4, webm, mkv, avi, wmv, flv, ogv video formats

Requires nginx compiled with ngx_http_xslt_module.

%prep
%setup -q

%install
mkdir -p %{buildroot}%{_datadir}/%{name}/css
mkdir -p %{buildroot}%{_datadir}/%{name}/webfonts
mkdir -p %{buildroot}%{_docdir}/%{name}/examples

install -m 644 nginx-gallery.xslt %{buildroot}%{_datadir}/%{name}/
install -m 644 css/style.css %{buildroot}%{_datadir}/%{name}/css/
install -m 644 webfonts/fonts.woff2 %{buildroot}%{_datadir}/%{name}/webfonts/
install -m 644 debian/nginx-gallery.conf %{buildroot}%{_docdir}/%{name}/examples/
install -m 644 README.md %{buildroot}%{_docdir}/%{name}/

%files
%license LICENSE
%doc README.md
%{_datadir}/%{name}/
%{_docdir}/%{name}/examples/

%changelog
* Thu Feb 06 2026 Adam Ladachowski <adam@saiden.pl> - 1.0.0-1
- Initial release
- Self-contained CSS and fonts (no CDN dependencies)
- Grid layout with lazy loading
- Dark theme with breadcrumb navigation
- Video support for mp4, webm, mkv, avi, wmv, flv, ogv
