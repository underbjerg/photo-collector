class AddKnowsCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :knows_code, :boolean
  end
end
