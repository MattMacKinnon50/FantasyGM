class Contract < ApplicationRecord
belongs_to :team
belongs_to :player

validates :length, numericality: true
validates :start_year, numericality: true
validates :total, presence: true
validates :aav, presence: true
validates :guaranteed, presence: true

  def guaranteed_int
    result = guaranteed.gsub(/[$,]/, '').to_f
    result.modulo(1) == 0 ? result.to_i : sprintf("%.2f", result)
  end

  def aav_int
    result = aav.gsub(/[$,]/, '').to_f
    result.modulo(1) == 0 ? result.to_i : sprintf("%.2f", result)
  end

  def total_int
    result = total.gsub(/[$,]/, '').to_f
    result.modulo(1) == 0 ? result.to_i : sprintf("%.2f", result)
  end

  def current_year
    league = League.first
    current_year = (league.league_year - start_year) + 1
    current_year.to_s
  end

  def contract_by_year
    contract_breakdown = {}
    if length == 1
      contract_breakdown("1") = {year: start_year, }


end
