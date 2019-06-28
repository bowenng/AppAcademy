require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    # ...
    self.class_name.constantize
  end

  def table_name
    # ...
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    # ...
    self.foreign_key = "#{name}_id".to_sym
    self.primary_key = :id
    self.class_name = name.to_s.camelcase

    options.each do |k, v|
      self.send("#{k}=", v)
    end
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    # ...
    self.foreign_key = "#{self_class_name.underscore}_id".to_sym
    self.primary_key = :id
    self.class_name = name.to_s.camelcase.singularize

    options.each do |k, v|
      self.send("#{k}=", v)
    end
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    # ...
    self.assoc_options[name] = BelongsToOptions.new(name, options)

    define_method(name) do 
      options = self.class.assoc_options[name]
      foreign_key = self.send(options.foreign_key)
      options.model_class.where(options.primary_key => foreign_key).first
    end
    
  end

  def has_many(name, options = {})
    # ...
    self.assoc_options[name] = HasManyOptions.new(name, self.name, options)

    define_method(name) do
      options = self.class.assoc_options[name]
      primary_key = self.send(options.primary_key)
      options.model_class.where(options.foreign_key => primary_key)
    end
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
      @assoc_options ||= {}
      @assoc_options
  end
end

class SQLObject
  # Mixin Associatable here...
  extend Associatable
end
