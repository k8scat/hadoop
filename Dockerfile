FROM centos:7
LABEL maintainer="hsowan <hsowan.me@gmail.com>"

ENV HADOOP_HOME /home/hadoop/hadoop-3.2.1
ENV PATH $PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

EXPOSE 8088
EXPOSE 50070

COPY docker-entrypoint.sh /usr/local/bin/

WORKDIR /home/hadoop
RUN groupadd -r hadoop && useradd -r -g hadoop -d /home/hadoop -m hadoop && \
chown hadoop:hadoop /home/hadoop && \
yum install -y wget && \
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup && \
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo && \
yum update -y && \
yum install -y pdsh ssh java-1.8.0-openjdk-devel.x86_64 net-tools.x86_64

USER hadoop:hadoop
# hadoop
RUN wget http://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-3.2.1/hadoop-3.2.1.tar.gz && \
tar -xvf hadoop-3.2.1.tar.gz && \
# clean
rm -f hadoop-3.2.1.tar.gz

COPY config/* /home/hadoop/hadoop-3.2.1/etc/hadoop/

ENTRYPOINT ["docker-entrypoint.sh"]