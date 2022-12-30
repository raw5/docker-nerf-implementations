FROM kasmweb/core-cuda-focal:1.12.0-rolling

USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
ENV USER_HOME /home/kasm-user
WORKDIR $HOME

######### Customize Container Here ###########

# Sudo user
RUN apt-get update \
    && apt-get install -y sudo \
    && echo 'kasm-user ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
    && rm -rf /var/lib/apt/list/*

# Install Dpendencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        libappindicator1 fonts-liberation \
        libfontconfig1 build-essential mesa-common-dev libglu1-mesa-dev \
        dbus-x11 xfonts-base xfonts-100dpi xfonts-75dpi xfonts-cyrillic xfonts-scalable \
        python3-pip libasound2 libegl1-mesa libgl1-mesa-glx \
        libxcomposite1 libxcursor1 libxi6 libxrandr2 libxss1 \
        lsb-release xdg-utils \
        libxtst6 gdal-bin ffmpeg vlc dnsutils iputils-ping git \
        && rm -rf /var/lib/apt/lists/*

# Install Anaconda3
COPY resources/install_anaconda.sh /tmp/
RUN bash /tmp/install_anaconda.sh

# Install SDFstudio and Nerfstudio
USER 1000
COPY resources/install_sdfstudio_and_nerfstudio.sh /tmp/
RUN bash /tmp/install_sdfstudio_and_nerfstudio.sh
USER root

# # # Install nvtop
COPY resources/install_nvtop.sh /tmp/
RUN bash /tmp/install_nvtop.sh

# # install VS code
COPY resources/install_vscode.sh /tmp/
RUN bash /tmp/install_vscode.sh

# Install Chrome
COPY resources/install_chrome.sh /tmp/
RUN bash /tmp/install_chrome.sh

# Tinycuda installation on entrypoint
COPY resources/install_tinycuda.sh $STARTUPDIR

######### End Customizations ###########
USER root
RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000

# ENTRYPOINT ["/dockerstartup/install_tinycuda.sh"]
# CMD ["--wait"]