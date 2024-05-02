FROM docker.io/webrecorder/pywb:2.8.3 as pywb

FROM docker.io/nginx:1.25-alpine

COPY --from=pywb /pywb/pywb/static /usr/share/nginx/html/static
