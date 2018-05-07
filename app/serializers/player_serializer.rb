class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :team_id, :nfl_team, :number, :first_name, :last_name, :name, :position, :bye_week

  def name
    [object.first_name, object.last_name].join(' ')
  end
end
