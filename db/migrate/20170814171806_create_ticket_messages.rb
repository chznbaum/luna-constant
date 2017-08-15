class CreateTicketMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :ticket_messages do |t|
      t.text :message
      t.references :ticket, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
