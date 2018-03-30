class AddRequisitesForUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :admins do |t|
      t.string :name_user
      t.string :surname_user
      t.boolean :male_user
      t.date :date_of_birth
    end
  end
end
