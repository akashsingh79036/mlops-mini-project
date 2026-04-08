# Stage: Final Stage
FROM python:3.10-slim AS final

WORKDIR /app

#Copy the requirements.txt file to the final stage
COPY flask_app/requirements.txt /app/

#Install dependencies in the final stage
RUN pip install --no-cache-dir -r requirements.txt

#Copy the application code and model files
COPY flask_app/ /app/
COPY models/vectorizer.pkl /app/models/vectorizer.pkl

#Download only the necessary NLTK data
RUN python -m nltk.downloader stopwords wordnet

#Expose the application port
EXPOSE 5000

#set the command to run the application
CMD ["gunicorn","-bind","0.0.0.0:5000", "--timeout", "120", "app:app"]