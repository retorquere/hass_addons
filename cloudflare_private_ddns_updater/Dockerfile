ARG BUILD_FROM
FROM $BUILD_FROM

COPY requirements.txt /
COPY makeconfig.py /
COPY run.sh /

RUN apk add ddclient

ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools
RUN pip install --no-cache-dir -r requirements.txt

RUN chmod a+x /run.sh
CMD [ "/run.sh" ]
