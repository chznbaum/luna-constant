class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.string :title
      t.references :user, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
