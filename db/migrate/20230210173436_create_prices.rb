class CreatePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :prices do |t|
      t.float :value
      t.string :website
      t.references :bottle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
