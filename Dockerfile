FROM ubuntu:xenial

WORKDIR /usr/src/app

RUN mkdir sandbox
RUN ls

RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget


RUN wget https://storage.googleapis.com/flutter_infra/releases/beta/linux/flutter_linux_2.1.0-12.2.pre-beta.tar.xz

RUN tar xf flutter_linux_2.1.0-12.2.pre-beta.tar.xz

RUN export PATH="$PATH:`pwd`/flutter/bin"

RUN flutter precache

RUN flutter sdk-path

RUN flutter doctor


COPY . ./

RUN flutter build web

RUN pub global activate dhttpd

CMD ["dhttpd","--path", "build/web/"]