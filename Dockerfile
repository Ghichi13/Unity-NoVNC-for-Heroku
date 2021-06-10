FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive

RUN set -ex; \
    apt-get update \
    && apt-get install -y --no-install-recommends \
        ubuntu-desktop \
        unity-lens-applications \
        gnome-panel \
        metacity \
        nautilus \
        gedit \
        xterm \
        sudo \
	    firefox \
	    qbittorrent \
	    hexchat \
	    file-roller \
	    unzip \
	    unrar \
	    vlc \
	    apt-utils \
                 xz-utils \
	         lintian \
	    
	    
        bash \
        net-tools \
        novnc \
        socat \
        x11vnc \
        gnome-panel \
        gnome-terminal \
        xvfb \
        supervisor \
        net-tools \
        curl \
        git \
	    wget \
        libtasn1-bin \
        libglu1-mesa \
        libqt5webkit5 \
        libqt5x11extras5 \
        qml-module-qtquick-controls \
        qml-module-qtquick-dialogs \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

ENV HOME=/root \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1024 \
    DISPLAY_HEIGHT=768 \
    RUN_XTERM=yes \
    RUN_UNITY=yes

RUN adduser ubuntu

RUN echo "ubuntu:ubuntu" | chpasswd && \
    adduser ubuntu sudo && \
    sudo usermod -a -G sudo ubuntu


COPY . /app

RUN chmod +x /app/conf.d/websockify.sh
RUN chmod +x /app/run.sh
USER ubuntu

RUN echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list
RUN echo "deb http://deb.anydesk.com/ all main"  >> /etc/apt/sources.list
RUN wget --no-check-certificate https://dl.google.com/linux/linux_signing_key.pub -P /app
RUN wget --no-check-certificate -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY -O /app/anydesk.key
RUN apt-key add /app/anydesk.key
RUN apt-key add /app/linux_signing_key.pub
RUN set -ex; \
    apt-get update \
    && apt-get install -y --no-install-recommends \
        google-chrome-stable \
	anydesk
	
# MEGA-SYNC
RUN sudo dpkg-reconfigure debconf -f noninteractive -p critical
RUN wget --no-check-certificate https://mega.nz/linux/MEGAsync/xUbuntu_16.04/amd64/megasync_4.4.0-1.1_amd64.deb
RUN mv /megasync_4.4.0-1.1_amd64.deb /1.deb
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt install --yes /1.deb
RUN sudo apt --fix-broken install

#nautilus-megasync
RUN sudo dpkg-reconfigure debconf -f noninteractive -p critical
RUN wget --no-check-certificate https://mega.nz/linux/MEGAsync/xUbuntu_16.04/amd64/nautilus-megasync_3.6.6_amd64.deb
RUN mv /nautilus-megasync_3.6.6_amd64.deb /2.deb
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt install --yes /2.deb
RUN sudo apt --fix-broken install

CMD ["/app/run.sh"]
