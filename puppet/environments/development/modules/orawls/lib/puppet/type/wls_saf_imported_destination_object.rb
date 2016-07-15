require File.dirname(__FILE__) + '/../../orawls_core'


module Puppet
  #
  Type.newtype(:wls_saf_imported_destination_object) do
    include EasyType
    include Utils::WlsAccess
    extend Utils::TitleParser

    desc 'This resource allows you to manage a SAF imported destinations object in a JMS Module of an WebLogic domain.'

    ensurable

    set_command(:wlst)

    to_get_raw_resources do
      Puppet.debug "index #{name}"
      environment = { 'action' => 'index', 'type' => 'wls_saf_imported_destination_object' }
      wlst template('puppet:///modules/orawls/providers/wls_saf_imported_destination_object/index.py.erb', binding), environment
    end

    on_create do | command_builder |
      wlst_action = 'create'
      Puppet.info "create #{name} "
      template('puppet:///modules/orawls/providers/wls_saf_imported_destination_object/create_modify.py.erb', binding)
    end

    on_modify do | command_builder |
      wlst_action = 'modify'
      Puppet.info "modify #{name} "
      template('puppet:///modules/orawls/providers/wls_saf_imported_destination_object/create_modify.py.erb', binding)
    end

    on_destroy do | command_builder |
      Puppet.info "destroy #{name} "
      template('puppet:///modules/orawls/providers/wls_saf_imported_destination_object/destroy.py.erb', binding)
    end

    parameter :domain
    parameter :name
    parameter :jmsmodule
    parameter :imported_destination
    parameter :object_name
    parameter :timeout
    property :object_type
    property :timetolivedefault
    property :usetimetolivedefault
    property :unitoforderrouting
    property :remotejndiname
    property :localjndiname
    property :nonpersistentqos

    add_title_attributes(:jmsmodule, :imported_destination, :object_name) do
      /^((.*\/)?(.*):(.*):(.*)?)$/
    end

  end
end
