C:\>**mping.bat input_file.txt**
Processing IP addresses from input_file.txt...

PASSED 192.168.1.1
FAILED 192.168.1.185
FAILED 192.168.1.20

Task completed.
Passed IP Addresses: passed_ips.txt
Failed IP Addresses: failed_ips.txt


C:\>

C:\>more input_file.txt
192.168.1.1
192.168.1.185
192.168.1.20


C:\>more passed_ips.txt
192.168.1.1

C:\>more failed_ips.txt
192.168.1.185
192.168.1.20

C:\>
