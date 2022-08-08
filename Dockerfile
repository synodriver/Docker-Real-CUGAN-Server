FROM synodriver/nonecorn-gunicorn-docker:python3.10

LABEL maintainer="synodriver"

COPY ./server/requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt -i https://pypi.org/simple

#COPY ./start.sh /start.sh
#RUN chmod +x /start.sh
WORKDIR /
#COPY . /
COPY ./conf.py /conf.py
COPY ./main.py /main.py

#COPY ./start-reload.sh /start-reload.sh
#RUN chmod +x /start-reload.sh

COPY ./server /server
COPY ./log /log

#ENV PYTHONPATH=/app

EXPOSE 9000

# Run the start script, it will check for an /app/prestart.sh script (e.g. for migrations)
# And then will start Gunicorn with Uvicorn
#CMD ["/start.sh"]
#CMD python /main.py
CMD python -m gunicorn -c ./conf.py