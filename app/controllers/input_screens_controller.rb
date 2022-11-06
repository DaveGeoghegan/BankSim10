class InputScreensController < ApplicationController


  before_action :set_input_screen, only: [:show, :edit, :update, :destroy]

  def show_input_screen
    puts "Show INput Screen"
    @input_screen = InputScreen.where(:input_screen_number => params[:input_screen_id]).first

    simulation = current_team.simulation
    @round = simulation.get_current_round
    @team_round = TeamRound.where(:team => current_team).where(:round => @round).first
    ap @team_round
    @team_round_input_screen = TeamRoundInputScreen.where(:team_round => @team_round).where(:input_screen => @input_screen).first
    @team_round_input_screen.was_visited = true
    @team_round_input_screen.save!
    @decisions = @team_round.decisions
    @input_items = simulation.input_items
    @next_input_screen = @round.get_next_input_screen(@input_screen)
    @previous_input_screen = @round.get_prev_input_screen(@input_screen)
    screen_name = 'input_screens/' + @input_screen.identifier.squish.downcase.tr(" ", "_")
    @data = {}
    @options = {}
    @team_round.graph_datum.each do |graph_data|
      puts "Doing A Graph Data"
      ap graph_data


      @data[graph_data.graph_id] = {
          labels: graph_data.x_labels.split(","),
          datasets: [
              {
                  label: graph_data.graph_label,
                  backgroundColor: 'rgba(69, 140, 205, 1)',
                  data: graph_data.data.split(",")
              }
          ]
      }


      decimal_places = (graph_data.number_of_decimal_places.to_i + 0).to_s
      # if decimal_places == "1" then
      #   decimal_places = "0"
      # end
      callback = "function(value, index, values) {console.log('formatting');console.log(value);return (value).toLocaleString('en-us',{
          minimumFractionDigits:" + decimal_places + "," +
          "maximumFractionDigits:" + decimal_places + "});}"
      tooltip_function = "function(tooltipItem, data)
       {return (tooltipItem.yLabel).toLocaleString('en-us',{
          minimumFractionDigits:" + decimal_places + "," +
          "maximumFractionDigits:" + decimal_places + "});}"
      is_percent = false
      if graph_data.is_percent == 1
        is_percent = true
      end

      if is_percent
        callback = "function(value, index, values) {return (value*100).toLocaleString('en-us',{
          minimumFractionDigits:" + decimal_places + "," +
            "maximumFractionDigits:" + decimal_places + "})+'%';}"
        tooltip_function = "function(tooltipItem, data)
       {return (tooltipItem.yLabel*100).toLocaleString('en-us',{
          minimumFractionDigits:" + decimal_places + "," +
            "maximumFractionDigits:" + decimal_places + "})+'%';}"

      end
      is_dollar = false
      if graph_data.is_dollar == 1
        is_dollar = true
      end
      if is_dollar
        callback = "function(value, index, values) {console.log('formatting');console.log(value);return '$'+(value).toLocaleString('en-us',{
          minimumFractionDigits:" + decimal_places + "," +
            "maximumFractionDigits:" + decimal_places + "});}"
        tooltip_function = "function(tooltipItem, data)
       {return '$' + (tooltipItem.yLabel).toLocaleString('en-us',{
          minimumFractionDigits:" + decimal_places + "," +
            "maximumFractionDigits:" + decimal_places + "});}"

      end

      @options[graph_data.graph_id] = {
          height: '200px',
          scales: {
              yAxes: [{
                          ticks: {
                              min: graph_data.y_min.to_f,
                              max: graph_data.y_max.to_f,
                              callback: callback
                          }
                      }]
          },

          tooltips: {
              callbacks: {
                  label: tooltip_function
              }
          }

      }

    end
    puts "Here's the Data"
    ap @data
    puts "Here's the options"
    ap @options


    render screen_name
  end

  def update_decision_field
    puts "Update Decision field"
    ap params
    my_params = params.permit(:field_id, :field_value, :input_screen_id)
    @input_screen = InputScreen.find(my_params[:input_screen_id])
    the_value = params['field_value']
    the_id = params['field_id']
    @team_round = current_team_round
    @team_round_input_screen = TeamRoundInputScreen.where(:team_round => @team_round).where(:input_screen => @input_screen).first
    @team_round_input_screen.data_entered = true
    @team_round_input_screen.save!
    theDecision = Decision.where(:team_round_id => @team_round.id).where(:field_name => the_id).first
    theDecision.field_value = the_value
    theDecision.save!

    render :json => true
  end

  def submit_decisions
    @input_screen = InputScreen.where(:input_screen_number => params[:input_screen_id]).first
    @team_round = TeamRound.find(1)
    params.each do |id, value|
      # ap param
      theKey = id
      theValue = value
      ap "The Key is " + theKey
      unless theKey == 'authenticity_token' || theKey == "utf8"
        theDecision = Decision.where(:team_round_id => @team_round.id).where(:field_name => theKey).first
        if theDecision.nil?
          theDecision = Decision.new
          theDecision.team_round_id = @team_round.id
          theDecision.field_name = theKey
        end
        theDecision.field_value = theValue
        theDecision.save!
      end

    end
    redirect_to "/round/1/input_screen/" + (@input_screen.input_screen_number + 1).to_s
  end


  def test_input_form

  end

  def update_input_screen_info
    puts "Here I am"
    puts params
    render :json => true
  end

  # GET /input_screens
  # GET /input_screens.json
  def index
    @input_screens = InputScreen.all
  end

  # GET /input_screens/1
  # GET /input_screens/1.json
  def show
  end

  # GET /input_screens/new
  def new
    @input_screen = InputScreen.new
  end

  # GET /input_screens/1/edit
  def edit
  end

  # POST /input_screens
  # POST /input_screens.json
  def create
    @input_screen = InputScreen.new(input_screen_params)

    respond_to do |format|
      if @input_screen.save
        format.html {redirect_to @input_screen, notice: 'Input screen was successfully created.'}
        format.json {render :show, status: :created, location: @input_screen}
      else
        format.html {render :new}
        format.json {render json: @input_screen.errors, status: :unprocessable_entity}
      end
    end
  end

  def submit_decision
    puts " Update Decision"
    ap params
    team_round = current_team_round
    input_screen = Round.find(params[:input_screen_id])
    params[:fields].each do |f|
      obj = f[1]
      input_item = InputItem.where(:identifier => obj[:input_item_id]).first
      cur = Decision.where(team_round_id: team_round.id, input_item_id: input_item.id).first_or_initialize
      theValue = obj[:value]
      if theValue.end_with? "%" then
        theValue = theValue[0..theValue.length - 2]
      end
      cur.value = theValue
      cur.save!

      puts "next.."
      ap f[1]
    end

    render :json => :true
  end

  # PATCH/PUT /input_screens/1
  # PATCH/PUT /input_screens/1.json
  def update
    respond_to do |format|
      if @input_screen.update(input_screen_params)
        format.html {redirect_to @input_screen, notice: 'Input screen was successfully updated.'}
        format.json {render :show, status: :ok, location: @input_screen}
      else
        format.html {render :edit}
        format.json {render json: @input_screen.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /input_screens/1
  # DELETE /input_screens/1.json
  def destroy
    @input_screen.destroy
    respond_to do |format|
      format.html {redirect_to input_screens_url, notice: 'Input screen was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_input_screen
    @input_screen = InputScreen.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def input_screen_params
    params.require(:input_screen).permit(:name, :navigation_label, :identifier)
  end
end
