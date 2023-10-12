class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string :uid
      t.string :first_name
      t.string :last_name
      t.integer :from_amount_cents, null: false
      t.integer :to_amount_cents, null: false
      t.string :from_currency, null: false, default: 'USD'
      t.string :to_currency, null: false
      t.references :manager, null: true, foreign_key: true, index: true

      t.timestamps
    end
  end
end
