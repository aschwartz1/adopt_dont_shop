class UpdateApplicationPets < ActiveRecord::Migration[5.2]
  def change
    add_column :application_pets, :status, :integer, default: 1
    add_index :application_pets, [:application_id, :pet_id], unique: true
  end
end
