class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :team_id, :nfl_team, :number, :first_name, :last_name, :name, :position, :bye_week, :role, :primary_color, :secondary_color

  def name
    [object.first_name, object.last_name].join(' ')
  end

  def primary_color
    "background_color:#" + object.team.primary_color
  end

  def secondary_color
    "background_color:#" + object.team.secondary_color
  end
end
