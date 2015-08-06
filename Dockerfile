FROM      ubuntu:14.04
MAINTAINER Lakshmi Narasimhan <badri.dilbert@gmail.com>

RUN apt-get -y update

RUN apt-get -y install wget

RUN wget http://packages.lizardfs.com/lizardfs.key 
RUN apt-key add lizardfs.key

RUN echo "deb http://packages.lizardfs.com/ubuntu/trusty trusty main" > /etc/apt/sources.list.d/lizardfs.list
RUN echo "deb-src http://packages.lizardfs.com/ubuntu/trusty trusty main" >> /etc/apt/sources.list.d/lizardfs.list

RUN apt-get -y update

RUN apt-get -y install lizardfs-chunkserver

RUN cp /etc/mfs/mfschunkserver.cfg.dist /etc/mfs/mfschunkserver.cfg

RUN cp /etc/mfs/mfshdd.cfg.dist /etc/mfs/mfshdd.cfg

RUN mkdir /mnt/chunk1

RUN echo "/mnt/chunk1" >> /etc/mfs/mfshdd.cfg

RUN chown -R mfs:mfs /mnt/chunk1

RUN sed -i 's/LIZARDFSCHUNKSERVER_ENABLE=false/LIZARDFSCHUNKSERVER_ENABLE=true/g'  /etc/default/lizardfs-chunkserver

EXPOSE 9422

RUN chmod 0755 /var/lib/mfs

RUN chown -R mfs:mfs /var/lib/mfs

ENTRYPOINT  ["mfschunkserver", "-d", "start"]

