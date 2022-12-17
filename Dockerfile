FROM kalilinux/kali-rolling:latest

COPY . /tmp/workstation-setup
WORKDIR /tmp/workstation-setup

RUN apt update \
    && apt install kali-linux-core -y \
    && ./setup

#ENTRYPOINT ["tail", "-f", "/dev/null"]
