require 'voxpupuli/acceptance/spec_helper_acceptance'

configure_beaker do |host|
  # sysctl is untestable in docker
  unless host['hypervisor'] == 'docker'
    install_module_from_forge_on(host, 'herculesteam/augeasproviders_sysctl', '>= 2.1.0 < 3.0.0')
  end

  if fact_on(host, 'osfamily') == 'RedHat' && fact_on(host, 'operatingsystemmajrelease').to_i == 7
    install_module_from_forge_on(host, 'puppet/epel', '>= 3.0.0')
  end
  unless fact_on(host, 'osfamily') == 'RedHat' && fact_on(host, 'operatingsystemmajrelease').to_i >= 9
    # puppet-bolt rpm for CentOS 9 is not yet available
    # https://tickets.puppetlabs.com/browse/MODULES-11275
    host.install_package('puppet-bolt')
  end
end
