class League < ApplicationRecord
  validates :display_name, length: { maximum: 12 }
end
