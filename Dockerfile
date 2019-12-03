FROM centos:7
LABEL maintainer="hsowan <hsowan.me@gmail.com>"

ENV HADOOP_HOME /opt/hadoop
ENV PATH $PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

EXPOSE 8088
EXPOSE 50070

WORKDIR /opt
RUN groupadd -r hadoop && useradd -r -g hadoop hadoop && \
yum install -y wget && \
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup && \
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo && \
yum update -y && \
yum install -y pdsh ssh java-1.8.0-openjdk-devel.x86_64 net-tools.x86_64

USER hadoop:hadoop
# hadoop
RUN wget http://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-3.2.1/hadoop-3.2.1.tar.gz && \
tar -xvf hadoop-3.2.1.tar.gz && \
mv hadoop-3.2.1 hadoop && \
# clean
rm -f hadoop-3.2.1.tar.gz

COPY hadoop/config/* /opt/hadoop/etc/hadoop/
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]