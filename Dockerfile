FROM centos/python-36-centos7

USER root
RUN curl -o cuda-repo-rhel7-10-0-local-10.0.130-410.48-1.0-1.x86_64.rpm "https://developer.download.nvidia.com/compute/cuda/10.0/secure/Prod/local_installers/cuda-repo-rhel7-10-0-local-10.0.130-410.48-1.0-1.x86_64.rpm?UpwIl-I6g7I76LzDF_9UUKu6YvYZTikNro61oAkjouJBNrprgdSAb7NsFecRoj5ASpmng7dIcKPRAhuSSv12KmmTkowrmNMMOcOqF-pv75_AVaciNdsSi8Ll64etHFWrH-1mT3YvIkBdk-nRq9f82jBejnyY44APyffLCjK-XQ4Tj_t1r8kZ8goNrLUNWLqCP2T8xPxKRXxHaGQpdWMSA31ov3mbLepQgw" &&\
    rpm -i cuda-repo-rhel7-10-0-local-10.0.130-410.48-1.0-1.x86_64.rpm &&\
    yum clean all &&\
    yum install cuda &&\
    rm -f cuda-repo-rhel7-10-0-local-10.0.130-410.48-1.0-1.x86_64.rpm
USER 1000