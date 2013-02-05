require 'date'

class RegistrationDate
  def initialize(registration_date)
    times = []
    @times = times
    @registration_date = clean_registration_dates(registration_date)
  end

  def to_s
    @registration_date
  end

  def clean_registration_dates(registration_date)
    registration_date.each do |date|
      @times << DateTime.strptime(date, "%m/%e/%y %H:%M")
    end
  end

  def get_peak_registration_hour
    hours = Hash.new(0)
    @times.each {|date| hours[date.strftime("%H").to_sym] += 1}
    "The peak registration hour is #{hours.max_by { |k,v| v }[0]} hundred hours (military time)."
  end

  def get_peak_registration_day
    days_of_the_week = Hash.new(0)
    @times.each do |date|
      year = date.strftime("%y").to_i
      day = date.strftime("%e").to_i
      month = date.strftime("%m").to_i
      days = Date.new(year, month, day).wday
      days_of_the_week[days] += 1
    end

    day = days_of_the_week.max_by { |k,v| v }[0]
    day_string_array = %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)
    "The most common registration day is #{day_string_array[day]}."
  end
end