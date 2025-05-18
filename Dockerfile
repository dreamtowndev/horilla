FROM python:3.10-slim-bullseye

ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y libcairo2-dev gcc

WORKDIR /app/

COPY . .

RUN chmod +x /app/entrypoint.sh
RUN pip install -r requirements.txt

RUN python manage.py collectstatic --noinput

CMD ["gunicorn", "horilla.wsgi:application", "--bind", "0.0.0.0:8000"]

