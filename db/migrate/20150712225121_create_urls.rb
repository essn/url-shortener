class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|

      t.timestamps null: false
      t.string :url, null: false
      t.string :shortened_url, null: false, unique: true
    end
  end
end
