FROM nginx

WORKDIR /app

COPY nginx.conf /etc/nginx/nginx.conf
COPY main.c main.c
COPY run.sh run.sh

RUN chmod +x run.sh


CMD ["bash", "./run.sh"]
