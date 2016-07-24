#!/bin/bash

set -eu

echo "===> Add webupd8 Java repository..."

echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
apt-get update

echo "===> Install Java"

echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes oracle-java8-installer oracle-java8-set-default
rm -rf /var/cache/oracle-jdk8-installer

echo "===> Install Android Deps..."
dpkg --add-architecture i386
apt-get update
apt-get install -y --force-yes expect git wget libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1 python curl

echo "===> Install Android SDK..."
cd /opt
wget -O android-sdk.tgz http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz
tar xzf android-sdk.tgz
rm -f android-sdk.tgz
chown -R root:root android-sdk-linux

echo "===> Update Android SDK..."
/opt/tools/android-accept-licenses.sh "android update sdk --all --force --no-ui --filter tools,platform-tools,build-tools-24.0.0,android-24,extra-google-google_play_services,extra-google-m2repository,extra-android-m2repository,sys-img-x86-android-tv-24"

echo "===> Clean up apt caches..."
apt-get clean
rm -rf /var/lib/apt/lists/*
