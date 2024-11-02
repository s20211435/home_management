class CreateNotifications < ActiveRecord::Migration[7.2]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :schedule, null: false, foreign_key: true
      t.boolean :read, default: false
      t.string :message
      t.datetime :notify_at
      t.timestamps
    end
  end
end
