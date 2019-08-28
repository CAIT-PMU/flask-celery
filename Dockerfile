tiangolo/meinheld-gunicorn:python3.7-alpine3.8

#COPY ./app /app
COPY requirements.txt requirements.txt
#RUN python -m venv venv
#RUN venv/bin/pip install -r requirements.txt

#RUN pip install pipenv

RUN pip install -r requirements.txt

ADD . /flask-deploy

WORKDIR /flask-deploy

RUN pipenv install --system --skip-lock

RUN pip install gunicorn[gevent]

EXPOSE 5000

CMD gunicorn --worker-class gevent --workers 8 --bind 0.0.0.0:5000 wsgi:app --max-requests 10000 --timeout 5 --keep-alive 5 --log-level info
