class CreateVisits < ActiveRecord::Migration[5.2]
  def change
    create_table :visits do |t|
      t.integer :visitor_id, null: false, index: true
      t.integer :url_id, null: false, index: true
      t.timestamps
    end
  end
end
