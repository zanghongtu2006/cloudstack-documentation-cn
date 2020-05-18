��    T      �      \      \  �  ]  |     �   �  �   t  ;   0	  �  l	  H   �
  �   :  �  �  
   �  �  �     {  �   �  "   C     f  �   |  e   I     �  �   �  +  i  �   �  �   6     �     �  �   �     r  �   u  -   ,  \  Z     �     �  
   �     �       .      �   O  �  �     �     �     �  O   �     C     V  �   Y     �  B     2   V     �     �     �     �  3  �  �      �   �   =   l!  ,   �!  ,  �!  I   #  4   N#  �   �#  �   M$  �   %  Y   �%  Y   &  N   j&  �   �&  �   y'  G   (  +   W(     �(     �(     �(     �(  �  �(     �*  �   �*     s+  $   �+     �+     �+     �+     ,      ,  �  9,  X  
.  o   c/  �   �/  �   �0  H   S1  Q  �1  E   �2  �   43  �  �3  	   x5  N  �5     �6  �   �6     �7     �7  �   �7  X   h8     �8  z   �8    V9  |   ]:  �   �:     �;     �;  v   �;  	   #<  �   -<  -   =  "  ==     `>     o>     �>     �>     �>  0   �>  o   �>  �  e?     �B     C      C  <   $C     aC     nC  �   rC     	D  *   D  0   GD     xD     �D     �D     �D  
  �D  �   �E  �   OF  $   �F  -   G  �   1G  B   H  $   KH  �   pH  �   SI  �   &J  C   �J  @   �J  ]   <K  �   �K  �   YL  2   �L  $   "M     GM     ZM     jM     nM  �  ~M     ,O  �   2O     �O  $   P     2P     PP     oP     �P     �P   (XenServer) Configure the XenServer dom0 settings to allocate more memory to dom0. This can enable XenServer to handle larger numbers of virtual machines. We recommend 2940 MB of RAM for XenServer dom0. For instructions on how to do this, see `http://support.citrix.com/article/CTX126531 <http://support.citrix.com/article/CTX126531>`_. The article refers to XenServer 5.6, but the same information applies to XenServer 6.0. 10G networks are generally recommended for storage access when larger servers that can support relatively more VMs are used. A firewall provides a connection to the Internet. The firewall is configured in NAT mode. The firewall forwards HTTP requests and API calls from the Internet to the Management Server. The Management Server resides on the management network. A layer-2 access switch layer is established for each pod. Multiple switches can be stacked to increase port count. In either case, redundant pairs of layer-2 switches should be deployed. A layer-2 switch connects all physical servers and storage. A layer-3 switching layer is at the core of the data center. A router redundancy protocol like VRRP should be deployed. Typically high-end core switches also include firewall modules. Separate firewall appliances may also be used if the layer-3 switch does not have integrated firewall capabilities. The firewalls are configured in NAT mode. The firewalls provide the following functions: A single NFS server functions as both the primary and secondary storage. A staging system that models the production environment is strongly advised. It is critical if customizations have been applied to CloudStack. Allow adequate time for installation, a beta, and learning the system. Installs with basic networking can be done in hours. Installs with advanced networking usually take several days for the first attempt, with complicated installations taking longer. For a full production system, allow at least 4-8 weeks for a beta to work through all of the integration issues. You can get help from fellow users on the cloudstack-users mailing list. Bare Metal Be sure all the hotfixes provided by the hypervisor vendor are applied. Track the release of hypervisor patches through your hypervisor vendor’s support channel, and apply patches as soon as possible after they are released. CloudStack will not track or notify you of required hypervisor patches. It is essential that your hosts are completely up to date with the provided hypervisor patches. The hypervisor vendor is likely to refuse to support any system that is not up to date with patches. Best Practices Bonded NIC and redundant switches can be deployed for NFS. In NFS deployments, redundant switches and bonded NICs still result in one network (one CIDR block+ default gateway address). Choosing a Deployment Architecture Choosing a Hypervisor CloudStack supports many popular hypervisors. Your cloud can consist entirely of hosts running a single hypervisor, or you can use multiple hypervisors. Each cluster of hosts must run the same hypervisor. Conserve management traffic IP address by using link local network to communicate with virtual router DRS Data Center 1 houses the primary Management Server as well as zone 1. The MySQL database is replicated in real time to the secondary Management Server installation in Data Center 2. Deploying a cloud is challenging. There are many different technology choices to make, and CloudStack is flexible enough in its configuration that there are many possible ways to combine and configure the chosen technology. This section contains suggestions and requirements about cloud deployments. Each host should be configured to accept connections only from well-known entities such as the CloudStack Management Server or your network monitoring software. Each pod contains storage and computing servers. Each storage and computing server should have redundant NICs connected to separate layer-2 access switches. Feature FibreChannel Forwards HTTP requests and API calls from the Internet to the Management Server. The Management Server resides on the management network. HA Host capacity should generally be modeled in terms of RAM for the guests. Storage and CPU may be overprovisioned. RAM may not. RAM is usually the limiting factor in capacity designs. How many Management Servers will be deployed. In the large-scale redundant setup described in the previous section, storage traffic can overload the management network. A separate storage network is optional for deployments. Storage protocols such as iSCSI are sensitive to network delays. A separate storage network ensures guest network traffic contention does not impact storage performance. KVM - RHEL 6.2 Large-Scale Redundant Setup Local Disk Local disk as data disk Maintenance Best Practices Manual live migration of VMs from host to host Monitor host disk space. Many host failures occur because the host's root disk fills up from logs that were not rotated adequately. Monitor the total number of VM instances in each cluster, and disable allocation to the cluster if the total is approaching the maximum that the hypervisor can handle. Be sure to leave a safety margin to allow for the possibility of one or more hosts failing, which would increase the VM load on the other hosts as the VMs are redeployed. Consult the documentation for your chosen hypervisor to find the maximum permitted number of VMs per host, then use CloudStack global configuration settings to set this as the default limit. Monitor the VM activity in each cluster and keep the total number of VMs below a safe level that allows for the occasional host failure. For example, if there are N hosts in the cluster, and you want to allow for one host in the cluster to be down at any given time, the total number of VM instances you can permit in the cluster is at most (N-1) \* (per-host-limit). Once a cluster reaches this number of VMs, use the CloudStack UI to disable allocation to the cluster. Multi-Node Management Server Multi-Site Deployment N/A NIC bonding is straightforward to implement and provides increased reliability. Network Throttling No Primary storage mountpoints or LUNs should not exceed 6 TB in size. It is better to have multiple smaller primary storage elements per cluster than one large one. Process Best Practices Secondary storage servers are connected to the management network. Security groups in zones that use basic networking Separate Storage Network Setup Best Practices Small-Scale Deployment Snapshots of local disk The CloudStack Management Server is deployed on one or more front-end servers connected to a single MySQL database. Optionally a pair of hardware load balancers distributes requests from the web. A backup management server set may be deployed using MySQL replication at a remote site to add DR capabilities. The CloudStack platform scales well into multiple sites through the use of zones. The following diagram shows an example of a multi-site deployment. The Management Server cluster (including front-end load balancers, Management Server nodes, and the MySQL database) is connected to the management network through a pair of load balancers. The Management Server is connected to the management network. The administrator must decide the following. The architecture used in a deployment will vary depending on the size and purpose of the deployment. This section contains examples of deployment architecture, including a small-scale deployment useful for test and trial deployments and a fully-redundant large-scale setup for production deployments. The lack of up-do-date hotfixes can lead to data corruption and lost VMs. There are two ways to configure the storage network: These should be treated as suggestions and not absolutes. However, we do encourage anyone planning to build a cloud outside of these guidelines to seek guidance and advice on the project mailing lists. This diagram illustrates a setup with a separate storage network. Each server has four NICs, two connected to pod-level network switches and two connected to storage network switches. This diagram illustrates the differences between NIC bonding and Multipath I/O (MPIO). NIC bonding configuration involves only one network. MPIO involves two separate networks. This diagram illustrates the network architecture of a large-scale CloudStack deployment. This diagram illustrates the network architecture of a small-scale CloudStack deployment. Use multiple clusters per pod if you need to achieve a certain switch density. When exporting shares on primary storage, avoid data loss by restricting the range of IP addresses that can access the storage. See "Linux NFS on Local Disks and DAS" or "Linux NFS on iSCSI". When the cloud spans multiple zones, the firewalls should enable site-to-site VPN such that servers in different zones can directly reach each other. Whether MySQL replication will be deployed to enable disaster recovery. Whether or not load balancers will be used. Work load balancing XenServer 6.0.2 Yes Yes (Native) You might already have an installed base of nodes running a particular hypervisor, in which case, your choice of hypervisor has already been made. If you are starting from scratch, you need to decide what hypervisor software best suits your needs. A discussion of the relative advantages of each hypervisor is outside the scope of our documentation. However, it will help you to know which features of each hypervisor are supported by CloudStack. The following table provides this information. iSCSI iSCSI can take advantage of two separate storage networks (two CIDR blocks each with its own default gateway). Multipath iSCSI client can failover and load balance between separate storage networks. vSphere 4.1/5.0 |Example Of A Multi-Site Deployment| |Large-Scale Redundant Setup| |Multi-Node Management Server| |NIC Bonding And Multipath I/O| |Separate Storage Network| |Small-Scale Deployment| Project-Id-Version: Apache CloudStack Installation RTD
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2014-06-30 11:42+0200
PO-Revision-Date: 2014-06-30 10:22+0000
Last-Translator: FULL NAME <EMAIL@ADDRESS>
Language-Team: Chinese (China) (http://www.transifex.com/projects/p/apache-cloudstack-installation-rtd/language/zh_CN/)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Language: zh_CN
Plural-Forms: nplurals=1; plural=0;
 (XenServer)可以为Xenserver的dom0分配更多的内存来让其支持更多的虚拟机。我们推荐为dom0设置的内存数值为2940 MB。至于具体操作，可以参见如下URL：`http://support.citrix.com/article/CTX126531 <http://support.citrix.com/article/CTX126531>`_。这篇文章可同时适用于XenServer 5.6和6.0版本。 当有大量服务器支持相当多的虚拟机时，推荐在存储访问的网络上采用将10G的带宽。 防火墙提供了到Internet的连接.此防火墙被配置成NAT模式，它会将来自Internet的HTTP访问和API调用转发到管理服务器。而管理服务器的网络属于管理网络。 layer-2的接入交换层连接到每个提供点（POD），也可以用多个交换机堆叠来增加端口数量。无论哪种情况下，都应该部署冗余的二层交换机。 一个二层交换机连接所有的物理服务器和存储服务器。 三层交换层处于数据机房的核心位置。应该部署类似VRRP的冗余路由协议实现设备热备份。通常，高端的核心交换机上包含防火墙模块。如果三层交换机上没有集成防火墙功能，也可以使用独立防火墙设备。防火墙一般会配置成NAT模式，它能提供如下功能： 单一的NFS服务器需要能同时提供主存储和辅助存储。 强烈建议在系统部署至生产环境之前，有一个完全模拟生产环境的集成系统。对于已经在CloudStack中做了自定义修改的系统来说，更为重要了。 应该为安装，学习和测试系统预留充足的时间。简单网络模式的安装可以在几个小时内完成。但首次尝试安装高级网络模式通常需要花费几天的时间，完全安装则需要更长的时间。正式生产环境上线前，通常需要4-8周用以排除集成过程中的问题，你也可从cloudstack-users的邮件列表里得到更多帮助。 裸设备 确保安装了所有系统补丁供应商提供的所有系统补丁。请随时关注供应商的技术支持渠道，一旦发布补丁，请尽快打上补丁。CloudStack不会跟踪或提醒你安装这些程序。安装最新的补丁对主机至关重要。虚拟化供应商可能不会对过期的系统提供技术支持。 最佳实践 为NFS配置网卡绑定和冗余交换机。在NFS部署中，冗余的交换机和网卡绑定仍然处于同一网络。(同一个CIDR 段 + 默认网关地址) 选择部署架构 选择Hypervisor CloudStack支持多种流行的Hypervisor，你可以在所有的主机上使用一种，也可以使用不同的Hypervisor，但在同一个群集内的主机必须使用相同的Hypervisor。 使用本地链路与虚拟路由器（VR）直接通讯来保护管理网络的IP流量 DRS-分布式资源调度 在数据中心1内有主管理节点和区域1。MySQL数据库实时复制到数据中心2内的辅助管理节点中。 部署云计算服务是一项挑战。这需要在很多不同的技术之间做出选择，CLOUDSTACK以其配置灵活性可以使用很多种方法将不同的技术进行整合和配置。这个章节包含了一些在云计算部署中的建议及需求。 每一个主机都应该配置为只接受已知设备的连接，如CLOUDSTACK管理节点或相关的网络监控软件。 每一个机柜提供点（POD）包括存储和计算节点服务器。每一个存储和计算节点服务器都需要有冗余网卡连接到不同的 layer-2 接入交换机上。 功能特点 光纤通道 将来自Internet的HTTP访问和API调用转发到管理节点服务器。管理服务器的网络属于管理网络. 高可用 主机可创建的虚拟机的能力，主要取决于提供给客户虚拟机的内存。因为主机的存储和CPU均可超配，但内存却基本不可以。所以内存是在系统容量设计时的主要限制因素。 需要部署多少台管理节点服务器。 在前面章节中，提及了大规模冗余部署，存储的数据流量过大可能使得管理网络过载。部署时可选择将存储网络分离出来。存储协议如iSCSI，对网络延迟非常敏感。独立的存储网络能够使其不受来宾网络流量波动的影响。 KVM - RHEL 6.2 大规模冗余设置 本地磁盘 用本地盘作为数据磁盘 维护最佳实践 手工在主机之间进行虚拟机的热迁移 监视主机的磁盘空间。很多主机故障的原因都是日志将主机的硬盘空间占满导致的。 要监控每个集群里的虚拟机总量，如果达到了hypervisor所能承受的最大虚拟机数量时，就要禁止向此集群分配虚机。并且，要确定预留一定的安全迁移容量，以防止群集中有主机故障，这将增大其他主机运行虚拟机压力，就像是重新部署一批虚拟机一样。咨询你选择 hypervisor的文档，找到每台主机所能支持的最大虚拟机数量，并将此数值作为默认限制配置在CLOUDSTACK的全局设置里。监控每个群集中虚拟机的活动，保持虚拟机数量在安全线内，以防止偶然的主机故障。例如：如果集群里有N个主机，如果要让集群中一主机在任意时间停机，那么，此集群最多允许的虚拟机数量值为：(N-1) \* (每宿主机最大虚拟量数量限值)。一旦达到此数量，必须在CLOUDSTACK的UI里禁止向此群集增加新的虚拟机。 多节点管理服务器 多站点部署 无 网卡绑定技术可以明显的增加系统的可靠性。 网络限速 否 主存储的挂载点或是LUN不应超过6TB大小。每个集群中使用多个小一些的主存储比只用一个超大主存储的效果要好。 实施最佳实践 辅助存储服务器接入管理网络。 在区域内用于基本网络模式的安全组 独立的存储网络 最佳实践安装 小型部署 本地磁盘快照 CloudStack管理服务器可以部署一个或多个前端服务器并连接单一的MySQL数据库。可视需求使用一对硬件负载均衡对Web请求进行分流。另一备份管理节点可使用远端站点的MySQL复制数据以增加灾难恢复能力。 运用CloudStack的区域技术可以很容易的将其扩散为多站点模式。下图就显示了一个多站点部署的示例 管理服务器集群(包括前端负载均衡节点，管理节点及MYSQL数据库节点)通过两个负载均衡节点接入管理网络。 管理服务器连接至管理网络 系统管理人员必须决定如下事项： 部署CloudStack的具体架构会因规模及用途的不同而变化。这一章节会包含一些典型的部署构架：用于测试和试验的小型架构，以及用于生产环境的大型全冗余架构。 缺乏最新补丁更新可能会导致数据和虚拟机丢失。 有两种方式配置存储网络： 这些内容应该被视为建议而不是绝对性的。然而，我们鼓励想要部署云计算的朋友们，除了这些建议内容之外，最好从CLOUDSTACK的项目邮件列表中获取更多建议指南性内容。 这个图展示了使用独立存储网络的设计。每一个物理服务器有四块网卡，其中两块连接到提供点级别的交换机，而另外两块网卡连接到用于存储网络的交换机。 此图展示了网卡绑定与多路径IO(MPIO)之间的区别，网卡绑定的配置仅涉及一个网段，MPIO涉及两个独立的网段。 这个图演示了CloudStack在大规模部署时的网络结构。 这个图演示了CloudStack在小型部署时的网络结构。 如果需要达到一定的高密度，可以在每个机柜提供点里部署多个集群。 在主存储上输出共享数据时，可用限制访问IP地址的方法避免数据丢失。更多详情，可参考"Linux NFS on Local Disks and DAS" "Linux NFS on iSCSI"这些章节。  当云跨越多个区域（Zone）时，防火墙之间应该启用site-to-site VPN，以便让不同区域中的服务器之间可以直接互通。 如何部署MYSQL复制以便启用灾难恢复。 是否需要使用负载均衡器。 工作负载均衡 XenServer 6.0.2 是 是（原生） 你可能已经安装并运行了特定的hypervisor节点，在这种情况下，你的Hypervisor选择已经确定了。如果还处于初步规划阶段，那么就需要决定那种Hypervisor能切合你的需求。各种Hypervisor的利弊讨论不在本文档之列。但无论如何，CloudStack可以支持每种Hypervisor的那些功能的详细信息还是能够帮到你的。下面的表格就提供了这些信息： iSCSI iSCSI能同时利用两个独立的存储网络(两个拥有各自默认网关的不同CIDR段)。支持iSCSI多路径的客户端能在两个独立的存储网络中实现故障切换和负载均衡。 vSphere 4.1/5.0 |Example Of A Multi-Site Deployment| |Large-Scale Redundant Setup| |Multi-Node Management Server| |NIC Bonding And Multipath I/O| |Separate Storage Network| |Small-Scale Deployment| 