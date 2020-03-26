#ARG BUILD_FROM
#FROM $BUILD_FROM
FROM balenalib/rpi-raspbian:stretch

LABEL maintainer "Tom van der Geer"

RUN	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys \
		CC28DD82EF4C718C \
	&& echo "deb http://apt.pilight.org/ stable main" > /etc/apt/sources.list.d/pilight.list \
	&& apt-get update \
	&& apt-get install -y \
		build-essential \
		cmake \
		git \
		dialog \
		libwiringx \
		libwiringx-dev \
		libpcap0.8-dev \
		libmbedtls-dev \
		liblua5.2-dev \
		libluajit-5.1-dev \
		jq \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN git clone --depth 5 -b staging https://www.github.com/pilight/pilight.git

RUN cd pilight \
	&& mkdir -p build \
	&& cd build \
	&& cmake .. \
	&& make install

RUN pwd
RUN ldconfig

EXPOSE 5000/tcp 5001/tcp

COPY run.sh /run.sh
COPY pilight-config.json /etc/pilight/config.json

ENTRYPOINT ["/run.sh"]
