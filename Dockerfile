FROM centos:7
LABEL maintainer="manual123@gmail.com"

# Set locale data for sphinx documentation
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

# Install required software
RUN yum install -y epel-release && \
    yum install -y https://repo.ius.io/ius-release-el7.rpm && \
    yum install -y gcc gcc-c++ git2u cmake3 make doxygen wget mesa-libGL-devel mesa-libGLU-devel libpng freetype fontconfig \
                   libXi libSM libICE libjpeg-turbo libXrandr graphviz python36 python36-pip perl-Tk perl-Digest-MD5 unzip && \
    ln -s /usr/bin/cmake3 /usr/bin/cmake

ADD requirements.txt /requirements.txt
RUN pip3 install -r requirements.txt --upgrade 

# Install TexLive (the CentOS packages are lacking)
ADD http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz /
ADD texlive.profile /
RUN mkdir /install-tl-unx && tar -xzvf /install-tl-unx.tar.gz --directory=/install-tl-unx --strip-components=1
RUN install-tl-unx/install-tl --profile /texlive.profile
ENV PATH="/usr/local/texlive/2017/bin/x86_64-linux:${PATH}"

