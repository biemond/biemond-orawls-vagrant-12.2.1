require File.dirname(__FILE__) + '/../../orawls_core'


module Puppet
  Type.newtype(:wls_jms_queue) do
    include EasyType
    include Utils::WlsAccess
    extend Utils::TitleParser

    desc 'This resource allows you to manage a Queue in a JMS Module of an WebLogic domain.'

    ensurable

    set_command(:wlst)

    to_get_raw_resources do
      Puppet.info "index #{name}"
      environment = { 'action' => 'index', 'type' => 'wls_jms_queue' }
      wlst template('puppet:///modules/orawls/providers/wls_jms_queue/index.py.erb', binding), environment
    end

    on_create  do | command_builder |
      wlst_action = 'create'
      Puppet.info "create #{name} "
      template('puppet:///modules/orawls/providers/wls_jms_queue/create.py.erb', binding)
    end

    on_modify  do | command_builder |
      wlst_action = 'modify'
      Puppet.info "modify #{name} "
      template('puppet:///modules/orawls/providers/wls_jms_queue/modify.py.erb', binding)
    end

    on_destroy  do | command_builder |
      Puppet.info "destroy #{name} "
      template('puppet:///modules/orawls/providers/wls_jms_queue/destroy.py.erb', binding)
    end

    parameter :domain
    parameter :name
    parameter :jmsmodule
    parameter :queue_name
    parameter :timeout
    property :distributed
    property :jndiname
    property :subdeployment
    property :balancingpolicy
    property :quota
    property :defaulttargeting
    property :errordestination
    property :expirationloggingpolicy
    property :redeliverylimit
    property :expirationpolicy
    property :redeliverydelay
    property :timetodeliver
    property :deliverymode
    property :timetolive
    property :forwarddelay
    property :templatename
    property :messagelogging
    property :destination_keys
    property :insertionpaused
    property :consumptionpaused
    property :productionpaused

    add_title_attributes(:jmsmodule, :queue_name) do
      /^((.*\/)?(.*):(.*)?)$/
    end

    autorequire(:wls_jms_template) { "#{jmsmodule}:#{templatename}" }
  end
end
