#!/usr/bin/env ruby

@install_pkg = "yum -y install"
@uninstall_pkg = "yum -y remove"

@branch = "3.0" # master
@tag = "4100"
@pkg_tag = "#{@branch}-#{@tag}"

@common_packages = [
    "sshpass",
    "createrepo",
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
    "#{@ws}/thirdparty/xmltodict-0.7.0-0contrail.el7.noarch.rpm",
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
    "#{@ws}/contrail/controller/build/package-build/RPMS/noarch/contrail-database-#{@pkg_tag}.fc21.noarch.rpm",
    "#{@ws}/contrail/controller/build/package-build/RPMS/x86_64/python-contrail-#{@pkg_tag}.fc21.x86_64.rpm",
    "#{@ws}/contrail/controller/build/package-build/RPMS/noarch/contrail-config-#{@pkg_tag}.fc21.noarch.rpm",
    "#{@ws}/contrail/controller/build/package-build/RPMS/x86_64/contrail-lib-#{@pkg_tag}0.fc21.x86_64.rpm",
    "#{@ws}/contrail/controller/build/package-build/RPMS/x86_64/contrail-control-#{@pkg_tag}.fc21.x86_64.rpm",
    "#{@ws}/contrail/controller/build/package-build/RPMS/x86_64/contrail-analytics-#{@pkg_tag}.fc21.x86_64.rpm",
    "#{@ws}/contrail/controller/build/package-build/RPMS/x86_64/contrail-web-controller-#{@pkg_tag}.x86_64.rpm",
    "#{@ws}/contrail/controller/build/package-build/RPMS/x86_64/contrail-web-core-#{@pkg_tag}.x86_64.rpm",
    "#{@ws}/contrail/controller/build/package-build/RPMS/noarch/contrail-setup-#{@pkg_tag}.fc21.noarch.rpm",
    "#{@ws}/controller/build/package-build/RPMS/x86_64/contrail-nodemgr-#{@pkg_tag}4100.fc21.x86_64.rpm",
    "#{@ws}/controller/build/package-build/RPMS/x86_64/contrail-utils-#{@pkg_tag}.fc21.x86_64.rpm",
    "#{@ws}/controller/build/package-build/RPMS/x86_64/contrail-dns-#{@pkg_tag}.fc21.x86_64.rpm",
    "#{@ws}/controller/build/package-build/RPMS/noarch/contrail-openstack-control-#{@pkg_tag}.fc21.noarch.rpm",
    "#{@ws}/controller/build/package-build/RPMS/noarch/contrail-openstack-database-#{@pkg_tag}.fc21.noarch.rpm",
    "#{@ws}/controller/build/package-build/RPMS/noarch/contrail-openstack-webui-#{@pkg_tag}.fc21.noarch.rpm",
]

@compute_thirdparty_packages = [
    @common_packages,
    "#{@ws}/thirdparty/xmltodict-0.7.0-0contrail.el7.noarch.rpm",
    "#{@ws}/thirdparty/consistent_hash-1.0-0contrail0.el7.noarch.rpm",
    "#{@ws}/thirdparty/python-pycassa-1.10.0-0contrail.el7.noarch.rpm ",
]

@compute_contrail_packages = [
        "#{@ws}/contrail/controller/build/package-build/RPMS/x86_64/python-contrail-#{@pkg_tag}.fc21.x86_64.rpm",
        "#{@ws}/contrail/controller/build/package-build/RPMS/x86_64/python-contrail-vrouter-api-#{@pkg_tag}.fc21.x86_64.rpm",
        "#{@ws}/contrail/controller/build/package-build/RPMS/x86_64/contrail-vrouter-utils-#{@pkg_tag}.fc21.x86_64.rpm",
        "#{@ws}/contrail/controller/build/package-build/RPMS/x86_64/contrail-vrouter-init-#{@pkg_tag}.fc21.x86_64.rpm",
        "#{@ws}/contrail/controller/build/package-build/RPMS/x86_64/contrail-lib-#{@pkg_tag}.fc21.x86_64.rpm",
        "#{@ws}/contrail/controller/build/package-build/RPMS/x86_64/contrail-vrouter-#{@pkg_tag}.fc21.x86_64.rpm",
        "#{@ws}/contrail/controller/build/package-build/RPMS/x86_64/contrail-vrouter-agent-#{@pkg_tag}.fc21.x86_64.rpm",
        "#{@ws}/contrail/controller/build/package-build/RPMS/noarch/contrail-setup-#{@pkg_tag}.fc21.noarch.rpm",
        "#{@ws}/contrail/controller/build/package-build/RPMS/noarch/contrail-vrouter-common-#{@pkg_tag}.fc21.noarch.rpm",
        "#{@ws}/contrail/controller/build/package-build/RPMS/x86_64/contrail-vrouter-init-#{@pkg_tag}.fc21.x86_64.rpm",
        "#{@ws}/contrail/controller/build/package-build/RPMS/x86_64/contrail-utils-#{@pkg_tag}.fc21.x86_64.rpm",
        "#{@ws}/contrail/controller/build/package-build/RPMS/x86_64/contrail-nodemgr-#{@pkg_tag}.fc21.x86_64.rpm",
        "#{@ws}/contrail/controller/build/package-build/RPMS/noarch/contrail-vrouter-common-#{@pkg_tag}.fc21.noarch.rpm",
]

# Download and extract contrail and thirdparty rpms
def download_contrail_software
    sh("wget -qO - https://github.com/rombie/opencontrail-packages/blob/master/fedora21/contrail-rpms.tar.xz?raw=true | tar Jx")
    sh("wget -qO - https://github.com/rombie/opencontrail-packages/blob/master/fedora21/thirdparty.tar.xz?raw=true | tar Jx")
end
