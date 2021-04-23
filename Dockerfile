# pull official base image
FROM python:3.8-slim-buster

# set work directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install psycopg2 dependencies
RUN apk update \
    && apk add postgresql-dev gcc python3-dev musl-dev

# copy project
ADD . .

# install dependencies
ADD requirements.txt .
ADD entrypoint.sh .
RUN chmod 755 entrypoint.sh

RUN . venv/bin/activate && python -m pip install -r requirements.txt

# run entrypoint.sh
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
