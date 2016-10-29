## biemond-orawls-vagrant-12.2.1

The puppet 4.2 reference implementation of https://github.com/biemond/biemond-orawls

optimized for linux, Solaris and the use of Hiera

Should work for VMware and Virtualbox

### Details
- CentOS 7.0 Vagrant box
- Puppet 4.2.2
- Vagrant >= 1.8.0
- Oracle Virtualbox >= 5.0
- VMware fusion >= 6

creates a 12.2.1 WebLogic cluster ( admin, node1, node2 )

site.pp is located here:
https://github.com/biemond/biemond-orawls-vagrant-12.2.1/blob/master/puppet/environments/development/manifests/site.pp

The used hiera files https://github.com/biemond/biemond-orawls-vagrant-12.2.1/tree/master/puppet/hieradata

Add the all the Oracle binaries to /software

edit Vagrantfile and update the software share
- admin.vm.synced_folder "software", "/software"
- node1.vm.synced_folder "software", "/software"
- node2.vm.synced_folder "software", "/software"

### Software
- Weblogic 12.2.1.2 [fmw_12.2.1.2.0_wls.jar](http://www.oracle.com/technetwork/middleware/fusion-middleware/downloads/index.html)
- JDK 8 [jdk-8u72-linux-x64.tar.gz](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
- JCE Policy 8 [jce_policy-8.zip](http://www.oracle.com/technetwork/java/javase/downloads/jce8-download-2133166.html)

### Startup the images

- vagrant up admin
- vagrant up node1
- vagrant up node2

### manual startup puppet

- vagrant ssh admin
- sudo -i
- puppet apply --verbose --report --trace /vagrant/puppet/environments/development/manifests/site.pp


### rest application on cluster

- http://10.10.10.100:8001/Product-context-root/jersey/products/
- http://10.10.10.200:8001/Product-context-root/jersey/products/

### MT

- undeploy jerser-bundle-1.18.war and webapp.war from WebCluster


- Resource Group Template
    - AppTemplateProduct

- Deployments to AppTemplateProduct Resource Template
    - jerser-bundle-1.18.war to AppTemplateProduct (not global)
    - webapp.war to AppTemplateProduct (not global)

- FileStore
    - FileStoreMT
        - File
        - scope AppTemplateProduct

- JMS server
    - JMSServerMT
        - scope AppTemplateProduct
        - FileStoreMT

- SystemModuleMT
    - scope AppTemplateProduct
    - sub deployment
        - jms_servers
            - JMSServerMT
    - Distributed Queues
        - DistributedQueueMT
            - jndi jms/DistributedQueueMT
            - target sub deployment jms_servers
    - Connection factory
        - ConnectionFactoryMT
            - jndi jms/ConnectionFactoryMT


- JDBC to pluggable database
    - XXXX

for every tenant
    - virtual targets
        - CustomerA
            - WebCluster
            - 10.10.10.100\n 10.10.10.200\n
            - /customer_a
            - port 8011
        - CustomerB
            - WebCluster
            - 10.10.10.100\n 10.10.10.200\n
            - /customer_b

    - realms
        - realm_CustomerA
            - create new providers
            - add user test with group Administrators
        - realm_CustomerB
            - create new providers

    - domain partitions
        - Partition-Products-CustomerA
            - ResourceGroupA
                - AppTemplateProduct
            - realm_CustomerA
            - virtual targets
                - CustomerA
            - Override resources
                - JDBC
        - Control start Partition-Products-CustomerA

        - Partition-Products-CustomerB
            - ResourceGroupA
                - AppTemplateProduct
            - realm_CustomerB
            - virtual targets
                - CustomerB
            - Override resources
                - JDBC
        - Control start Partition-Products-CustomerB

- CustomerA
    - http://10.10.10.100:8011/customer_a/Product-context-root/jersey/products
    - http://10.10.10.200:8011/customer_a/Product-context-root/jersey/products
- CustomerB
    - http://10.10.10.100:8021/customer_b/Product-context-root/jersey/products
    - http://10.10.10.200:8021/customer_b/Product-context-root/jersey/products

- WLST
   - connect('test','weblogic1','t3://10.10.10.100:8011/customer_a')

- JConsole
   - service:jmx:t3://10.10.10.100:8011/customer_a/jndi/weblogic.management.mbeanservers.runtime