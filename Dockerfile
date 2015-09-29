FROM ubuntu:15.10

# ---
# ---
# ---

ENV DEBIAN_FRONTEND noninteractive

# ---
# ---
# ---

RUN apt-get update && apt-get install -y -qq --no-install-recommends wget curl unzip git subversion build-essential python python-openssl ruby php5-cli php5-cgi php5-mysql openjdk-7-jre-headless openssh-client nodejs npm golang awscli && apt-get clean

# ---
# ---
# ---

WORKDIR /opt/

RUN wget -q https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.zip && unzip -q google-cloud-sdk.zip && rm google-cloud-sdk.zip

ENV CLOUDSDK_PYTHON_SITEPACKAGES 1

RUN google-cloud-sdk/install.sh --usage-reporting=true --path-update=true --bash-completion=true --rc-path=$HOME/.bashrc --disable-installation-options
RUN google-cloud-sdk/bin/gcloud --quiet components update pkg-go pkg-python pkg-java preview alpha beta app
RUN google-cloud-sdk/bin/gcloud --quiet config set component_manager/disable_update_check true

ENV PATH /opt/google-cloud-sdk/bin:$PATH

# ---
# ---
# ---

RUN ln -s `which nodejs` /usr/bin/node

# ---

RUN npm install -g grunt-cli@0.1.13
RUN npm install -g wintersmith@2.2.1 wintersmith-appengine@2.0.6 wintersmith-less@0.2.3 wintersmith-browserify@0.9.0

# ---
# ---
# ---

WORKDIR /opt/

RUN wget -q https://s3.amazonaws.com/elasticbeanstalk/cli/AWS-ElasticBeanstalk-CLI-2.6.4.zip && unzip -q AWS-ElasticBeanstalk-CLI-2.6.4.zip && rm AWS-ElasticBeanstalk-CLI-2.6.4.zip

ENV PATH /opt/AWS-ElasticBeanstalk-CLI-2.6.4/eb/linux/python2.7:$PATH

# ---
# ---
# ---

RUN npm install -g cloudflare-cli@1.4.0

# ---
# ---
# ---

RUN gem install nokogiri
RUN gem install dpl

# ---
# ---
# ---

WORKDIR /root/

# ---
