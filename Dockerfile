FROM docker.io/webrecorder/pywb:2.7.2 as pywb

FROM docker.io/nginx:1.23-alpine

COPY --from=pywb /pywb/pywb/static /usr/share/nginx/html/static
