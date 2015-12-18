# Introduction:

 An easy way to do RHEV-H provision and testing on physical machine.


 mastserver.py:

	This file need to be deployed on the control server and used to control the test
	server usage. During the testing, the program first need to check with
	control server whether server is using by the other user, if not, then
	notice the control server to lock the test machine and run testing. After finishing 
	the testing, the program notices the control server to unlock the test server.

 autophysion.sh:

	Run automatic provision RHEV-H and testing, this program could control
	test server power management module, work with our private cobbler server
	to provison RHEV-H, call the test case script to run the test case on 
	target RHEV-H version and test server.

 ENV:

	The global environment parameter, you need customize some parameters in
	this file after you deploy this project to your place.

 phymachine.conf:

	Test servers configuration file.

 testcase.conf:

	Test cases configuration file.


# Getting started:

 1. Clone the code to local.

	$ git clone git@10.8.48.252:cwu/autophysion.git

 2. Check necessary packages.

	./autophysion.sh -p


# Usage:

 1. First of all, you need make sure that the mastserver.py is already deployed and is
	running on the control server, if not, you need to deploy and running it

	Run:
		python2.7 mastserver.py

	Check if already running:
		curl -i http://${control server}:9999/check

 2. Print help message:

	$ sudo ./autophysion.sh -h

	Usage : ./autophysion.sh [OPTION]...
		-a Host Alias		Host Alias for provision, -l to show details.
		-c 			List all the test case for target machine.
		-d URL			Deploy target RHEV-H profile on cobbler server.
		-l 			List all the physcial machines and RHEV-H profiles on cobbler server.
		-m			List all the physical machines which can be provisioned.
		-n Host Cobbler Name	Host Cobbler Name for provision.
		-i 			Install RHEV-H only, must work with -t option attach one case id.
		-p 			Check the necessary packages whether exist.
		-r RHEV-H Version	RHEV-H Version, please provide the unique RHEV-H version name.
		-t [C3|C6|C9....]	Work with -a and -r option to run the given test case.
		-h			Print this message.

# Example

 1. Install RHEV-H 7.2 on hp-dl385pg8-11-M-FC, then run all the test case in testcase.conf file.

	$ sudo ./autoprovision.sh -a HP_MFC_VLAN -r rhev-hypervisor7-7.2-20151118.0.iso 

 2. Install RHEV-H 7.2 on hp-dl385pg8-11-M-FC, then run the test case C1 and C3 in testcase.conf file.

	$ sudo ./autoprovision.sh -a HP_MFC_VLAN -r rhev-hypervisor7-7.2-20151112.1.iso -t "C1|C3"

 3. List all the configured test servers.

	$ sudo ./autophysion.sh -m

 4. List all the test servers and RHEV-H build which already configred on cobbler server.

	$ sudo ./autophysion.sh -l

 5. List all the configured test cases.

	$ sudo ./autophysion.sh -c

 6. Deploy RHEV-H profile on cobbler server.

	$ sudo ./autophysion.sh -d http://10.66.11.225:8090/monitor/rhevh_build/7.2/vdsm7/20151119.0_35/rhev-hypervisor7-7.2-20151119.0.iso



