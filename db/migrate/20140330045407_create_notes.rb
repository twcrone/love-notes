class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :message
      t.date :created_at
      t.date :sent_at

      t.timestamps
    end
  end
end
