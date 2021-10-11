# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_writer :instances_counter

    def instances_counter
      @instances_counter ||= 0
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.instances_counter += 1
    end
  end
end
