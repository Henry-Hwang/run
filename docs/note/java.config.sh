#!/bin/bash
#set java environment
export JAVA_HOME=/usr/lib/jvm/jdk1.7.0_71
#export JAVA_HOME=/usr/lib/jvm/jdk1.6.0_45
export JRE_HOME=${JAVA_HOME}/jre  
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib  
export PATH=${JAVA_HOME}/bin:$PATH

#sudo update-alternatives --config java
#sudo update-alternatives --config javac
