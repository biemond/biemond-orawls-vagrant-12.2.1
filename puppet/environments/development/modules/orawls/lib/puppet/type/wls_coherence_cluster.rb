require File.dirname(__FILE__) + '/../../orawls_core'


module Puppet
  #
  Type.newtype(:wls_coherence_cluster) do
    include EasyType
    include Utils::WlsAccess
    extend Utils::TitleParser

    desc 'This resource allows you to manage a cluster in an WebLogic domain.'

    ensurable

    set_command(:wlst)

    to_get_raw_resources do
      Puppet.debug "index #{name}"
      environment = { 'action' => 'index', 'type' => 'wls_coherence_cluster' }
      wlst template('puppet:///modules/orawls/providers/wls_coherence_cluster/index.py.erb', binding), environment
    end

    on_create  do | command_builder |
      wlst_action = 'create'
      Puppet.info "create #{name} "
      template('puppet:///modules/orawls/providers/wls_coherence_cluster/create_modify.py.erb', binding)
    end

    on_modify  do | command_builder |
      wlst_action = 'modify'
      Puppet.info "modify #{name} "
      template('puppet:///modules/orawls/providers/wls_coherence_cluster/create_modify.py.erb', binding)
    end

    on_destroy  do | command_builder |
      Puppet.info "destroy #{name} "
      template('puppet:///modules/orawls/providers/wls_coherence_cluster/destroy.py.erb', binding)
    end

    parameter :domain
    parameter :name
    parameter :timeout
    parameter :coherence_cluster_name
    parameter :storage_enabled
    property :clusteringmode
    property :unicastport
    property :multicastaddress
    property :multicastport
    property :target
    property :targettype

    add_title_attributes(:coherence_cluster_name) do
      /^((.*\/)?(.*)?)$/
    end

  end
end
