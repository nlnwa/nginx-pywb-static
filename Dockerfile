FROM alpine as bootstrap
WORKDIR /tmp
RUN wget https://github.com/twbs/bootstrap/releases/download/v4.6.0/bootstrap-4.6.0-dist.zip \
    && unzip bootstrap-4.6.0-dist.zip

FROM alpine as url-polyfill
WORKDIR /tmp
RUN wget https://github.com/lifaon74/url-polyfill/archive/refs/tags/1.1.8.zip \
    && unzip 1.1.8.zip && mv url-polyfill-1.1.8 url-polyfill


FROM alpine as jquery
WORKDIR /tmp
RUN wget https://code.jquery.com/jquery-3.6.0.min.js

FROM webrecorder/pywb:2.6.4 as pywb

FROM nginx:alpine

COPY --from=pywb /pywb/pywb/static /usr/share/nginx/html/static
COPY --from=bootstrap /tmp/bootstrap-4.6.0-dist/css /usr/share/nginx/html/static/css
COPY --from=bootstrap /tmp/bootstrap-4.6.0-dist/js /usr/share/nginx/html/static/js
COPY --from=url-polyfill /tmp/url-polyfill/url-polyfill.min.js /usr/share/nginx/html/static/js/
COPY --from=jquery /tmp/jquery-3.6.0.min.js /usr/share/nginx/html/static/js/
