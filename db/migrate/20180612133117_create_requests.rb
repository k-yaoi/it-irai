class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.string :title
      t.string :description
      t.references :user, foreign_key: true
      t.integer :charge_user
      t.date :limit_date
      t.integer :status

      t.timestamps
    end
  end
end
