FROM webrecorder/pywb:develop as static

FROM nginx:alpine

COPY --from=static /pywb/pywb/static /usr/share/nginx/html/static
