# Traffic Intelligence Tools
Turn key solution of compilation and deployment of [Traffic Intelligence Tools](https://bitbucket.org/Nicolas/trafficintelligence/wiki/Home) with opencv 3.4.3 on Windows platform.

## Install required programs
After clone the project, you need to run the [install script](https://github.com/PSUTrec/TrafficIntelligenceTool/blame/master/scripts/installti.bat) as Administrator. 
![Run](doc/installti.png)

### Following programs will be installed onto your windows system:
- git -- for code download
- vagrant -- virtualbox VM manager
- virtualbox -- ubuntu 16.04 virtual machine
- mobaxterm -- running X-app on windows

### Compiling opencv 3.4.3 and Traffic Intelligence 
After required app installed, the script will create a directory `cvtivm` at the parent folder and copy bootstrap files to start a Ubuntu 16.04 VM as a host to compile opencv and traffic intelligence software. 

The compilation usually will take **3-5 hours**. After compilation is done opencv 3.4.3 and traffic intelligence debian installation packages will be created and copied to the release folder. Those packages can be installed on ubuntu 16.04 platform. 

### Using traffic intelligence on windows
Inside the `cvtivm` folder three directories are created:
- release -- compiled ubuntu packages copied here
- test -- traffic intelligence test package
- jupyter -- jupyter notebook sample for traffic intelligence
`test` and `jupyter` folders are mirrored (shared) in the virtual machine. 
#### Run mobxterm ![mobxterm](doc/search_mobxterm.PNG)
