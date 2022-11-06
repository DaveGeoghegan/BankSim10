class Decision < ActiveRecord::Base

  belongs_to :input_item
  belongs_to :team_round

  class << self
    def build_decisions(simulation, team_round)
      simulation.input_items.each do |input_item|
        theDecision = Decision.new
        theDecision.team_round =  team_round
        theDecision.field_name = input_item.identifier
        theDecision.field_value = input_item.default_value
        theDecision.original_value = input_item.default_value
        theDecision.value = input_item.default_value
        theDecision.is_modified = false
        theDecision.input_item = input_item
        theDecision.save!
      end
    end
  end


end
