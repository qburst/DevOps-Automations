FROM python:3.9-alpine
RUN adduser -D appuser
USER appuser
ENV PATH "$PATH:/home/appuser/.local/bin"
COPY --chown=appuser:appuser . /app
WORKDIR /app
RUN pip3 install --user -r requirements.txt 
CMD ["python3", "/app/app.py"]

