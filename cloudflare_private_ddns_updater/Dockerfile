ARG BUILD_FROM
FROM $BUILD_FROM

COPY makeconfig.py /
COPY run.sh /

RUN apk add ddclient

ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3
RUN apk add --update --no-cache py3-netifaces

RUN chmod a+x /run.sh
CMD [ "/run.sh" ]
