class RomanticMeeting < ActiveRecord::Base
  attr_accessible :length, :start

  include Chronorails::ChronicAccessors
  chronic_field :start, :required => true, :validates => true
  chronic_duration_field :length, :validates => true
end
