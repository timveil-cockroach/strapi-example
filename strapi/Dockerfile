FROM node:latest

WORKDIR /usr/src/api

RUN echo "unsafe-perm = true" >> ~/.npmrc

RUN npm install -g strapi@alpha

COPY strapi.sh ./
RUN chmod +x ./strapi.sh

EXPOSE 1337

CMD ["./strapi.sh"]