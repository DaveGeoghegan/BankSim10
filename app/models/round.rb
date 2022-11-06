class Round < ActiveRecord::Base

  belongs_to :simulation

  has_many :round_input_screens
  has_many :input_screens , :through => :round_input_screens

  has_many :team_rounds
  has_many :teams , :through => :team_rounds
  has_one_attached :economic_data
  has_one_attached :debrief

  # has_attached_file :economic_data
  # has_attached_file :debrief
  #
  # validates_attachment_content_type :economic_data, :content_type => ['application/pdf', 'application/msword', 'text/plain'], :if => :pdf_attached?
  #
  # validates_attachment_content_type :debrief, :content_type => ['application/vnd.openxmlformats-officedocument.presentationml.presentation' , 'application/pdf', 'application/msword', 'text/plain'], :if => :debrief_attached?
  #
  # def pdf_attached?
  #   self.economic_data.file?
  # end
  #
  # def debrief_attached?
  #   self.debrief.file?
  # end

  def get_next_input_screen(is)
    current_index = is.input_screen_number
    next_screen = InputScreen.where(:input_screen_number => (current_index +1)).first
    return next_screen
  end

  def get_prev_input_screen(is)
    current_index = is.input_screen_number
    next_screen = InputScreen.where(:input_screen_number => (current_index -1)).first
    return next_screen
  end

  def  previous_round
    simulation = self.simulation
    previous_round = simulation.rounds.where(:round_number => (self.round_number-1)).first
    return previous_round
  end
end
