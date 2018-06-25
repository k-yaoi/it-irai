class AddMessageToRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :requests, :message, :string
  end
end
