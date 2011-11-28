class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :list_id
      t.string :name
      t.string :url
      t.text :description

      t.timestamps
    end
  end
end
