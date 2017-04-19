FROM logicify/centos7
MAINTAINER "Dmitry Berezovsky <dmitry.berezovsky@logicify.com>"

ENV APPLICATION_DIR="/srv/application"

# Install required packages
RUN yum -y install python35 python-virtualenv postgresql-devel gcc python35-devel \ 
 libtiff-devel libjpeg-devel libzip-devel freetype-devel lcms2-devel libwebp-devel tcl-devel tk-devel \ 
 libxslt-devel libxml2-devel

# Install pip3
RUN curl https://bootstrap.pypa.io/get-pip.py | python3.5
# install virtualenv
RUN pip3 install virtualenv

# Create virtual environment
RUN cd /srv \
       && virtualenv --python=python3 virtenv \
       && chown -R app:app /srv/virtenv
       
RUN mkdir $APPLICATION_DIR && chown -R app:app $APPLICATION_DIR && cd $APPLICATION_DIR
       
USER app
WORKDIR $APPLICATION_DIR

RUN echo "source /srv/virtenv/bin/activate" >> "/home/app/.bashrc" \
    && echo "export LANG=en_US.utf8" >> /home/app/.bashrc

CMD ["/bin/bash"]

VOLUME ["$APPLICATION_DIR"]
