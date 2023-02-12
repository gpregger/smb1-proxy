FROM dperson/samba:amd64

RUN apk add --no-cache --update --upgrade \
    cifs-utils \
    python3 \
    supervisor \
    bash \
    shadow
    
RUN wget https://raw.githubusercontent.com/dperson/samba/master/samba.sh -P /usr/bin/

COPY ./supervisord.conf /etc/supervisord.conf
COPY ./watcher.py /watcher.py

# Docker Healthcheck
COPY ./docker-healthcheck.py /docker-healthcheck.py
HEALTHCHECK --interval=30s --timeout=15s --start-period=5s --retries=3 \
    CMD ["python3", "-u", "/docker-healthcheck.py"]

# Docker Entrypoint
COPY ./docker-entrypoint.py /docker-entrypoint.py
ENTRYPOINT ["python3", "-u", "/docker-entrypoint.py"]
