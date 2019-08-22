FROM adoptopenjdk/openjdk8-openj9

ADD ./xdump/XdumpTest.java /root/XdumpTest.java

RUN javac /root/XdumpTest.java 
