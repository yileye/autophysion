#!/bin/bash

sshpass -p "${RHEVHNewPasswd}" ssh root@${HOSTIPAddr} -o StrictHostKeyChecking=no "
echo ----------------------RHEV-H version--------------------------
cat /etc/redhat-release
echo ---------------------------df -h------------------------------
ps auxZ
echo ---------------------------ERROR------------------------------
cat /var/log/ovirt-node.log| grep Traceback
cat /var/log/ovirt.log| grep Traceback
" > ${TESTCASELOG}/${CASEPolarionID}.output 2>&1

scp_output=$(/usr/bin/expect <<-EOF
	set timeout ${expect_timeout}
	spawn -noecho scp -o StrictHostKeyChecking=no root@${HOSTIPAddr}:/var/log/ovirt*.log ${TESTCASELOG}/;
	expect {
		"s password:" {
			send -- "${RHEVHNewPasswd}\r"
		}
	}
	expect eof
	EOF
)

exit 0
