FROM python:slim

RUN useradd microblog

WORKDIR /home/microblog

COPY requirements.txt requirements.txt
RUN python -m venv venv
RUN venv/bin/pip install -r requirements.txt
RUN venv/bin/pip install gunicorn pymysql cryptography

COPY app app
COPY migrations migrations
COPY microblog.py config.py /home/microblog/
COPY boot.sh /home/microblog/
RUN chmod +x /home/microblog/boot.sh

ENV FLASK_APP microblog.py

RUN chown -R microblog:microblog ./
USER microblog

EXPOSE 5000

ENTRYPOINT ["/bin/bash", "/home/microblog/boot.sh"]

