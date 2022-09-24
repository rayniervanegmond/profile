# Copyright (c) PNEOM Development Team.
# Maintainer: Raynier van Egmond PNEOM program (raynierx@gmail.com)
# Distributed under the terms of the Modified BSD License.

# NOTE:
#      the build image name will be pneom/vue3_svc_image:v001
#      the build container name will be pneom/vue3_svc_app

# ------------- create correct base image reference
ARG ROOT_CONTAINER=node:latest
ARG PROJECT_NAME=profile
FROM $ROOT_CONTAINER

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# ARG USERNAME=user-name-goes-here
# This is best the same as the HOST user name does not 
# necessarily have to be so. 
# It is the numeric USER_ID that counts.
ARG USERNAME=raynier
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# change the user account for node:latest node user as it conflicts 
# with the HOST user raynier:1000. We will move CONTAINER node:1000
# to the CONTAINER node:1001 inside the same group.
ARG BASE_USERNAME=node
ARG BASE_USERNAME_NEW_UID=1001

WORKDIR /svc

# at this point we are still 'root' and give user "node" a new UID
# while keeping it in the same group.
RUN usermod --uid $BASE_USERNAME_NEW_UID --gid $USER_GID $BASE_USERNAME 

# now we can create user raynier:1000 as a "mirror" of the HOST user
RUN useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && sudo chown -R 1000:1000 .


# ------------- setup the correct working environment
# ------------- by adding required applications for dev
RUN    npm install -g npm \
    && npm install -g npx --force \
    && npm install -g @vue/cli \
    && npm install -g serve \
    && npm install -g @fortawesome/fontawesome-svg-core --save \
    && npm i --save @fortawesome/free-solid-svg-icons \
    && npm i --save @fortawesome/free-regular-svg-icons \
    && npm i --save @fortawesome/free-brands-svg-icons

RUN npm install -g -D tailwindcss \
    && tailwindcss init


# The idea  is that the developer will copy this HOST service directory 
# and use the CONTAINER-installed Vue/cli to generate a VUE application 
# in the mirrored directory.
#
# This will then be available to the Vue runtime which is also on
# CONTAINER. So again, we keep the project-code on the HOST and all
# the runtime material needed for the execution is take from the
# CONTAINER.

# ------------- update container with required packages for the service   
# The changes in required node-packages will be installed on the
# HOST and this will update the HOST package file. Docker will 
# detect the change and rebuild the development container after the
# the HOST package.json is copied into file into the container.

COPY ./$PROJECT_NAME/package.json ./

# ------------- get and install required packages for the service   
RUN npm install

# ------------- copy all HOST files over to the CONTAINER   
# COPY . ./


# ********************************************************
# * Anything else you want to do like clean up goes here *
# ********************************************************

# [Optional] Set the default user. Omit if you want to keep the default as root.
# This should start the container as the non-root user.

USER $USERNAME

# ------------- document exposed ports for service
EXPOSE 8080
# ------------- execute image container default startup command
# ------------- CMD can be overidden on the command line.
# ------------- 

CMD ["bin","bash"]
