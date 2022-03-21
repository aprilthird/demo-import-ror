class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :occupation
      t.string :company
      t.integer :age
      t.decimal :salary
      t.text :address

      t.timestamps
    end
  end
end
