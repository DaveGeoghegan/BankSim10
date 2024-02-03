# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
#


InputScreen.destroy_all
is = InputScreen.create({
                            name: 'Retail Deposits',
                            navigation_label: 'Retail Deposits',
                            identifier: 'retail_banking_retail_deposits',
                            input_screen_number: 1
                        })

is = InputScreen.create({
                            name: 'Investment Management',
                            navigation_label: 'Investment Management',
                            identifier: 'retail_banking_investment_management',
                            input_screen_number: 2
                        })
is = InputScreen.create({
                            name: 'Consumer Lending',
                            navigation_label: 'Consumer Lending',
                            identifier: 'retail_banking_consumer_lending',
                            input_screen_number: 3
                        })
is = InputScreen.create({
                            name: 'Mortgage Lending',
                            navigation_label: 'Mortgage Lending',
                            identifier: 'retail_banking_mortgage_lending',
                            input_screen_number: 4
                        })
is = InputScreen.create({
                            name: 'Operations',
                            navigation_label: 'Operations',
                            identifier: 'retail_banking_operations',
                            input_screen_number: 5
                        })
is = InputScreen.create({
                            name: 'Human Resources',
                            navigation_label: 'Human Resources',
                            identifier: 'retail_banking_human_resources',
                            input_screen_number: 6
                        })
is = InputScreen.create({
                            name: 'Commercial Lending',
                            navigation_label: 'Commercial Lending',
                            identifier: 'corporate_banking_commercial_lending',
                            input_screen_number: 7
                        })
is = InputScreen.create({
                            name: 'Investment Banking',
                            navigation_label: 'Investment Banking',
                            identifier: 'corporate_banking_investment_banking',
                            input_screen_number: 8
                        })
is = InputScreen.create({
                            name: 'Treasury Services',
                            navigation_label: 'Treasury Services',
                            identifier: 'corporate_banking_treasury_services',
                            input_screen_number: 9
                        })
is = InputScreen.create({
                            name: 'Operations',
                            navigation_label: 'Operations',
                            identifier: 'corporate_banking_operations',
                            input_screen_number: 10
                        })
is = InputScreen.create({
                            name: 'Human Resources',
                            navigation_label: 'Human Resources',
                            identifier: 'corporate_banking_human_resources',
                            input_screen_number: 11
                        })
is = InputScreen.create({
                            name: 'Asset/Liability Management',
                            navigation_label: 'Asset/Liability Management',
                            identifier: 'asset_liability_management',
                            input_screen_number: 12
                        })
RelatedReport.initialize_related_reports

puts "OK I am Making the Sim"
sim = Simulation.create({name: 'Bank Sim' , is_active:true , number_of_rounds:3 , intro_text: "Hey I am an intro!<b>Bold</b>"})
sim.intro_text = "<p style='margin:0in;font-size:15px;font-family:Calibri,sans-serif;'><strong><span style=font-size: 20px;>Welcome to the</span></strong></p>
<p style='margin:0in;font-size:15px;font-family:Calibri,sans-serif;'><span style=font-size: 20px;><strong><span style=color: rgb(0, 70, 144);>Executive Suite Banking Simulation</span></strong><strong><span style=color: rgb(0, 70, 144);><sup>&copy;</sup></span></strong><strong><span style=color: rgb(0, 70, 144);>&nbsp;Simulation</span></strong></span></p>
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
sim.save!
puts "Sim Made"
defaults = [
    7.9, 15, 20.5, 6.6, 10, 15.5, 9.5, 15, 2, 2, 2, 2, 2, 2, 3.9
]



# InputItem.build_input_items(sim)
# puts " Make the Rounds"
# for i in 1..4 do
#   puts " Making a Round"
#   round = Round.create({
#                            name: 'Round ' + i.to_s,
#                            round_number: i,
#                            simulation: sim,
#                            is_enabled: i == 1 ? true : false,
#                            is_active: i == 1 ? true : false,
#                            is_closed: false
#                        })
#   puts " Round Made adding " + InputScreen.all.count.to_s + " Input Items"
#   InputScreen.all.each do |is|
#     round.input_screens << is
#   end
#   puts "Made all Input Screens"
# end
#
puts " I am Going to Create the teams!"
Team.destroy_all
admin = Team.create({
                        name: 'admin',
                        password: 'psiou812',
                        simulation:sim,
                        is_admin:true
                    })

admin.save!


team = Team.create({
                       name: 'psi',
                       password: 'psi',
                       simulation: sim,
                   })
team.save!