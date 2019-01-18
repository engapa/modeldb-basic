ARG PY_VERSION="3.5"
ARG DIST="slim-stretch"

FROM python:${PY_VERSION}-${DIST}
WORKDIR /modeldb-basic

COPY requirements.txt ./

RUN pip install -r requirements.txt

ADD . .

RUN pip install . && \
    rm -rf /root/.cache
