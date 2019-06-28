require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # ...
    @column_query ||= DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL

    columns = @column_query[0]
    columns.map{|c| c.to_sym}
  end

  def self.finalize!
    self.columns.each do |c|
      define_method(c) {
        self.attributes[c]
      }
      define_method("#{c}=") {
        |x| self.attributes[c] = x
      }
    end
  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name
  end

  def self.table_name
    # ...
    @table_name ||= self.name.tableize
  end

  def self.all
    # ...
    results = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        "#{self.table_name}"
    SQL
    self.parse_all(results)
  end

  def self.parse_all(results)
    # ...
    results.map{|entry| self.new(entry)}
  end

  def self.find(id)
    # ...
    query = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        "#{self.table_name}"
      WHERE
        "#{self.table_name}".id = ?
      LIMIT
        1
    SQL

    self.parse_all(query)[0]
  end

  def initialize(params = {})
    # ...
    params.each do |attr_name, attr_value|
      unless self.class.columns.include?(attr_name.to_sym)
        raise "unknown attribute '#{attr_name}'"
      end

      self.send("#{attr_name}=", attr_value)
    end
  end

  def attributes
    # ...
    @attributes ||= {}
  end

  def attribute_values
    # ...
    self.class.columns.map{|c| self.send(c)}
  end

  def insert
    # ...
    question_marks = "(#{(['?']*self.class.columns.length).join(',')})"
    DBConnection.execute(<<-SQL, *self.attribute_values)
      INSERT INTO
        "#{self.class.table_name}"
      VALUES
        #{question_marks}
    SQL
    self.id = DBConnection.last_insert_row_id
  end

  def update
    # ...
    attributes_to_set = self.class.columns.map{|c| "#{c.to_s} = ?"}.join(", ")
    DBConnection.execute(<<-SQL, *self.attribute_values, self.id)
      UPDATE
        #{self.class.table_name}
      SET
        #{attributes_to_set}
      WHERE
        id = ?
    SQL
  end

  def save
    # ...
    if self.id
      self.update
    else
      self.insert
    end
  end
end
