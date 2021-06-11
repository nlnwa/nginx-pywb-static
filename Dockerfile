FROM webrecorder/pywb:2.4.2 as static

FROM nginx:alpine

COPY --from=static /pywb/pywb/static /usr/share/nginx/html/static
