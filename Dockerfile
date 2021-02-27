##FROM##
FROM ubuntu

ENV TZ=America/Guayaquil
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

##RUN##
RUN apt-get update
RUN apt-get install -y python
RUN echo 1.0 >> /etc/version && apt-get install -y git \
	&& apt-get install -y iputils-ping
RUN mkdir /Datos

##WORKDIR##
WORKDIR /Datos

##RUN##
RUN touch f1.txt
RUN mkdir /Datos1

##WORKDIR##
WORKDIR /Datos1

##RUN##
RUN touch f2.txt

##COPY##
COPY index.html .
COPY app.log /Datos

##ADD##
ADD docs docs
ADD f* /Datos/
ADD f.tar .

##ENV##
ENV dir=/data dir1=/data1
RUN mkdir $dir && mkdir $dir1

##ARG##
#ARG dir2
#RUN mkdir $dir2
#ARG user
#ENV user_docker $user
#ADD add_user.sh /Datos1
#RUN /Datos1/add_user.sh


##EXPOSE##
RUN apt-get install -y apache2
EXPOSE 80
ADD entrypoint.sh /Datos1

##VOLUME##
ADD paginas /var/www/html
VOLUME ["/var/www/html"]

##CMD##
CMD /Datos1/entrypoint.sh 
##ENTRYPOINT##
#ENTRYPOINT ["/bin/bash"]