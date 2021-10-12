# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :check

    def validate(name, type, *options)
      self.check ||= []
      self.check.push({ name: name, type: type, options: options })
    end
  end

  module InstanceMethods
    def validate!
      self.class.check.each do |value|
        argument_value = instance_variable_get("@#{value[:name]}")
        method_name = "validate_#{value[:type]}"
        send(method_name, argument_value, value[:options])
      end
    end

    def validate_presence(name)
      raise 'Не может быть пустым!' if name.nil? && name.empty?
    end

    def validate_format(name, _format)
      raise 'Не правильный формат!' unless name =~ formate
    end

    def validate_type(name, type)
      raise 'Не соответствует классу!' unless name.instance_of?(type)
    end

    def valid?
      validate!
      true
    rescue RuntimeError, ArgumentError
      false
    end
  end
end
