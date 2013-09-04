require 'active_support/concern'
require 'chronic'
require 'chronic_duration'

module Chronorails
  module ChronicAccessors
    extend ActiveSupport::Concern

    def chronic_errors
      @chronic_errors ||= {}
    end

    module ClassMethods
      def chronic_duration_field name, options={}
        unless options[:accessible] == false
          attr_accessible "chronic_duration_#{name}"
        end
        unless options[:validates] == false
          validates "chronic_duration_#{name}", :chronic_parsable => true
        end

        define_method("chronic_duration_#{name}") do
          value = self.send(name)
          ChronicDuration.output(value) unless value.nil?
        end

        define_method("chronic_duration_#{name}=") do |value|
          if options[:required] == true && value.blank?
            chronic_errors["chronic_duration_#{name}"] = :set_to_blank
            return
          elsif value.blank?
            parsed_value = nil
          else
            parsed_value = ChronicDuration.parse(value)
            if parsed_value.nil?
              chronic_errors["chronic_duration_#{name}"] = :set_to_invalid
              return
            end
          end

          self.send("#{name}=", parsed_value)
          chronic_errors.delete("chronic_duration_#{name}")
        end
      end

      def chronic_field name, options={}
        unless options[:accessible] == false
          attr_accessible "chronic_#{name}"
        end
        unless options[:validates] == false
          validates "chronic_#{name}", :chronic_parsable => true
        end

        define_method("chronic_#{name}") do
          self.send(name)
        end

        define_method("chronic_#{name}=") do |value|
          if options[:required] == true && value.blank?
            chronic_errors["chronic_#{name}"] = :set_to_blank
            return
          elsif value.blank?
            parsed_value = nil
          else
            parsed_value = Chronic.parse(value)
            if parsed_value.nil?
              chronic_errors["chronic_#{name}"] = :set_to_invalid
              return
            end
          end
          
          self.send("#{name}=", parsed_value)
          chronic_errors.delete("chronic_duration_#{name}")
        end
      end
    end
  end
end
