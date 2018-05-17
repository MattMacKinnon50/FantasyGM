class Player < ApplicationRecord
  default_scope { order(:last_name, :first_name) }

  validates :first_name, presence: :true
  validates :last_name, presence: :true

  belongs_to :team

  def name
    [first_name, last_name].join(' ')
  end

  def birthday
    Date.parse(birth_date).strftime("%B %d, %Y")
  end

  def full_position
    position_names = {k: "Kicker", qb: "Quarterback", rb: "Running Back", wr: "Wide Receiver", te: "Tight End", ot: "Offensive Tackle", cb: "Corner Back", de: "Defensive End", fs: "Free Safety", g: "Guard", olb: "Outside Linebacker", ss: "Strong Safety", ilb: "Inside Linebacker", dt:  "Defensive Tackle", c: "Center", p: "Punter", fb: "Full Back", nt: "Nose Tackle", s: "Safety", lb: "Linebacker", ls: "Long Snapper", db: "Defensive Back", dl: "Defensive Line", ol: "Offensive Line"}
    position_names[position.downcase.to_sym]
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
    results
  end

end
