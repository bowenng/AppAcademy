class CreateShortenedUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :shortened_urls do |t|
      t.string :long_url, null: false, index: {unique: true}
      t.string :short_url, null: false, index: {unique: true}
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
