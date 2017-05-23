############################################################
# Dockerfile to build flask-visualizer container images
# Based on Ubuntu
############################################################

################## BEGIN INSTALLATION ######################
# Set the base image to ubuntu
FROM debian

# File Author / Maintainer
MAINTAINER Simon Meoni

# Update the repository sources list

## update repository source && dependencies
RUN apt-get update
RUN apt-get install -y python3 
RUN apt-get install -y python3-dev 
RUN apt-get install -y nginx 
RUN apt-get install -y git 
RUN apt-get install -y python3-pip 
RUN apt-get install -y libxml2-dev libxslt-dev zlib1g-dev
RUN git clone https://github.com/simonmeoni/flask-visualizer
RUN pip3 install -r flask-visualizer/requirements.txt
RUN cd flask-visualizer && sed -i -e "s/app.run()/app.run(debug=False, host='0.0.0.0')/g" app.py
ADD ./wsgi.py /flask-visualizer/wsgi.py

##################### INSTALLATION END #####################
EXPOSE 8000
CMD cd flask-visualizer && gunicorn --bind 0.0.0.0:8000 wsgi