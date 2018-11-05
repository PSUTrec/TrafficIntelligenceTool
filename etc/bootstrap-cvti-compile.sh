sudo apt-get update
sudo apt-get install -y git build-essential checkinstall cmake pkg-config yasm checkinstall software-properties-common mercurial
sudo apt-get install -y gfortran libjpeg8-dev libjasper-dev libpng12-dev libtiff5-dev libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev libxine2-dev libv4l-dev gstreamer1.0-plugins-base libgstreamer0.10-dev libavresample-dev libopenblas-dev libgstreamer-plugins-base0.10-dev qt5-default libgtk2.0-dev libtbb-dev libatlas-base-dev liblapacke-dev libfaac-dev libmp3lame-dev libtheora-dev libvorbis-dev libxvidcore-dev libopencore-amrnb-dev libopencore-amrwb-dev x264 v4l-utils libprotobuf-dev protobuf-compiler libgoogle-glog-dev libgflags-dev libgphoto2-dev libeigen3-dev libhdf5-dev doxygen libhdf5-dev tesseract-ocr liblept5 leptonica-progs libleptonica-dev libtesseract-dev liblapack-dev freeglut3-dev python-dev python3-dev libxt6 xauth unzip
sudo apt-get install -y python-dev python-pip python3-dev python3-pip python3-tk supervisor
sudo apt-get install -y libboost-dev libboost-program-options-dev libboost-graph-dev libboost-filesystem-dev libboost-system-dev libsqlite3-dev libcppunit-dev
sudo -H pip2 install -U pip numpy
sudo -H pip3 install -U pip numpy
sudo -H pip3 install -U pip jupyter

sudo dpkg -i /vagrant/release/vtk_8.1.1-8.1.1_amd64.deb
sudo sh -c 'echo "/usr/local/lib" >> /etc/ld.so.conf.d/vtk.conf'
sudo ldconfig
mkdir /home/vagrant/dev
cd /home/vagrant/dev && git clone --depth 1 --branch 3.4.3 https://github.com/opencv/opencv
cd /home/vagrant/dev && git clone --depth 1 --branch 3.4.3 https://github.com/opencv/opencv_contrib
cd /home/vagrant/dev/opencv && mkdir build
cd /home/vagrant/dev/opencv/build && sudo cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local \
            -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
            -D PYTHON2_EXECUTABLE=/usr/bin/python \
            -D PYTHON_INCLUDE_DIR=/usr/include/python2.7 \
            -D PYTHON_INCLUDE_DIR2=/usr/include/x86_64-linux-gnu/python2.7 \
            -D PYTHON3_EXECUTABLE=/usr/bin/python3 \
            -D PYTHON3_INCLUDE_DIR=/usr/include/python3.5m \
            -D  PYTHON3_INCLUDE_DIR2=/usr/include/x86_64-linux-gnu/python3.5m \
            -D PYTHON2_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython2.7.so \
            -D PYTHON3_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython3.5m.so \
            -D PYTHON2_NUMPY_INCLUDE_DIRS=/usr/local/lib/python2.7/dist-packages/numpy/core/include \
            -D PYTHON3_NUMPY_INCLUDE_DIRS=/usr/local/lib/python3.5/dist-packages/numpy/core/include \
            -D INSTALL_C_EXAMPLES=ON \
            -D INSTALL_PYTHON_EXAMPLES=ON \
            -D BUILD_EXAMPLES=ON \
            -D WITH_V4L=ON \
            -D WITH_QT=OFF \
            -D WITH_OPENGL=ON \
            -DENABLE_CXX11=ON  \
            ..
cd /home/vagrant/dev/opencv/build && sudo make
cd /home/vagrant/dev/opencv/build && sudo checkinstall --install=yes -y --pkgname=opencv --pkgversion=3.4.3 --type=debian --requires=gfortran,libjpeg8-dev,libjasper-dev,libpng12-dev,libtiff5-dev,libavcodec-dev,libavformat-dev,libswscale-dev,libdc1394-22-dev,libxine2-dev,libv4l-dev,gstreamer1.0-plugins-base,libgstreamer0.10-dev,libavresample-dev,libopenblas-dev,libgstreamer-plugins-base0.10-dev,qt5-default,libgtk2.0-dev,libtbb-dev,libatlas-base-dev,liblapacke-dev,libfaac-dev,libmp3lame-dev,libtheora-dev,libvorbis-dev,libxvidcore-dev,libopencore-amrnb-dev,libopencore-amrwb-dev,x264,v4l-utils,libprotobuf-dev,protobuf-compiler,libgoogle-glog-dev,libgflags-dev,libgphoto2-dev,libeigen3-dev,libhdf5-dev,doxygen,libhdf5-dev,tesseract-ocr,liblept5,leptonica-progs,libleptonica-dev,libtesseract-dev,liblapack-dev,freeglut3-dev,python-dev,python3-dev,libxt6,xauth
sudo ldconfig
cd /home/vagrant/dev/opencv/build && cp *.deb /vagrant/release
cd /home/vagrant/dev && sudo hg clone https://Nicolas@bitbucket.org/trajectories/trajectorymanagementandanalysis
cd /home/vagrant/dev/trajectorymanagementandanalysis && sudo patch -p1 < /vagrant/release/trajectorymanagementandanalysis_opencv_3_4_3.patch
cd /home/vagrant/dev/trajectorymanagementandanalysis/trunk/src/TrajectoryManagementAndAnalysis && sudo cmake .
cd /home/vagrant/dev/trajectorymanagementandanalysis/trunk/src/TrajectoryManagementAndAnalysis && sudo make TrajectoryManagementAndAnalysis
cd /home/vagrant/dev && sudo hg clone https://bitbucket.org/Nicolas/trafficintelligence
cd /home/vagrant/dev/trafficintelligence && sudo patch -p1 < /vagrant/release/trafficintelligence_opencv_3_4_3.patch
cd /home/vagrant/dev/trafficintelligence && sudo make
cd /home/vagrant/dev/trafficintelligence && sudo checkinstall --install=yes -y --pkgname=trafficintelligence --pkgversion=0.22 --type=debian  --requires=libboost-dev,libboost-program-options-dev,libboost-graph-dev,libboost-filesystem-dev,libboost-system-dev,libsqlite3-dev,libcppunit-dev
cd /home/vagrant/dev/trafficintelligence && sudo -H pip2 install -r python-requirements.txt
cd /home/vagrant/dev/trafficintelligence && sudo -H pip3 install -r python-requirements.txt
cd /home/vagrant/dev/trafficintelligence && cp python-requirements.txt /vagrant/release
cd /home/vagrant/dev/trafficintelligence && cp *.deb /vagrant/release
cp /vagrant/release/jupyter_notebook_config.py /home/vagrant/
sudo service supervisor start
sudo cp /vagrant/release/jupyter.conf /etc/supervisor/conf.d/
sudo supervisorctl reread
sudo supervisorctl update
