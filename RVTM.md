| Requirement | Description | Test |
|-------------|-------------|------|
| Num.1 | Redundant AD infrastructure using DC1 + DC2. One should be able to turn off DC1 or DC2, and still be able to manage AD and login via W1 + W2 + MGMT1. | 1.1 1.2 |
| Num.2 | DHCP1 and DHCP2 should provide DHCP services to your LAN. They should also be redundant. Turn off DHCP1 or 2 and ipconfig/release and /renew from W1. | 2.1 |
| Num.3 | MGMT2 will be an Ansible controller system that can control your entire domain, with the exception of Windows workstations and the firewall. You should be able to run interactive commands against all these systems. | 3.1 3.2 |
| Num.4 | Util will be a system that you can provision with a new application via MGMT2 and Ansible. It can also be used to assist in meeting other requirements. Deploy an application that has not been covered in class to util, using an Ansible playbook. | 4.1 |
| Num.5 | MGMT1, DC1, DC2, DFS1, DFS2 and your workstations wks01 wks02 represent your Active Directory Infrastructure. Your domain should be your groupname.local (backrow.local). Join all Windows systems to the domain and at least one of your Linux systems. | 5.1 5.2 5.3 5.4 |
| Num.6 | Create an AD security group called linux-admins. Members of this group should be able to sudo to root on one of your Linux systems (this has some implied sub requirements). | 6.1 |
| Num.7 | Install docker and a wiki/application of your choice on docker. (NOT WORDPRESS!) | 7.1 |
| Num.8 | Create a Domain Group Policy that allows W1 + W2 to remote desktop between one another. | 8.1 |
| Num.9 | Create a Domain Group Policy that applies corporate wallpaper to W1 + W2 + MGMT1. | 9.1 |
| Num.10 | Create a Domain group policy that moves W1 and W2 user profiles and home directories to a DFS share. | 10.1 |
| Num.11 | Use Ansible to install an apt-package. | 11.1 |
| Num.12 | Use Ansible to install a yum package. | 12.1 |
| Num.13 | Use Ansible to add a new Linux local user that can be an SSH user or one with a password. | 13.1 |
| Num.14 | Use Ansible to add a new Windows domain user. | 14.1 |
