FROM centos:latest

ADD startup.sh /startup.sh
COPY insurance-integration-0.0.1-1.noarch.rpm ./
RUN rpm -ivh insurance-integration-0.0.1-1.noarch.rpm
RUN yum install -y \
       java-1.8.0-openjdk \
       java-1.8.0-openjdk-devel

RUN mv /opt/insurance-integration/bin/insurance-integration /opt/insurance-integration/bin/insurance-integration.sh 

EXPOSE 8092

CMD [ "/startup.sh" ]
#CMD /opt/insurance-integration/bin/insurance-integration.sh start
