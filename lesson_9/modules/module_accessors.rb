# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("@#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        self.history ||= {}
        self.history[var_name] ||= []
        self.history[var_name] << value
      end
      define_method("#{name}_history") { history[var_name] }
    end
  end

  def strong_atter_accessor(name, name_class)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("@#{name}=".to_sym) do |value|
      raise TypeError unless value.instance_of?(name_class)

      instance_variable_set(var_name, value)
    end
  end
end
