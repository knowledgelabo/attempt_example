class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.references :division, index: true, foreign_key: true, null: false
      t.string :full_name, null: false

      t.timestamps null: false
    end
  end
end
