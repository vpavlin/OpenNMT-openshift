FROM centos/python-36-centos7

USER root
RUN yum-config-manager -y --add-repo=http://negativo17.org/repos/epel-nvidia.repo &&\
    yum -y install epel-release &&\
    yum -y install cuda-devel cuda-cudnn-devel &&\
    yum -y install nvidia-settings kernel-devel dkms-nvidia nvidia-driver-libs.i686 nvidia-driver-cuda &&\
    yum -y clean all

USER 1000