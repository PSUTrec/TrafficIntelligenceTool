sudo apt-get update
sudo apt-get install -y python-dev python-pip python3-dev python3-pip python3-tk supervisor unzip
sudo -H pip2 install -U pip numpy
sudo -H pip3 install -U pip numpy
sudo -H pip3 install -U pip jupyter

sudo apt-get install -y /vagrant/vtk_8.1.1-8.1.1_amd64.deb
sudo apt-get install -y /vagrant/opencv_3.4.3-1_amd64.deb
sudo apt-get install -y /vagrant/trafficintelligence_0.22-1_amd64.deb
sudo sh -c 'echo "/usr/local/lib" >> /etc/ld.so.conf.d/opencv.conf'
sudo ldconfig
sudo -H pip2 install -r /vagrant/python-requirements.txt
sudo -H pip3 install -r /vagrant/python-requirements.txt
cp /vagrant/jupyter_notebook_config.py /home/vagrant/
sudo service supervisor start
sudo cp /vagrant/jupyter.conf /etc/supervisor/conf.d/
sudo supervisorctl reread
sudo supervisorctl update
