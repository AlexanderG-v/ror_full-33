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
      self.check.push(name, type, options)
    end
  end

  module InstanceMethods
    def validate!
      self.class.check.each do |name, type, options|
        var = instance_variable_get("@#{name}".to_sym)
        case type
        when :presence
          raise 'Не может быть пустым!' if var.nil? && var.empty?
        when :format
          raise 'Не правильный формат!' unless var =~ options.first
        when :type
          raise 'Не соответствует классу!' unless var.instance_of?(options.first)
        end
      end
    end
  end

  def valid?
    validate!
    true
  rescue RuntimeError, ArgumentError
    false
  end
end
