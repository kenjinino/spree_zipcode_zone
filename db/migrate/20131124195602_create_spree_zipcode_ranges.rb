class CreateSpreeZipcodeRanges < ActiveRecord::Migration
  def change
    create_table :spree_zipcode_ranges do |t|
      t.string :name
      t.string :start_zip
      t.string :end_zip

      t.timestamps
    end
  end
end
