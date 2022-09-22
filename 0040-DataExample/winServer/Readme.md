## VM Build

its a terraform module builds a VM based and attached the network interface to an existing VNet



### inputs
1. `rgname` the name of the resource group for the server
2. `location` the location for the deployment
3. `subnetid` the subnet ID the network card attaches to
4. `vmname` the name of the VM
5. `size` The size of the VM
6. `localadmin` the local admin account, cannot be administrator
7. `adminpw` the local admin password, must be 12 char or longer

### outputs
1. `vm_id_out`  the id of newlly created VM
2. `vm_ip_out` the ip of newlly created VM