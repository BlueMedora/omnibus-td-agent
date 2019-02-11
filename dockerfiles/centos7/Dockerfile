FROM centos:7

ARG project_name=bm-agent

RUN yum install -y epel-release && \
    yum install -y rpm-build gcc git-core gcc-c++ \
      patch curl which python-pip python yum-plugin-ovl \
      make openssl-devel readline-devel zlib-devel python-pip && \
    yum clean all


# Install rbenv
RUN git clone https://github.com/rbenv/rbenv.git /root/.rbenv && \
    git clone https://github.com/rbenv/ruby-build.git /root/.rbenv/plugins/ruby-build
ENV PATH /root/.rbenv/shims:/root/.rbenv/bin:$PATH

RUN rbenv install 2.4.5 && \
    rbenv global 2.4.5 && \
    gem update --system

RUN pip install --upgrade awscli

RUN useradd ${project_name} && \
    mkdir -p /opt/${project_name} && \
    chown ${project_name} /opt/${project_name}
