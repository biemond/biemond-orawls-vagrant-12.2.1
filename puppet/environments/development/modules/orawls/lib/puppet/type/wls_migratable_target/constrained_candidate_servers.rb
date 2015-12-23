newproperty(:constrained_candidate_servers, :array_matching => :all) do
  include EasyType

  desc 'The list of servers this migratable target should be constrained to'

  # defaultto []

  to_translate_to_resource do | raw_resource|
    unless raw_resource['constrained_candidate_servers'].nil?
      raw_resource['constrained_candidate_servers'].split(',')
    end
  end

  def insync?(is)
    is = [] if is == :absent or is.nil?
    is == @should
  end
end
