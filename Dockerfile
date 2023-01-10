ARG PYWB_VERSION=2.7.2

FROM docker.io/webrecorder/pywb:$PYWB_VERSION as pywb

FROM docker.io/nginx:1.23-alpine

COPY --from=pywb /pywb/pywb/static /usr/share/nginx/html/static
