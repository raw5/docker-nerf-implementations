FROM kasmweb/core-cuda-focal:1.12.0-rolling

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

USER 1000
# install apt packages
RUN sudo apt-get update

# Install Anaconda3
COPY resources/install_anaconda.sh /tmp/
RUN bash /tmp/install_anaconda.sh

# Install SDFstudio and Nerfstudio
COPY resources/install_sdfstudio_and_nerfstudio.sh /tmp/
RUN bash /tmp/install_sdfstudio_and_nerfstudio.sh

# # # Install nvtop
COPY resources/install_nvtop.sh /tmp/
RUN bash /tmp/install_nvtop.sh

# # install VS code
USER root
COPY resources/install_vscode.sh /tmp/
RUN bash /tmp/install_vscode.sh

# Install Chrome
USER root
COPY resources/install_chrome.sh /tmp/
RUN bash /tmp/install_chrome.sh

# USER 1000

######### End Customizations ###########
USER root
RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000