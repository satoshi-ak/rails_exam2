class AddColumnToPictures < ActiveRecord::Migration[5.2]
  def change
    add_column :pictures, :post, :string
  end
end
