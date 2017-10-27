#!/usr/bin/env bash

set -e

scala_versions=(
  2.11.11
  2.12.2
  2.12.3
)
sbt_versions=(
  0.13.12
  0.13.13
  0.13.15
  0.13.16
  1.0.0
  1.0.1
  1.0.2
  1.0.3
)
declare -A sbt_urls_map=(
  ["0.13.12"]="http://dl.bintray.com/sbt/native-packages/sbt/0.13.12/sbt-0.13.12.tgz"
  ["0.13.13"]="http://dl.bintray.com/sbt/native-packages/sbt/0.13.13/sbt-0.13.13.tgz"
  ["0.13.15"]="http://dl.bintray.com/sbt/native-packages/sbt/0.13.15/sbt-0.13.15.tgz"
  ["0.13.16"]="https://cocl.us/sbt-0.13.16.tgz"
  ["1.0.0"]="https://github.com/sbt/sbt/releases/download/v1.0.0/sbt-1.0.0.tgz"
  ["1.0.1"]="https://github.com/sbt/sbt/releases/download/v1.0.1/sbt-1.0.1.tgz"
  ["1.0.2"]="https://github.com/sbt/sbt/releases/download/v1.0.2/sbt-1.0.2.tgz"
  ["1.0.3"]="https://github.com/sbt/sbt/releases/download/v1.0.3/sbt-1.0.3.tgz"
)

for scala_version in ${scala_versions[@]}; do
  for sbt_version in ${sbt_versions[@]}; do
    version=scala-${scala_version}-sbt-${sbt_version}
    docker build -t mrdziuban/scala-sbt-jdk:${version} \
      --build-arg SCALA_VERSION=${scala_version} \
      --build-arg SBT_VERSION=${sbt_version} \
      --build-arg SBT_URL="${sbt_urls_map[$sbt_version]}" \
      .
    docker push mrdziuban/scala-sbt-jdk:${version}
    echo "Built ${version}"
  done
done
