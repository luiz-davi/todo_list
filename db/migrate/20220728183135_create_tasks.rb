class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.references :list, foreign_key: true
      t.boolean :done, default: false
      t.string :desscription

      t.timestamps
    end
  end
end
