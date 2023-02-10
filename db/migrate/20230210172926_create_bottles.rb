class CreateBottles < ActiveRecord::Migration[7.0]
  def change
    create_table :bottles do |t|
      t.string :name
      t.integer :expert_rating
      t.string :image_url

      t.timestamps
    end
  end
end
