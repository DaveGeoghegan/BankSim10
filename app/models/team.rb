class Team < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable :recoverable,:validatable ,
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable

  has_many :team_rounds
  has_many :rounds, :through => :team_rounds

  accepts_nested_attributes_for :team_rounds

  belongs_to :simulation
  validates_uniqueness_of :name

  after_create :initialize_team

  def initialize_team
    # Set up rounds etc.
    self.simulation.rounds.each do |round|
      TeamRound.initialize(self, round, self.simulation)
    end
  end

  def get_active_team_round
    active_round = self.simulation.get_current_round
    self.team_rounds.each do |team_round|
      if team_round.round == active_round then
        return team_round
      end
    end
    return nil
  end


  #
  # def self.authenticate(name, password)
  #   team = find_by_name(name)
  #   if team && team.password == password then
  #     team
  #   else
  #     nil
  #   end
  # end
  #
  # def get_current_team_round
  # 	self.team_rounds.each_with_index do |round, idx|
  # 		if !round.is_finished
  # 			return round
  # 		end
  # 	end
  # 	return self.team_rounds.last
  # end

end
