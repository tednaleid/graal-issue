#! /usr/bin/env bash

set -euo pipefail

echo "building shadow jar and executing"
./gradlew clean runShadow

echo "running jar file with java"
java -jar graal-issue-core/build/libs/graal-issue-core.jar

echo "moving to that directory to successfully run native-image on the jar"
pushd graal-issue-core/build/libs
native-image -jar graal-issue-core.jar

echo "running native image"
./graal-issue-core

echo "moving back to project root dir that has a directory called graal-issue-core"
popd

echo "trying to run native-issue, will fail with confusing message"
native-image -jar graal-issue-core/build/libs/graal-issue-core.jar
