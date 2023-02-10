class CreateBottleTags < ActiveRecord::Migration[7.0]
  def change
    create_table :bottle_tags do |t|
      t.references :bottle, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
