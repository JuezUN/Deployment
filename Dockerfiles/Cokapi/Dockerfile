FROM node:6.11.5

WORKDIR /home

COPY . .

RUN make deps

EXPOSE 3000

CMD ["node" , "cokapi.js"]
