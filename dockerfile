FROM python:3.10

WORKDIR /app

COPY flask_app/ /app/

COPY models/vectorizer.pkl /app/models/vectorizer.pkl

RUN pip install -r requirements.txt

RUN python -m nltk.downloader stopwords wordnet

ENV NLTK_DATA=/root/nltk_data

EXPOSE 5000

CMD ["gunicorn","-b","0.0.0.0:5000","app:app"]
