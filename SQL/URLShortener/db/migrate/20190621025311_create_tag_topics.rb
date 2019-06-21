class CreateTagTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_topics do |t|
      t.string :tag, null: false, index: {unique: true}
      t.timestamps
    end
  end
end
