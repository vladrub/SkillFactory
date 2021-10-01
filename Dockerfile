FROM python:3.9.7-slim-buster

RUN mkdir -p /srv/app
COPY /app /srv/app

WORKDIR /srv/app

RUN pip install --no-cache-dir -r requirements.txt

CMD [ "python", "web.py" ]