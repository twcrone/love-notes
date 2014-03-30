class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string    :message
      t.datetime  :sent_at

      t.timestamps
    end
  end
end
