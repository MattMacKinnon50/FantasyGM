class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :team_id, :nfl_team, :number, :first_name, :last_name, :name, :position, :bye_week, :role, :primary_color, :secondary_color, :ps_eligibility, :contract, :current_salary

  def name
    [object.first_name, object.last_name].join(' ')
  end

  def primary_color
    "background_color:" + object.team.primary_color
  end

  def secondary_color
    "background_color:" + object.team.secondary_color
  end

  def contract
    object.contracts[0]
  end

  def current_salary
    league = League.first
    year = league.league_year
    contract = object.contracts[0]
    current_year = contract.details_by_year[contract.year_index(year)]
  end
end
