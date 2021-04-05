FROM python:3.8.8-buster as builder

# For "python-ldap"
# See also: https://www.python-ldap.org/en/python-ldap-3.3.0/installing.html#build-prerequisites
RUN apt-get update && \
    apt-get install -y \
      build-essential python3-dev \
      libldap2-dev libsasl2-dev tox \
      lcov valgrind && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y slapd ldap-utils

RUN pip3 install --upgrade pip wheel setuptools pipenv
WORKDIR /work

COPY Pipfile Pipfile.lock ./
RUN pipenv install --system

FROM python:3.8.8-slim-buster as runner
ARG PYTHON_VERSION=3.8

RUN apt-get update && \
    apt-get -y upgrade && \
    # Fix to "ImportError: libldap_r-2.4.so.2: cannot open shared object file: No such file or directory"
    apt-get install -y libldap-2.4-2

COPY --from=builder /usr/local/lib/python${PYTHON_VERSION}/site-packages /usr/local/lib/python${PYTHON_VERSION}/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

WORKDIR /app
COPY ./ ./
RUN rm -f Pipfile Pipfile.lock

EXPOSE 8000
# CMD [""]
