ARG BUILD_FROM
FROM $BUILD_FROM

# Install ddclient
RUN apk add ddclient

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
