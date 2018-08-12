class Contract < ApplicationRecord
belongs_to :team
belongs_to :player

validates :length, numericality: true
validates :start_year, numericality: true
validates :total, presence: true
validates :aav, presence: true
validates :guaranteed, presence: true

  def year_index(year)
    year_index = (year - start_year)
  end

  def details_by_year
    contract_breakdown = []
    guaranteed = self.guaranteed
    total = self.total
    base = total - guaranteed
    if length == 1
      contract_breakdown << {year: start_year, base: base, guaranteed: guaranteed, cap: total, dead: total, trade: guaranteed}
      contract_breakdown << nil
      contract_breakdown << nil
      contract_breakdown << nil
      contract_breakdown << nil
    elsif length == 2
      contract_breakdown << {year: start_year, base: base * (2.0/5), guaranteed: (guaranteed / 2), cap: (base * (2.0/5) + (guaranteed / 2)), dead: (base * 2.0/5) + guaranteed, trade: guaranteed}
      contract_breakdown << {year: (start_year + 1), base: base * (3.0/5), guaranteed: (guaranteed / 2), cap: (base * (3.0/5) + (guaranteed / 2)), dead: (base * 3.0/5) + (guaranteed / 2), trade: guaranteed / 2}
      contract_breakdown << nil
      contract_breakdown << nil
      contract_breakdown << nil
    elsif length == 3
      contract_breakdown << {year: start_year, base: base * (2.0/10), guaranteed: (guaranteed / 3), cap: (base * (2.0/10) + (guaranteed / 3)), dead: (base * 2.0/10) + guaranteed, trade: guaranteed}
      contract_breakdown << {year: (start_year + 1), base: base * (3.0/10), guaranteed: (guaranteed / 3), cap: (base * (3.0/10) + (guaranteed / 3)), dead: (base * 3.0/10) + (guaranteed * (2.0/3)), trade: (guaranteed * (2.0/3))}
      contract_breakdown << {year: (start_year + 2), base: base * (5.0/10), guaranteed: (guaranteed / 3), cap: (base * (5.0/10) + (guaranteed / 3)), dead: (base * 5.0/10) + (guaranteed / 3), trade: guaranteed / 3}
      contract_breakdown << nil
      contract_breakdown << nil
    elsif length == 4
      contract_breakdown << {year: start_year, base: base * (1.0/16), guaranteed: (guaranteed / 4), cap: (base * (1.0/16) + (guaranteed / 4)), dead: (base * 1.0/16) + guaranteed, trade: guaranteed}
      contract_breakdown << {year: (start_year + 1), base: base * (3.0/16), guaranteed: (guaranteed / 4), cap: (base * (3.0/16) + (guaranteed / 4)), dead: (base * 3.0/16) + (guaranteed / 2), trade:(guaranteed / 2)}
      contract_breakdown << {year: (start_year + 2), base: base * (5.0/16), guaranteed: (guaranteed / 4), cap: (base * (5.0/16) + (guaranteed / 4)), dead: (base * 5.0/16) + (guaranteed * (3.0/4)), trade: (guaranteed * (3.0/4))}
      contract_breakdown << {year: (start_year + 3), base: base * (7.0/16), guaranteed: (guaranteed / 4), cap: (base * (7.0/16) + (guaranteed / 4)), dead: (base * 7.0/16) + (guaranteed / 4), trade: guaranteed / 4}
      contract_breakdown << nil
    elsif length == 5
      contract_breakdown << {year: start_year, base: base * (1.0/25), guaranteed: (guaranteed / 5), cap: (base * (1.0/25) + (guaranteed / 5)), dead: (base * 1.0/25) + guaranteed, trade: guaranteed}
      contract_breakdown << {year: (start_year + 1), base: base * (3.0/25), guaranteed: (guaranteed / 5), cap: (base * (3.0/25) + (guaranteed / 5)), dead: (base * 3.0/25) + (guaranteed * (4.0/5)), trade:(guaranteed * (4.0/5))}
      contract_breakdown << {year: (start_year + 2), base: base * (5.0/25), guaranteed: (guaranteed / 5), cap: (base * (5.0/25) + (guaranteed / 5)), dead: (base * 5.0/25) + (guaranteed * (3.0/5)), trade: (guaranteed * (3.0/5))}
      contract_breakdown << {year: (start_year + 3), base: base * (7.0/25), guaranteed: (guaranteed / 5), cap: (base * (7.0/25) + (guaranteed / 5)), dead: (base * 7.0/25) + (guaranteed * (2.0/5)), trade: (guaranteed * (2.0/5))}
      contract_breakdown << {year: (start_year + 4), base: base * (9.0/25), guaranteed: (guaranteed / 5), cap: (base * (9.0/25) + (guaranteed / 5)), dead: (base * 9.0/25) + (guaranteed * (1.0/5)), trade: (guaranteed * (1.0/5))}
    elsif length == 6
      contract_breakdown << {year: start_year, base: base * (1.0/36), guaranteed: (guaranteed / 6), cap: (base * (1.0/36) + (guaranteed / 6)), dead: (base * 1.0/36) + guaranteed, trade: guaranteed}
      contract_breakdown << {year: (start_year + 1), base: base * (3.0/36), guaranteed: (guaranteed / 6), cap: (base * (3.0/36) + (guaranteed / 6)), dead: (base * 3.0/36) + (guaranteed * (5.0/6)), trade:(guaranteed * (5.0/6))}
      contract_breakdown << {year: (start_year + 2), base: base * (5.0/36), guaranteed: (guaranteed / 6), cap: (base * (5.0/36) + (guaranteed / 6)), dead: (base * 5.0/36) + (guaranteed * (4.0/6)), trade: (guaranteed * (4.0/6))}
      contract_breakdown << {year: (start_year + 3), base: base * (7.0/36), guaranteed: (guaranteed / 6), cap: (base * (7.0/36) + (guaranteed / 6)), dead: (base * 7.0/36) + (guaranteed * (3.0/6)), trade: (guaranteed * (3.0/6))}
      contract_breakdown << {year: (start_year + 4), base: base * (9.0/36), guaranteed: (guaranteed / 6), cap: (base * (9.0/36) + (guaranteed / 6)), dead: (base * 9.0/36) + (guaranteed * (2.0/6)), trade: (guaranteed * (2.0/6))}
      contract_breakdown << {year: (start_year + 5), base: base * (11.0/36), guaranteed: (guaranteed / 6), cap: (base * (11.0/36) + (guaranteed / 6)), dead: (base * 11.0/36) + (guaranteed * (1.0/6)), trade: (guaranteed * (1.0/6))}
    elsif length == 7
      contract_breakdown << {year: start_year, base: base * (1.0/49), guaranteed: (guaranteed / 7), cap: (base * (1.0/49) + (guaranteed / 7)), dead: (base * 1.0/49) + guaranteed, trade: guaranteed}
      contract_breakdown << {year: (start_year + 1), base: base * (3.0/49), guaranteed: (guaranteed / 7), cap: (base * (3.0/49) + (guaranteed / 7)), dead: (base * 3.0/49) + (guaranteed * (6.0/7)), trade:(guaranteed * (6.0/7))}
      contract_breakdown << {year: (start_year + 2), base: base * (5.0/49), guaranteed: (guaranteed / 7), cap: (base * (5.0/49) + (guaranteed / 7)), dead: (base * 5.0/49) + (guaranteed * (5.0/7)), trade: (guaranteed * (5.0/7))}
      contract_breakdown << {year: (start_year + 3), base: base * (7.0/49), guaranteed: (guaranteed / 7), cap: (base * (7.0/49) + (guaranteed / 7)), dead: (base * 7.0/49) + (guaranteed * (4.0/7)), trade: (guaranteed * (4.0/7))}
      contract_breakdown << {year: (start_year + 4), base: base * (9.0/49), guaranteed: (guaranteed / 7), cap: (base * (9.0/49) + (guaranteed / 7)), dead: (base * 9.0/49) + (guaranteed * (3.0/7)), trade: (guaranteed * (3.0/7))}
      contract_breakdown << {year: (start_year + 5), base: base * (11.0/49), guaranteed: (guaranteed / 7), cap: (base * (11.0/49) + (guaranteed / 7)), dead: (base * 11.0/49) + (guaranteed * (2.0/7)), trade: (guaranteed * (2.0/7))}
      contract_breakdown << {year: (start_year + 6), base: base * (13.0/49), guaranteed: (guaranteed / 7), cap: (base * (13.0/49) + (guaranteed / 7)), dead: (base * 13.0/49) + (guaranteed * (1.0/7)), trade: (guaranteed * (1.0/7))}
    elsif length == 8
      contract_breakdown << {year: start_year, base: base * (1.0/64), guaranteed: (guaranteed / 8), cap: (base * (1.0/49) + (guaranteed / 8)), dead: (base * 1.0/49) + guaranteed, trade: guaranteed}
      contract_breakdown << {year: (start_year + 1), base: base * (3.0/64), guaranteed: (guaranteed / 8), cap: (base * (3.0/64) + (guaranteed / 8)), dead: (base * 3.0/64) + (guaranteed * (7.0/8)), trade:(guaranteed * (7.0/8))}
      contract_breakdown << {year: (start_year + 2), base: base * (5.0/64), guaranteed: (guaranteed / 8), cap: (base * (5.0/64) + (guaranteed / 8)), dead: (base * 5.0/64) + (guaranteed * (6.0/8)), trade:(guaranteed * (6.0/8))}
      contract_breakdown << {year: (start_year + 3), base: base * (7.0/64), guaranteed: (guaranteed / 8), cap: (base * (7.0/64) + (guaranteed / 8)), dead: (base * 7.0/64) + (guaranteed * (5.0/8)), trade: (guaranteed * (5.0/8))}
      contract_breakdown << {year: (start_year + 4), base: base * (9.0/64), guaranteed: (guaranteed / 8), cap: (base * (9.0/64) + (guaranteed / 8)), dead: (base * 9.0/64) + (guaranteed * (4.0/8)), trade: (guaranteed * (4.0/8))}
      contract_breakdown << {year: (start_year + 5), base: base * (11.0/64), guaranteed: (guaranteed / 8), cap: (base * (11.0/64) + (guaranteed / 8)), dead: (base * 11.0/64) + (guaranteed * (3.0/8)), trade: (guaranteed * (3.0/8))}
      contract_breakdown << {year: (start_year + 6), base: base * (13.0/64), guaranteed: (guaranteed / 8), cap: (base * (13.0/64) + (guaranteed / 8)), dead: (base * 13.0/64) + (guaranteed * (2.0/8)), trade: (guaranteed * (2.0/8))}
      contract_breakdown << {year: (start_year + 7), base: base * (15.0/64), guaranteed: (guaranteed / 8), cap: (base * (15.0/64) + (guaranteed / 8)), dead: (base * 15.0/49) + (guaranteed * (1.0/8)), trade: (guaranteed * (1.0/8))}
    end
  end

end
