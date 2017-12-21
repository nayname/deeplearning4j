#!/bin/bash
set -evx

while true; do echo .; sleep 60; done &

if [[ $TRAVIS_PULL_REQUEST == "false" ]]; then
    MAVEN_PHASE="deploy"
else
    MAVEN_PHASE="install"
fi

source change-scala-versions.sh $SCALA
source change-spark-versions.sh $SPARK
mvn clean $MAVEN_PHASE -B -U --settings ./ci/settings.xml -Dmaven.test.skip=true -Dlocal.software.repository=sonatype

