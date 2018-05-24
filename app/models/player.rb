class Player < ApplicationRecord
  default_scope { order(:last_name, :first_name) }

  validates :first_name, presence: :true
  validates :last_name, presence: :true

  belongs_to :team

  def name
    [first_name, last_name].join(' ')
  end

  def birthday
    if !birth_date.nil?
      Date.parse(birth_date).strftime("%B %d, %Y")
    else
      "N/A"
    end
  end

  def full_position
    position_names = {k: "Kicker", qb: "Quarterback", rb: "Running Back", wr: "Wide Receiver", te: "Tight End", ot: "Offensive Tackle", cb: "Corner Back", de: "Defensive End", fs: "Free Safety", g: "Guard", olb: "Outside Linebacker", ss: "Strong Safety", ilb: "Inside Linebacker", dt:  "Defensive Tackle", c: "Center", p: "Punter", fb: "Full Back", nt: "Nose Tackle", s: "Safety", lb: "Linebacker", ls: "Long Snapper", db: "Defensive Back", dl: "Defensive Line", ol: "Offensive Line"}
    position_names[position.downcase.to_sym]
  end

  def self.positions
    positions = []
    players = Player.all
    players.each do |player|
      if !positions.include?(player.position)
        positions << player.position
      end
    end
    positions.sort
  end

  def self.draft_info
    teams = []
    rounds = []
    years = []
    udfa = {}
    supp = {}
    players = Player.all
    players.each do |player|
      if !player.college_draft_round.nil? && !rounds.include?(player.college_draft_round)
        rounds << player.college_draft_round
      end
      if !player.college_draft_year.nil? && !years.include?(player.college_draft_year)
        years << player.college_draft_year
      end
      if !player.college_draft_team.nil?
        if player.college_draft_team.length <= 3 && !teams.include?(player.college_draft_team)
          teams << player.college_draft_team
        elsif player.college_draft_team[-1] == "A" && !udfa.has_key?(player.college_draft_team)
          udfa["#{player.college_draft_team}"] = player.college_draft_team[0...-3]
        elsif !supp.has_key?(player.college_draft_team)
          supp["#{player.college_draft_team}"] = player.college_draft_team[0...-5]
        end
      end
    end
    results = {teams: teams.sort, rounds: rounds.sort, years: years.sort, udfa: udfa.sort, supp: supp.sort}
  end

  def self.search_by_full_name(search)
    results = []
    names = search.split(" ")
    i=0
    while i < names.length
      new_results = Player.where("last_name ILIKE ?", "%#{names[i]}%").or(Player.where("first_name ILIKE ?", "%#{names[i]}%"))
      new_results.each do |result|
        if !results.include?(result)
          results << result
        end
      end
      i += 1
    end
    if results.length > 66
      results.first(66)
    else
      results
    end
  end

end
