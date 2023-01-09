FROM docker.io/alpine:3.17 as build

ARG BOOTSTRAP_VERSION=4.6.2
ARG JQUERY_VERSION=3.6.3
ARG URL_POLYFILL_VERSION=1.1.8

WORKDIR /tmp

ADD https://github.com/twbs/bootstrap/releases/download/v${BOOTSTRAP_VERSION}/bootstrap-${BOOTSTRAP_VERSION}-dist.zip .
RUN unzip bootstrap-${BOOTSTRAP_VERSION}-dist.zip && mv bootstrap-${BOOTSTRAP_VERSION}-dist bootstrap-dist

ADD https://github.com/lifaon74/url-polyfill/archive/refs/tags/${URL_POLYFILL_VERSION}.zip .
RUN unzip ${URL_POLYFILL_VERSION}.zip && mv url-polyfill-${URL_POLYFILL_VERSION} url-polyfill

ADD https://code.jquery.com/jquery-${JQUERY_VERSION}.min.js jquery-latest.min.js


FROM docker.io/webrecorder/pywb:2.7.2 as pywb


FROM docker.io/nginx:1.23-alpine

COPY --from=pywb /pywb/pywb/static /usr/share/nginx/html/static
COPY --from=build /tmp/bootstrap-dist/css /usr/share/nginx/html/static/css
COPY --from=build /tmp/bootstrap-dist/js /usr/share/nginx/html/static/js
COPY --from=build /tmp/url-polyfill/url-polyfill.min.js /usr/share/nginx/html/static/js/
COPY --from=build /tmp/jquery-latest.min.js /usr/share/nginx/html/static/js/
