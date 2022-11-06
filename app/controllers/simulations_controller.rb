class SimulationsController < ApplicationController
  before_action :ensure_user_is_admin

  before_action :set_simulation, only: [:show, :edit, :update, :destroy , :edit_intro_text , :enable_final_reports]

  # GET /simulations
  # GET /simulations.json
  def index
    @simulations = Simulation.all
  end

  # GET /simulations/1
  # GET /simulations/1.json
  def show
  end

  # GET /simulations/new
  def new
    @simulation = Simulation.new
  end

  # GET /simulations/1/edit
  def edit
  end

  def enable_final_reports
    @simulation.final_reports_enabled = true
    @simulation.save!
  end

  # POST /simulations
  # POST /simulations.json
  def create
    @simulation = Simulation.new(simulation_params)
    @simulation.intro_text = "<p style='margin:0in;font-size:15px;font-family:Calibri,sans-serif;'><strong><span style=font-size: 20px;>Welcome to the</span></strong></p>
<p style='margin:0in;font-size:15px;font-family:Calibri,sans-serif;'><span style=font-size: 20px;><strong><span style=color: rgb(0, 70, 144);>Executive Suite Banking Simulation™</span></strong><strong><span style=color: rgb(0, 70, 144);><sup></sup></span></strong><strong><span style=color: rgb(0, 70, 144);></span></strong></span></p>
<p style='margin:0in;font-size:15px;font-family:Calibri,sans-serif;'><span style=font-size: 20px;>&nbsp;</span></p>
<p style='margin:0in;font-size:15px;font-family:Calibri,sans-serif;'><span style=font-size: 20px;>This simulation has been developed to improve your understanding of the banking and financial services business.</span></p>
<p style='margin:0in;font-size:15px;font-family:Calibri,sans-serif;'><span style=font-size: 20px;>&nbsp;</span></p>
<p style='margin:0in;font-size:15px;font-family:Calibri,sans-serif;'><span style=font-size: 20px;>In this simulation, you and your team will assume the role of senior management for a fictional bank. You and your team will compete against other teams in the simulation to:</span></li>
<ul style=margin-bottom:0in;margin-top:0in; type=disc>
    <li style='margin-top:0in;margin-right:0in;margin-bottom:0in;margin-left:0in;font-size:15px;font-family:Calibri,sans-serif;'><span style=font-size: 20px;>Grow your business by attracting customers through marketing and competitive pricing</span></li>
    <li style='margin-top:0in;margin-right:0in;margin-bottom:0in;margin-left:0in;font-size:15px;font-family:Calibri,sans-serif;'><span style=font-size: 20px;>Retain customers by providing appropriate levels of customer service</span></li>
    <li style='margin-top:0in;margin-right:0in;margin-bottom:0in;margin-left:0in;font-size:15px;font-family:Calibri,sans-serif;'><span style=font-size: 20px;>Balance growth with appropriate funding</span></li>
    <li style='margin-top:0in;margin-right:0in;margin-bottom:0in;margin-left:0in;font-size:15px;font-family:Calibri,sans-serif;'><span style=font-size: 20px;>Manage credit and market risk</span></li>
    <li style='margin-top:0in;margin-right:0in;margin-bottom:0in;margin-left:0in;font-size:15px;font-family:Calibri,sans-serif;'><span style=font-size: 20px;>Invest and support your operations and informational technology infrastructure</span></li>
    <li style='margin-top:0in;margin-right:0in;margin-bottom:0in;margin-left:0in;font-size:15px;font-family:Calibri,sans-serif;'><span style=font-size: 20px;>Attract and retain employees</span></li>
    <li style='margin-top:0in;margin-right:0in;margin-bottom:0in;margin-left:0in;font-size:15px;font-family:Calibri,sans-serif;'><span style=font-size: 20px;>Control operating costs</span></li>
</ul>
<p style='margin:0in;font-size:15px;font-family:Calibri,sans-serif;'><span style=font-size: 20px;>&nbsp;</span></p>
<p style='margin:0in;font-size:15px;font-family:Calibri,sans-serif;'><span style=font-size: 20px;>Good luck!</span></p>
<p style='margin:0in;font-size:15px;font-family:Calibri,sans-serif;'><span style=font-size: 20px;>&nbsp;</span></p>
<p style='margin:0in;font-size:15px;font-family:Calibri,sans-serif;'><span style=font-size: 20px;>Choose the Start button to begin.</span></p>
    "


    respond_to do |format|
      if @simulation.save
        format.html { redirect_to @simulation, notice: 'Simulation was successfully created.' }
        format.json { render :show, status: :created, location: @simulation }
      else
        format.html { render :new }
        format.json { render json: @simulation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /simulations/1
  # PATCH/PUT /simulations/1.json
  def update
    puts "In Update"
    puts simulation_params
    respond_to do |format|
      if @simulation.update(simulation_params)
        format.html { redirect_to @simulation, notice: 'Simulation was successfully updated.' }
        format.json { render :show, status: :ok, location: @simulation }
      else
        format.html { render :edit }
        format.json { render json: @simulation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /simulations/1
  # DELETE /simulations/1.json
  def destroy
    @simulation.destroy
    respond_to do |format|
      format.html { redirect_to "/admin", notice: 'Simulation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def add_debrief
    my_params = params.permit(:debrief, :simulation_id)
    simulation = Simulation.find(my_params[:simulation_id])
    simulation.debrief.attach(my_params[:debrief])
  end

  def add_economic_data
    my_params = params.permit(:economic_data, :simulation_id)
    simulation = Simulation.find(my_params[:simulation_id])
    simulation.economic_data.attach(my_params[:economic_data])
  end

  def add_opening_report
    my_params = params.permit(:opening_report, :simulation_id)
    simulation = Simulation.find(my_params[:simulation_id])
    simulation.opening_report.attach(my_params[:opening_report])
  end

  def edit_intro_text

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_simulation
      @simulation = Simulation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def simulation_params

      params.require(:simulation).permit(:name, :number_of_rounds,   :intro_text , rounds_attributes: [ :name , :id , :_destroy , input_screens: [:id ]])
  #    params
    end
end
