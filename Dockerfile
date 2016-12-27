from ubuntu:xenial

MAINTAINER Yann Hamon "https://github.com/yannh/docker-texlive"

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get -f -y install texlive-latex-base make wget xzdec biber && \
    tlmgr --usermode init-usertree ; \
    tlmgr --user-mode option repository ftp://tug.org/historic/systems/texlive/2015/tlnet-final ; \
    tlmgr install --no-persistent-downloads --usermode acronym bigfoot l3packages l3kernel l3experimental xcolor xstring etoolbox caption logreq iftex graphics-def mhchem chemgreek luatex85a ; \
    mkdir -p /latex && \
    apt-get clean && \
    apt-get autoclean -y && \
    apt-get autoremove -y

WORKDIR /latex
