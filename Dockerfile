FROM hypriot/rpi-alpine-scratch:v3.4
MAINTAINER Mike Morris

ENV GLIBC_VERSION "2.22-r8"

RUN apk --no-cache add --update ca-certificates wget device-mapper
RUN apk --no-cache add zfs-zsh-completion --repository http://dl-3.alpinelinux.org/alpine/edge/main/

RUN wget -t 5 https://github.com/armhf-docker-library/alpine-pkg-glibc/releases/download/2.22/glibc-${GLIBC_VERSION}.apk && \
    wget -t 5 https://github.com/armhf-docker-library/alpine-pkg-glibc/releases/download/2.22/glibc-bin-${GLIBC_VERSION}.apk && \
    apk add glibc-${GLIBC_VERSION}.apk glibc-bin-${GLIBC_VERSION}.apk --allow-untrusted && \
    /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib && \
    echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf && \
    rm -rf /var/cache/apk/* /glibc*.apk

COPY cadvisor /usr/bin/cadvisor

EXPOSE 8080
ENTRYPOINT ["/usr/bin/cadvisor", "-logtostderr"]
