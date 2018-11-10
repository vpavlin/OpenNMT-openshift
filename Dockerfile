#FROM nvidia/cuda:9.0-cudnn7-runtime-centos7
FROM nvidia/cuda:9.0-cudnn7-runtime-centos7

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/cuda/lib64:/usr/local/cuda-10.0/compat/
ENV HOME /opt/app-root/src/
ENV APP_ROOT /opt/app-root/

RUN yum -y install epel-release &&\
    yum -y install python-pip libgomp &&\
    yum -y clean all
    #yum -y install cuda-compat-10-0-1:410.72-1.el7.x86_64 &&

RUN mkdir -p $HOME
COPY run.sh serve.sh requirements.txt reference-config.yaml $HOME

WORKDIR $HOME
RUN chgrp -R 0 $HOME
RUN chmod -R g+rw $HOME
RUN find $HOME -type d -exec chmod g+x {} +
#RUN pip install -r requirements.txt

RUN INSTALL_PKGS="rh-python36 rh-python36-python-devel rh-python36-python-setuptools rh-python36-python-pip nss_wrapper \
        httpd24 httpd24-httpd-devel httpd24-mod_ssl httpd24-mod_auth_kerb httpd24-mod_ldap \
        httpd24-mod_session atlas-devel gcc-gfortran libffi-devel libtool-ltdl enchant" && \
    yum install -y centos-release-scl && \
    yum -y --setopt=tsflags=nodocs install --enablerepo=centosplus $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    # Remove centos-logos (httpd dependency) to keep image size smaller.
    rpm -e --nodeps centos-logos && \
    yum -y clean all --enablerepo='*'

RUN source scl_source enable rh-python36 && \
    virtualenv ${APP_ROOT} && \
    chown -R 1001:0 ${APP_ROOT} 
    #&& \
    #fix-permissions ${APP_ROOT} -P && \
    #rpm-file-permissions

USER 1001
#ENTRYPOINT ["/usr/bin/bash"]