FROM ubuntu:20.04

# install packages
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive TZ=America/Sao_Paulo apt-get install -qy \
  python \
  build-essential \
  pkg-config \
  checkinstall \
  git \
  itstool \ 
  libcurl4-gnutls-dev \
  libraptor2-dev \
  libasound2-dev \
  libgtk2.0-dev  \
  libsndfile1-dev \
  libarchive-dev \
  liblo-dev \
  libtag1-dev \
  vamp-plugin-sdk \
  librubberband-dev \
  libfftw3-dev \
  libaubio-dev \
  libxml2-dev \
  lv2-dev \
  libserd-dev \
  libsord-dev \
  libsratom-dev \
  liblilv-dev \
  libgtkmm-2.4-dev \
  libboost-dev \
  libglibmm-2.4-dev \
  liblrdf0-dev \
  libusb-1.0-0-dev \
  libcunit1-dev \
  libwebsocketpp-dev \
  libpangomm-1.4-dev \
  libsamplerate0-dev \
  libcppunit-dev \
  libudev-dev \
  libcwiid-dev \
  libxwiimote-dev \
  libwebsockets-dev \
  libjack-dev

RUN git clone --depth 1 --branch 6.9 https://github.com/Ardour/ardour.git /src
WORKDIR /src

RUN ./waf configure --with-backends=jack,alsa,dummy --libjack=weak --optimize --cxx11 --freedesktop --ptformat --no-phone-home
RUN ./waf build

CMD checkinstall -y -D --install=no --pkgname=ardour --pkgversion=1:6.9.0 --pkgrelease=2 --provides=ardour --nodoc ./waf install && \
    cp ardour_*.deb /src/target
