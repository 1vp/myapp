class CreateCurrencies < ActiveRecord::Migration[5.1]
  def change
    create_table :currencies do |t|
      t.string :id_currency
      t.integer :numCode
      t.string :charCode
      t.integer :nominal
      t.string :name
      t.string :value
      t.string :previous
      t.timestamps
    end
  end
end