FROM ubuntu:16.04

RUN apt-get update && \
    apt-get --no-install-recommends --yes install \
         git \
         automake \
         build-essential \
         libtool \
         autotools-dev \
         autoconf \
         pkg-config \
         libssl-dev \ 
         libboost-all-dev \
         libevent-dev \
         bsdmainutils \
         vim \
         libgmp3-dev  \
         wget \
         libzmq5 \
         software-properties-common && \
         rm -rf /var/lib/apt/lists/* 

RUN add-apt-repository ppa:bitcoin/bitcoin && \
    apt-get update && \
    apt-get --no-install-recommends --yes install \
          libdb4.8-dev \
          libdb4.8++-dev \
          libminiupnpc-dev && \
          rm -rf /var/lib/apt/lists/* 

WORKDIR /grvproject

RUN wget https://github.com/Gravium/gravium/releases/download/REL/gravium-x86_64-pc-linux-gnu.tar.gz && \    	
    tar xvzf gravium-x86_64-pc-linux-gnu.tar.gz && \
    strip /grvproject/bin/graviumd /grvproject/bin/gravium-cli /grvproject/bin/gravium-tx && \
    mv /grvproject/bin/graviumd /usr/local/bin/ && \
    mv /grvproject/bin/gravium-cli /usr/local/bin/ && \
    mv /grvproject/bin/gravium-tx /usr/local/bin/ && \
    chmod +x /usr/local/bin/graviumd && chmod +x /usr/local/bin/gravium-cli  && chmod +x /usr/local/bin/gravium-tx && \
    rm -rf /grvproject

VOLUME ["/root/.graviumcore"]

EXPOSE 11000 11010

CMD /usr/local/bin/graviumd && tail -f /root/.graviumcore/debug.log