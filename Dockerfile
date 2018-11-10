FROM centos/python-36-centos7

USER root
RUN yum-config-manager -y --add-repo=http://negativo17.org/repos/epel-nvidia.repo &&\
    yum -y install epel-release &&\
    yum -y install cuda-devel-9.1 cuda-cudnn-devel &&\
    yum -y install nvidia-settings kernel-devel dkms-nvidia nvidia-driver-libs.i686 nvidia-driver-cuda &&\
    yum -y clean all
#RUN ln -s /usr/lib64/libcublas.so.9.2 /usr/lib64/libcublas.so.9.0

USER 1000