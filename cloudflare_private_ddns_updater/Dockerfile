ARG BUILD_FROM
FROM $BUILD_FROM

# Install ddclient
RUN apk add ddclient && apk add python

COPY requirements.txt /
COPY makeconf.py /
COPY run.sh /

RUN pip install --no-cache-dir -r requirements.txt
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
