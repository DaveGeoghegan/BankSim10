# config/initializers/pusher.rb
require 'pusher'

Pusher.app_id = "1202276"
Pusher.key = "d3a2645cfa3fdd883877"
Pusher.secret = "2bf5c38b96631b4b1483"
Pusher.cluster = "us2"
Pusher.logger = Rails.logger
Pusher.encrypted = true