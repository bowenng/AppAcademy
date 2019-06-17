require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
    include Singleton
    SQL_FILE = File.join(File.dirname(__FILE__), 'import_db.sql')
    DB_FILE = File.join(File.dirname(__FILE__), 'questions.db')

    def initialize
        super(DB_FILE)
        self.result_as_hash = true
        self.type_transition = true
    end
end