class CreateFiscalYears < ActiveRecord::Migration[5.2]
  def change
    create_table :fiscal_years do |t|
      t.string :name, null: false
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false

      t.timestamps null: false
    end
  end
end
