class ContractSerializer < ActiveModel::Serializer
  attributes :id, :player_id, :team_id, :length, :start_year, :total, :aav, :guaranteed, :aav_int

end
