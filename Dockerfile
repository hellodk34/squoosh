FROM alpine:3

MAINTAINER hellodk<k@hellodk.cn>

RUN set -ex && echo "http://mirrors.aliyun.com/alpine/edge/main/" > /etc/apk/repositories \
    && echo "http://mirrors.aliyun.com/alpine/edge/community/" >> /etc/apk/repositories \
    && apk update \
    && apk add --no-cache --update nodejs npm \
    && node -v && npm -v \
    && npm config set registry https://registry.npm.taobao.org

WORKDIR /app/squoosh/

# the source code is at https://github.com/GoogleChromeLabs/squoosh , I just edited the package.json file
COPY squoosh /app/squoosh/

RUN cd /app/squoosh && npm install

EXPOSE 8080

ENTRYPOINT ["npm","run","serve"]
