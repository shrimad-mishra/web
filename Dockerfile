FROM python:3.10-slim AS build

WORKDIR /app

COPY requirements.txt .

RUN apt-get update && \
    apt-get install -y curl && \
    pip install --upgrade pip && \
    pip install -r requirements.txt && \
    apt-get clean

COPY . .

RUN python manage.py makemigrations && python manage.py migrate

FROM python:3.10-slim AS runtime

WORKDIR /app

COPY --from=build /app /app

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
