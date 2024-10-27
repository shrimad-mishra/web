FROM python:3.10-alpine AS build

WORKDIR /app

COPY requirements.txt /app/

RUN apk add --no-cache --virtual .build-deps gcc musl-dev libffi-dev openssl-dev && \
    python -m venv /opt/venv && \
    /opt/venv/bin/pip install --upgrade pip && \
    /opt/venv/bin/pip install --no-cache-dir -r requirements.txt && \
    apk del .build-deps

FROM python:3.10-alpine

WORKDIR /app

COPY --from=build /opt/venv /opt/venv

COPY . /app

RUN /opt/venv/bin/python manage.py makemigrations && /opt/venv/bin/python manage.py migrate

EXPOSE 8000

CMD ["/opt/venv/bin/python", "manage.py", "runserver", "0.0.0.0:8000"]