FROM centos:latest

ENV HADOOP_COMMON_HOME /root/hadoop
ENV HADOOP_HOME /root/hadoop
ENV HIVE_HOME /root/hive
ENV DERBY_HOME /root/derby
ENV PATH /root/derby/bin:$PATH
ENV JAVA_HOME /usr/lib/jvm/java

COPY hadoop3 $HADOOP_COMMON_HOME
COPY derby10 $DERBY_HOME
COPY hive3 $HIVE_HOME

ADD start.sh /root/start.sh

RUN chmod 755 /root/start.sh \
    && yum install java-1.8.0-openjdk java-1.8.0-openjdk-devel openssh-server openssh-clients -y \
    && ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N '' \
    && ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' \
    && ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key -N '' \
    && ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa \
    && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys \
    && chmod 0600 ~/.ssh/authorized_keys 
EXPOSE 22
CMD ["/root/start.sh"]

