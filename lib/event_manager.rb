###
# EventManager
# by Logan Sears
# Completed 02/01/2013
###

require 'csv'
require 'erb'
require 'sunlight'
require 'date'
require_relative 'phone_number'
require_relative 'legislators'
require_relative 'registration_date'
require_relative 'zipcodes'

Sunlight::Base.api_key = 'e179a6973728c4dd3fb1204283aaccb5'

def save_thank_you_letters(id, form_letter)
  Dir.mkdir('output') unless Dir.exists? 'output'

  filename = "output/thanks_#{id}.html"
  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts 'EventManager initialized.'

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol
template_letter = File.read 'form_letter.erb'
erb_template = ERB.new template_letter

dates = []

contents.each do |row|
  registration_date = row[:regdate]
  dates << registration_date
  id = row[0]
  name = row[:first_name]
  zipcode = Zipcodes.new(row[:zipcode])
  phone_number = PhoneNumber.new(row[:homephone]).check_valid_phone_number
  legislators = Legislators.new(zipcode)

  form_letter = erb_template.result(binding)
  save_thank_you_letters(id, form_letter)

  puts zipcode
  puts phone_number
  puts legislators
end

registration_dates = RegistrationDate.new(dates)
puts registration_dates.get_peak_registration_hour
puts registration_dates.get_peak_registration_day