# == Class: sipp
#
# Full description of class sipp here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { sipp:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2011 Your name here, unless otherwise noted.
#
class sipp(
  $repo_path         = "git://github.com/SIPp/sipp.git",
  $install_base_path = "/usr/local",
  $sipp_version      = "3.4-beta2"
) {

  # require git

  $install_path = "${install_base_path}/sipp-src"

  [ "libpcap-dev", "libsctp-dev", "autoconf-archive", "git-core", "libncurses5-dev", "make", "g++" ].each |$p| {
    package { $p:
      ensure => "installed"
    }
  }
  
  exec { "sipp fetch":
    command => "git clone ${repo_path} ${install_path}",
    path => ["/usr/bin", "/bin"],
    creates => "${install_path}",
    notify => Exec["sipp checkout"]
  }

  exec { "sipp checkout":
    cwd => "${install_path}",
    command => "/usr/bin/git checkout ${sipp_version}",
    require => Exec["sipp fetch"],
    refreshonly => true
  }

  exec { "sipp install":
    cwd => "${install_path}",
    command => "autoreconf -ivf && ./configure --with-pcap --with-sctp && make",
    path => ["/usr/bin", "/bin"],
    require => [Package["libpcap-dev"], Package["libsctp-dev"], Package["autoconf-archive"], Package["git-core"], Package["libncurses5-dev"], Package["make"], Package["g++"], Exec["sipp checkout"]],
    creates => "${install_path}/sipp"
  }
}
