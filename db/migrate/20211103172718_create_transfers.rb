class CreateTransfers < ActiveRecord::Migration[7.0]
  def change
    create_table :transfers do |t|
      t.integer :amount
      t.belongs_to :from_user, null: false, foreign_key: { to_table: :users }
      t.belongs_to :to_user, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
