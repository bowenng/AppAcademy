require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    # ...
    values = params.values
    conditions = params.keys.map{|k| "#{k} = ?"}.join(" AND ") 
    puts conditions
    query = DBConnection.execute(<<-SQL, *values)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{conditions}
    SQL
    parse_all(query)
  end
end

class SQLObject
  # Mixin Searchable here...
  extend Searchable
end
