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
  #$install_dir       = "/usr/local",
  #$sipp_version      = "3.4-beta2",
) {

  # require git

  exec { "sipp fetch":
    command => "git clone ${repo_path} /tmp/sipp-src",
    path => ["/usr/bin", "/bin"]
  }

  #exec { "sipp checkout":
  #  cwd => "/tmp/sipp-src",
  #  command => "/usr/bin/git checkout ${sipp_version}",
  #  require => Exec["sipp fetch"]
  #}

  #exec { "sipp install":
  #  cwd => "/tmp/sipp-src",
  #  command => "autoreconf -ivf && ./configure --with-pcap --with-sctp && make",
  #  require => Exec["sipp checkout"]
  #}
}
