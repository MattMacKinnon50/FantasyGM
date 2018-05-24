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
    draft_rounds = []
    supp = []
    years = []
    players = Player.all
    players.each do |player|
      team = player.college_draft_team
      if !team.nil? && team.include?(" ")
        team = team.split(" ").first
      end
      if !player.college_draft_round.nil?
        if player.college_draft_round.length == 1 && !draft_rounds.include?(player.college_draft_round)
          draft_rounds << player.college_draft_round
        elsif player.college_draft_round.length == 2 && !supp.include?(player.college_draft_round)
          supp << player.college_draft_round
        end
      end
      if !player.college_draft_year.nil? && !years.include?(player.college_draft_year)
        years << player.college_draft_year
      end
      if !team.nil? && !teams.include?(team)
        teams << team
      end
    end
    rounds = draft_rounds.sort.concat(supp.sort)
    results = {teams: teams.sort, rounds: rounds, years: years.sort}
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
