class RomanticMeeting < ActiveRecord::Base
  attr_accessible :length, :start

  include Chronorails::ChronicAccessors
  chronic_field :start, :required => true
  chronic_duration_field :length
end
