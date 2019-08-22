FROM adoptopenjdk/openjdk8-openj9

ADD ./xtrace/XtraceTest.java /root/XtraceTest.java

RUN javac /root/XtraceTest.java 
