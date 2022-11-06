class TeamRound < ActiveRecord::Base
  belongs_to :round
  belongs_to :team
  # has_attached_file :report
  has_one_attached :round_report
  has_many :decisions

  has_many :team_round_input_screens
  has_many :graph_datum



  # validates_attachment_content_type :report, :content_type => ['application/pdf', 'application/msword', 'text/plain'], :if => :pdf_attached?
  #
  # validates_attachment_content_type :debrief, :content_type => ['application/vnd.openxmlformats-officedocument.presentationml.presentation' ,'application/pdf', 'application/msword', 'text/plain'], :if => :debrief_attached?
  #
  # def pdf_attached?
  #   self.report.file?
	# end
  #
	# def debrief_attached?
	# 	self.debrief.file?
	# end
  class << self
    def initialize(team,round,simulation)
      team_round = TeamRound.new
      team_round.team = team
      team_round.round = round
      team_round.is_finished = false
      team_round.save!
      Decision.build_decisions(simulation, team_round)
      round.input_screens.each do |is|
        team_round_input_screen = TeamRoundInputScreen.new
        team_round_input_screen.was_visited = false
        team_round_input_screen.data_entered = false
        team_round_input_screen.input_screen = is
        team_round_input_screen.team_round = team_round
        team_round_input_screen.save!
      end
    end

    def copy_decision_values(from,to)
      to.decisions.each do |to_decision|
        from_decision = from.decisions.where(:field_name => to_decision.field_name).first
        puts "I am copying a Value for " + to_decision.field_name + "it is " + from_decision.field_value
        to_decision.field_value = from_decision.field_value
        to_decision.value = from_decision.value
        to_decision.original_value = from_decision.field_value
        to_decision.save!
      end
    end
  end

  def get_next_team_round

    self.team.team_rounds.joins(:round).where(:rounds => {:round_number => (self.round.round_number+1)}).first
  end

  def next_round_is_enabled
    next_round = self.get_next_team_round
    if next_round.nil?
    #   OK Need the sim to see if it's enabled
      self.round.simulation.final_reports_enabled
    else
      next_round.round.is_enabled
    end
  end

  def get_progress_string
    total = self.round.input_screens.size
    completed = 0
    self.round.input_screens.each do |is|
      if is.has_decisions(self) then
        completed = completed + 1
      end
    end
    percent = (completed.to_f / total.to_f) * 100.0;
    return "width:" + percent.to_i.to_s + "%"
	end

	def all_screens_have_decisions
		self.round.input_screens.each do |is|
			if !is.has_decisions(self) then
				return false
			end
		end
		return true
	end




end