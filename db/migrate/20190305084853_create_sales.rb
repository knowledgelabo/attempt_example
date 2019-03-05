class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.references :fiscal_year, index: true, foreign_key: true, null: false
      t.references :member, index: true, foreign_key: true, null: false
      t.integer :amount, default: 0, null: false

      t.timestamps null: false
    end
  end
end
