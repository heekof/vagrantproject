Format of /etc/network/interfaces files to create virtual networks
==================================================================

1. FILE FORMATS

This directory contains interface files for virtual network nodes. They are
used as follows.

A topology consists of multiple nodes. Each node has an interface file
that specifies the IP address configuration of its network interfaces. 
That is, the file /etc/network/interfaces in Linux guest. To create
virtual networks, a base virtual machine (running Linux) is cloned to
create each node for the desired topology. Then the corresponding interface
file is copied to that node so when it boots the correct IP addressing
will be configured. The files in this directory are the interface files
for each node for pre-defined topologies.

The file names are formatted as:
interfaces-topology-TOPNUM-nodeNODENUM

where TOPNUM is the topology number and NODENUM is the number of the node
in that topology. For example, topology 5 has three nodes:
interfaces-topology-05-node-01
interfaces-topology-05-node-02
interfaces-topology-05-node-03

Each of those files are the /etc/network/interfaces files for the 
corresponding nodes. 

The files are normal interfaces files ("man interfaces" to see the format)
with one exception: each interface stanza should be preceded by a comment
of the formant:

# VBoxNetwork: NETNAME

where NETNAME is the name to give to the internal VirtualBox network.

For example, looking at interfaces-topology-05-node-01 you will see three normal
interface stanzas: lo, eth0 and eth1. Interface eth1 is used as a 
internal network in VirtualBox. Therefore it is preceded with the comment

# VBoxNetwork: neta

so that the 2nd virtual machine interface (which corresponds to eth1; the
1st virtual machine interface corresponds to eth0) will be configured
to use internal network name neta. That is done (in vn-newnode) using the
VBoxManage command:

VBoxManage modifyvm node1 --nic2 intnet --intnet neta

As another example, look at interfaces-topology-05-node-02. node2 will have two
internal interfaces: eth1 attached to neta and eth2 attached to netb. 

The interface stanzas should be given in the order of the corresponding 
virtual network adapaters of the VirtualBox VM, i.e.:

lo (not a virtual NIC)
eth0: NIC1 in VirtualBox
eth1: NIC2 in VirtualBox
eth2: NIC3 in VirtualBox
eth3: NIC4 in VirtualBox

By default, only 4 VirtualBox NICs are enabled on the base virtual machine
(allowing for only 3 internal interfaces; eth0/NIC1 is always used for 
the NAT interface for the virtual machine to access the real Internet). If
you want more internal interfaces, enable them first on the base virtual
machine.


2. USING EXISTING TOPOLOGIES

Some typical topologies have already been created. They can be used to create
a virtual network by running:

vn-createtopology TOPNUM

where TOPNUM is the desired topology number. This will create a virtual 
machine for each node in the topology, and copy the corresponding interface
file to /etc/network/interfaces within the guest.

PNG images of the provided topologies are in the directory data/images/, e.g.
topology 2 is drawn in:

virtnet-topology-02.png


3. CREATING YOUR OWN TOPOLOGY

To create your own topology, simply prepare the interface files for each
node in your network. I recommend using topology numbers starting from
100 (as I will number the topologies on SVN 1 to 99). So for example if
you want a topology with 4 nodes, create the files (by copying some existing
files):

interfaces-topology-100-node-01
interfaces-topology-100-node-02
interfaces-topology-100-node-03
interfaces-topology-100-node-04

Then edit each file, setting the desired IP addresses of eth1 (and 
optionally eth2 and eth3). Also be sure to include the line

# VBoxNetwork: NETNAME

before each interface and select the desired network name.

Now run:
vn-createtopology 100


For more info see: http://sandilands.info/sgordon/virtnet

$Revision$
$Author$
$Date$
$URL$
