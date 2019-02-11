FROM ubuntu:18.04

ARG project_name=bm-agent

RUN apt-get update
RUN apt-get install -y git curl gcc make libssl-dev libreadline-dev zlib1g-dev python-pip
RUN apt-get clean

# Install rbenv
RUN git clone https://github.com/rbenv/rbenv.git /root/.rbenv && \
    git clone https://github.com/rbenv/ruby-build.git /root/.rbenv/plugins/ruby-build
ENV PATH /root/.rbenv/shims:/root/.rbenv/bin:$PATH

RUN rbenv install 2.4.5 && \
    rbenv global 2.4.5 && \
    gem install bundler

RUN pip install --upgrade awscli

RUN useradd ${project_name} && \
    mkdir -p /opt/${project_name} && \
    chown ${project_name} /opt/${project_name}
