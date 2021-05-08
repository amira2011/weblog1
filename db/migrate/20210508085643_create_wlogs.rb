class CreateWlogs < ActiveRecord::Migration[6.1]
  def change
    create_table :wlogs do |t|
            t.string :IP
            t.datetime :Time
            t.text :URL
            t.string :Status
            t.integer :istatus
            t.float :RT
            t.string :Method
            t.text :URL1


      t.timestamps
    end
  end
end
