class RemoveOwnerId < ActiveRecord::Migration
  def change
    remove_column(:pets, :owner_id)
  end
end
