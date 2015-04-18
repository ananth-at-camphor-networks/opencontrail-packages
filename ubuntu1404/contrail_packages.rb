#!/usr/bin/env ruby

@install_pkg = "apt-get -y install"
@uninstall_pkg = "apt-get -y remove"

@branch = "3.0" # master
@tag = "4100"
@pkg_tag = "#{@branch}-#{@tag}"

@common_packages = [
    "sshpass",
    "docker",
    "git",
    "strace",
    "tcpdump",
    "unzip",
]

@controller_thirdparty_packages = [
    @common_packages,
    "#{@ws}/thirdparty/authbind-2.1.1-0.x86_64.rpm",
    "#{@ws}/thirdparty/librdkafka1-0.8.5-2.0contrail0.el7.centos.x86_64.rpm",
    "#{@ws}/thirdparty/librdkafka-devel-0.8.5-2.0contrail0.el7.centos.x86_64.rpm",
    "#{@ws}/thirdparty/cassandra12-1.2.11-1.noarch.rpm",
    "#{@ws}/thirdparty/kafka-2.9.2-0.8.2.0.0contrail0.el7.x86_64.rpm",
    "#{@ws}/thirdparty/python-pycassa-1.10.0-0contrail.el7.noarch.rpm",
    "#{@ws}/thirdparty/thrift-0.9.1-12.el7.x86_64.rpm",
    "#{@ws}/thirdparty/python-thrift-0.9.1-12.el7.x86_64.rpm",
    "#{@ws}/thirdparty/python-bitarray-0.8.0-0contrail.el7.x86_64.rpm",
    "#{@ws}/thirdparty/python-jsonpickle-0.3.1-2.1.el7.noarch.rpm",
    "#{@ws}/thirdparty/python-amqp-1.4.5-1.el7.noarch.rpm",
    "#{@ws}/thirdparty/python-geventhttpclient-1.0a-0contrail.el7.x86_64.rpm",
    "#{@ws}/thirdparty/consistent_hash-1.0-0contrail0.el7.noarch.rpm",
    "#{@ws}/thirdparty/python-kafka-python-0.9.2-0contrail0.el7.noarch.rpm",
    "#{@ws}/thirdparty/redis-py-0.1-2contrail.el7.noarch.rpm",
    "#{@ws}/thirdparty/ifmap-server-0.3.2-2contrail.el7.noarch.rpm",
    "#{@ws}/thirdparty/hc-httpcore-4.1-1.jpp6.noarch.rpm",
    "#{@ws}/thirdparty/zookeeper-3.4.3-1.el6.noarch.rpm",
    "#{@ws}/thirdparty/bigtop-utils-0.6.0+243-1.cdh4.7.0.p0.17.el6.noarch.rpm",
    "#{@ws}/thirdparty/python-keystone-2014.1.3-2.el7ost.noarch.rpm",
    "#{@ws}/thirdparty/python-psutil-1.2.1-1.el7.x86_64.rpm",
    "#{@ws}/thirdparty/java-1.7.0-openjdk-1.7.0.55-2.4.7.2.el7_0.x86_64.rpm",
    "#{@ws}/thirdparty/java-1.7.0-openjdk-headless-1.7.0.55-2.4.7.2.el7_0.x86_64.rpm",
    "#{@ws}/thirdparty/log4j-1.2.17-15.el7.noarch.rpm",

    "supervisor",
    "supervisord",
    "python-supervisor",
    "rabbitmq-server",
    "python-kazoo",
    "python-ncclient",
]

@controller_contrail_packages = [
    "#{@ws}/build/packages/python-contrail_#{@pkg_tag}_all.deb",
    "#{@ws}/build/packages/contrail-config_#{@pkg_tag}_all.deb",
    "#{@ws}/build/packages/contrail-lib_#{@pkg_tag}_amd64.deb",
    "#{@ws}/build/packages/contrail-control_#{@pkg_tag}_amd64.deb",
    "#{@ws}/build/packages/contrail-analytics_#{@pkg_tag}_amd64.deb",
    "#{@ws}/build/debian/contrail-web-controller_#{@pkg_tag}_amd64.deb",
    "#{@ws}/build/debian/contrail-web-core_#{@pkg_tag}_amd64.deb",
    "#{@ws}/build/debian/contrail-setup_#{@pkg_tag}_all.deb",
    "#{@ws}/build/debian/contrail-nodemgr_#{@pkg_tag}_all.deb",
    "#{@ws}/build/packages/contrail-utils_#{@pkg_tag}_amd64.deb",
    "#{@ws}/build/packages/contrail-dns_#{@pkg_tag}_amd64.deb",
    "#{@ws}/build/debian/contrail-openstack-control_#{@pkg_tag}_all.deb",
    "#{@ws}/build/debian/contrail-openstack-database_#{@pkg_tag}_all.deb",
    "#{@ws}/build/debian/contrail-openstack-webui_#{@pkg_tag}_all.deb",
]

@compute_thirdparty_packages = [
    @common_packages,
    "#{@ws}/thirdparty/consistent_hash-1.0-0contrail0.el7.noarch.rpm",
    "#{@ws}/thirdparty/python-pycassa-1.10.0-0contrail.el7.noarch.rpm ",
]

@compute_contrail_packages = [
    "#{@ws}/build/packages/python-contrail_#{@pkg_tag}_all.deb",
    "#{@ws}/build/packages/python-contrail-vrouter-api_#{@pkg_tag}_all.deb",
    "#{@ws}/build/packages/python-vrouter-utils_#{@pkg_tag}_amd64.deb",
    "#{@ws}/build/debian/contrail-vrouter-init_#{@pkg_tag}_all.deb",
    "#{@ws}/build/packages/contrail-lib_#{@pkg_tag}_amd64.deb",
    "#{@ws}/build/packages/contrail-vrouter-3.13.0-34-generic_#{@pkg_tag}_all.deb",
    "#{@ws}/build/packages/contrail-vrouter-agent_#{@pkg_tag}_amd64.deb",
    "#{@ws}/build/debian/contrail-setup_#{@pkg_tag}_all.deb",
    "#{@ws}/build/debian/contrail-vrouter-common_#{@pkg_tag}_all.deb",
    "#{@ws}/build/packages/contrail-utils_#{@pkg_tag}_amd64.deb",
    "#{@ws}/build/debian/contrail-nodemgr_#{@pkg_tag}_all.deb",
]

# Download and extract contrail and thirdparty rpms
def download_contrail_software
    sh("wget -qO - https://github.com/rombie/opencontrail-packages/blob/master/ubuntu1404/contrail_rpms.tar.xz?raw=true | tar Jx")
    sh("wget -qO - https://github.com/rombie/opencontrail-packages/blob/master/ubuntu1404/thirdparty.tar.xz?raw=true | tar Jx")
end
