class AddStatusToPhotos < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :status, :integer, default: 0
  end
end
