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
		 megatools \
	    
	    
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

# anydesk
#RUN wget --no-check-certificate https://download.anydesk.com/linux/deb/anydesk_5.0.0-1_amd64.deb
#RUN wget https://download.anydesk.com/linux/deb/anydesk_5.0.0-1_amd64.deb && DEBIAN_FRONTEND=noninteractive apt install --yes ./anydesk_5.0.0-1_amd64.deb

#RUN apt-get update \
# && DEBIAN_FRONTEND=noninteractive apt install --yes /anydesk_5.0.0-1_amd64.deb
#RUN sudo apt --fix-broken install

#RUN wget https://mega.nz/linux/MEGAsync/xUbuntu_16.04/amd64/megasync_4.4.0-1.1_amd64.deb && apt install ./megasync_4.4.0-1.1_amd64.deb

#RUN wget https://mega.nz/linux/MEGAsync/xUbuntu_16.04/amd64/nautilus-megasync_3.6.6_amd64.deb && apt install ./nautilus-megasync_3.6.6_amd64.deb


CMD ["/app/run.sh"]
