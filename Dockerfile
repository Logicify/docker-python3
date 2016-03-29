FROM logicify/centos7
MAINTAINER "Dmitry Berezovsky <dmitry.berezovsky@logicify.com>"

ENV APPLICATION_DIR="/srv/application"

# Install required packages
RUN yum -y install python34 python-virtualenv postgresql-devel gcc python34-devel \ 
 libtiff-devel libjpeg-devel libzip-devel freetype-devel lcms2-devel libwebp-devel tcl-devel tk-devel

# Install pip3
RUN curl https://bootstrap.pypa.io/get-pip.py | python3.4
# install virtualenv
RUN pip3 install virtualenv

# Create virtual environment
RUN cd /srv \
       && virtualenv --python=python3 virtenv \
       && chown app:app -R /srv/virtenv
       
RUN mkdir $APPLICATION_DIR && chown app:app -R $APPLICATION_DIR && cd $APPLICATION_DIR
       
USER app
WORKDIR $APPLICATION_DIR

RUN echo "source /srv/virtenv/bin/activate" >> "/home/app/.bashrc"

CMD ["/bin/bash"]
