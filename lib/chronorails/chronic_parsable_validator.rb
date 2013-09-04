require 'active_model'
require 'active_model/validator'

module Chronorails
  class ChronicParsableValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      if record.chronic_errors[attribute.to_s] == :set_to_blank
        record.errors[attribute] << (options[:message] || "can't be blank")
      end
      if record.chronic_errors[attribute.to_s] == :set_to_invalid
        record.errors[attribute] << (options[:message] || "must be set to a valid time")
      end
    end
  end
end

# Compatibility with ActiveModel validates method which matches option keys to their validator class
ChronicParsableValidator = Chronorails::ChronicParsableValidator