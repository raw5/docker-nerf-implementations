FROM kasmweb/core-nvidia-focal:develop-rolling
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

# Sudo user
RUN apt-get update \
    && apt-get install -y sudo \
    && echo 'kasm-user ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
    && rm -rf /var/lib/apt/list/*

# install apt packages
RUN apt-get update && apt-get install -y \
    python3-pip libasound2 libegl1-mesa libgl1-mesa-glx \
    libxcomposite1 libxcursor1 libxi6 libxrandr2 libxss1 \
    libxtst6 gdal-bin dnsutils iputils-ping

# update pip
COPY resources/update_pip.sh /tmp/
RUN bash /tmp/update_pip.sh

# Install Anaconda3
COPY resources/install_anaconda.sh /tmp/
RUN bash /tmp/install_anaconda.sh

# Install packages in conda environment
USER 1000
COPY resources/install_conda_packages.sh /tmp/
RUN bash /tmp/install_conda_packages.sh
USER root

# Install nvtop
COPY resources/install_nvtop.sh /tmp/
RUN bash /tmp/install_nvtop.sh

# Install Visual Studio Code
#install VS code
COPY resources/install_vscode.sh /tmp/
RUN bash /tmp/install_vscode.sh

# Install Chrome
COPY resources/install_chrome.sh /tmp/
RUN bash /tmp/install_chrome.sh

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000