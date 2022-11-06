class Simulation < ActiveRecord::Base
  has_many :rounds
  accepts_nested_attributes_for :rounds, allow_destroy: true
  has_many :teams
  has_many :input_items

  has_one_attached :opening_report
  has_one_attached :economic_data
  has_one_attached :debrief


  after_create :initialize_simulation

  class << self
    def get_current_simulation
      Simulation.first
    end
  end

  def initialize_simulation
    InputItem.build_input_items(self)
    for i in 1..self.number_of_rounds do
      round = Round.create({
                               name: 'Round ' + i.to_s,
                               round_number: i,
                               simulation: self,
                               is_enabled: i == 1 ? true : false,
                               is_active: i == 1 ? true : false,
                               is_closed: false
                           })
      InputScreen.all.each do |is|
        round.input_screens << is
      end
    end
  end

  def get_current_round
    self.rounds.each do |round|
      if round.is_enabled then
        return round
      end
    end
    return nil
  end

end
