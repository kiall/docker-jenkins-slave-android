FROM kiall/jenkins-slave

USER root

# Setup environment
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:/opt/tools

# Copy Android Tools
COPY tools /opt/tools

# Copy Setup Script
COPY setup.sh /setup.sh

# Run Setup
RUN /setup.sh

USER jenkins
