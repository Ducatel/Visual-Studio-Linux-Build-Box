FROM ubuntu:18.04
MAINTAINER D.Ducatel

RUN apt-get update && \
	apt-get install -y openssh-server gdb gdbserver sudo build-essential git && \
	mkdir /var/run/sshd && \
	echo 'root:toor' | chpasswd && \
	sed -i -E 's/#\s*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
	sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
	apt-get clean

VOLUME /usr/src
WORKDIR /usr/src

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
