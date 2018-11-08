class CreateDevises < ActiveRecord::Migration[5.2]
  def change
    create_table :devises do |t|
    	t.string :name
      t.float :price
      t.timestamp
    end
  end
end
