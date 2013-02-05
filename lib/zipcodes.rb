class Zipcodes
  def initialize(zipcode)
    @zipcode = clean_zipcode(zipcode)
  end

  def to_s
    @zipcode
  end

  def clean_zipcode(zipcode)
    zipcode.to_s.rjust(5,'0')[0..4]
  end
end