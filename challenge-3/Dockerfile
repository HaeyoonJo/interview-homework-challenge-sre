FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

COPY server.py .

RUN groupadd -g 1234 customgroup && \
    useradd -m -u 1234 -g customgroup customuser

USER customuser

EXPOSE 8080

CMD ["python3", "server.py"]