class Remove < ActiveRecord::Migration[5.1]
  def change
     remove_column :users, :passwprd_digest, :string
  end
end
