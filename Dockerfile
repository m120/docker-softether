FROM ubuntu:16.04

MAINTAINER m120

ENV SE_VER v4.25-9656-rtm-2018.01.15

RUN apt update && \
  apt install -y gcc make curl

RUN curl http://jp.softether-download.com/files/softether/${SE_VER}-tree/Linux/SoftEther_VPN_Server/64bit_-_Intel_x64_or_AMD64/softether-vpnserver-${SE_VER}-linux-x64-64bit.tar.gz | tar zx -C /opt/

## Install
WORKDIR /opt/vpnserver
RUN make i_read_and_agree_the_license_agreement

# clean
RUN apt remove -y gcc make curl && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/log/apt/*log

EXPOSE 443:443
EXPOSE 500/UDP
EXPOSE 4500/UDP

ENTRYPOINT ["./vpnserver", "execsvc"]
