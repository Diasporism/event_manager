require 'sunlight'
require_relative 'zipcodes'

class Legislators
  def initialize(zipcode)
    @zipcode = zipcode
   @legislator_list = legislators_for_zipcode
  end

  def to_s
    @legislator_list.join(', ')
  end

  def legislators_for_zipcode
    legislators = Sunlight::Legislator.all_in_zipcode(@zipcode)
    legislators.collect do |legislator|
      "#{legislator.firstname} #{legislator.lastname}"
    end
  end
end