# Stage 1: Build Image
FROM ubuntu:latest AS BUILD_IMAGE
RUN apt update && apt install wget unzip -y
WORKDIR /root
RUN wget https://www.tooplate.com/zip-templates/2128_tween_agency.zip
RUN unzip 2128_tween_agency.zip && tar -czf tween.tgz *
# Stage 2: Final Image
FROM ubuntu:latest
LABEL "project"="Marketing"
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install apache2 git wget -y
COPY --from=BUILD_IMAGE /root/tween.tgz /var/www/html/
WORKDIR /var/www/html/
RUN tar xzf tween.tgz && rm tween.tgz
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
VOLUME /var/log/apache2
