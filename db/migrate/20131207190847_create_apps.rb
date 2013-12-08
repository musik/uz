class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name
      t.string :slug
      t.integer :pagetype
      t.integer :uv
      t.boolean :punish
      t.string :keywords
      t.date :found_at
      t.string :site_type
      t.string :description
      t.string :logo
      t.string :owner
      t.integer :o_site_id
      t.integer :o_user_id

      t.timestamps
    end
    add_index :apps,:slug,name: 'slug',unique: true
  end
end
