FROM ubuntu:16.04

RUN apt-get update && apt-get install -y docker.io

#mongo installation
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6


EXPOSE 27017

WORKDIR /home
ENV INGINIOUS_HOME /home/INGInious

COPY . ./INGInious

RUN pip install INGInious

CMD ["./inginious-webapp"]
