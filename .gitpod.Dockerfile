FROM python:3.9

RUN useradd microblog

WORKDIR /home/microblog

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY app app
COPY migrations migrations
COPY microblog.py config.py boot.sh ./
RUN chmod a+x boot.sh

ENV FLASK_APP microblog.py

RUN chown -R microblog:microblog ./
USER microblog