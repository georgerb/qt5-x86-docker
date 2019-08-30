FROM i386/ubuntu:18.04
ARG QT_MINOR=12
ARG QT_BUILD=4

ENV DEBIAN_FRONTEND noninteractive

ENV Qt5_DIR /Qt/5.${QT_MINOR}.${QT_BUILD}

RUN apt-get update 

RUN apt-get install -y wget cmake libx11-xcb-dev libxkbcommon-dev freeglut3-dev libxcb-xinerama0-dev libfontconfig1-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev libgstreamer-plugins-good1.0-dev python-dev pkg-config libegl1-mesa-dev libglib2.0-dev libfreetype6-dev libicu-dev gstreamer1.0-libav net-tools libts0 build-essential

RUN wget https://download.qt.io/official_releases/qt/5.${QT_MINOR}/5.${QT_MINOR}.${QT_BUILD}/single/qt-everywhere-src-5.${QT_MINOR}.${QT_BUILD}.tar.xz

RUN tar xvf qt-everywhere-src-5.${QT_MINOR}.${QT_BUILD}.tar.xz

WORKDIR /qt-everywhere-src-5.${QT_MINOR}.${QT_BUILD}

RUN ./configure -platform linux-g++-32 -prefix /Qt/5.${QT_MINOR}.${QT_BUILD} -opensource -confirm-license -gstreamer 1.0 -egl -icu -glib -fontconfig -qt-zlib -qt-pcre -qt-libpng -qt-libjpeg -qt-xcb -opengl desktop -make libs -nomake tools -nomake examples -nomake tests

RUN make -j3

RUN make install

##
FROM i386/ubuntu:18.04

COPY --from=0 /Qt/5.${QT_MINOR}.${QT_BUILD} .

