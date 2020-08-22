class AddUserRefToRental < ActiveRecord::Migration[6.0]
  def change
    add_reference :rentals, :user, null: false, foreign_key: true
  end
end
