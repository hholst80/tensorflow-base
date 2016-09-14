FROM ubuntu:14.04

MAINTAINER Henrik Holst <henrik.holst@frostbite.com>

RUN apt-get update --fix-missing && \
    apt-get install -y \
    build-essential \
    ca-certificates \
    curl \
    git \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender1 \
    && \
    apt-get clean

# Install mini-conda

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    curl -O https://repo.continuum.io/miniconda/Miniconda3-4.0.5-Linux-x86_64.sh && \
    /bin/bash Miniconda3-4.0.5-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda3-4.0.5-Linux-x86_64.sh

ENV PATH /opt/conda/bin:$PATH

RUN pip install --upgrade pip

# Install tini

RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean

ENTRYPOINT [ "/usr/bin/tini", "--" ]

# Setup our conda environment

RUN conda install -y \
    ipython \
    matplotlib \
    numpy \
    pyopengl \
    scipy \
    swig \
    dnspython \
    && \
    conda clean -iltp

# Install OpenAI Gym

RUN apt-get install -y \
    cmake zlib1g-dev libjpeg-dev xvfb libav-tools \
    xorg-dev libboost-all-dev libsdl2-dev \
    && \
    apt-get clean

RUN pip install gym[atari]

# Install OpenCV (needed by some of our environments).

RUN conda install -y -c https://conda.binstar.org/menpo opencv3 && apt-get install -y libgtk2.0-0

# Install TensorFlow

ENV TF_BINARY_URL https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.10.0-cp35-cp35m-linux_x86_64.whl

RUN pip install $TF_BINARY_URL

# Install ALE

RUN apt-get install -y libsdl1.2-dev libsdl-gfx1.2-dev libsdl-image1.2-dev cmake && apt-get clean

RUN git clone https://github.com/mgbellemare/Arcade-Learning-Environment && \
    cd Arcade-Learning-Environment && \
    mkdir build && cd build && \
    cmake -DUSE_SDL=ON -DUSE_RLGLUE=OFF -DBUILD_EXAMPLES=ON .. && \
    make -j 4 && \
    cd .. && \
    pip install . && \
    cd .. && \
    rm -rf Arcade-Learning-Environment
