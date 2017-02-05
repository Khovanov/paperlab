class CreateMaterials < ActiveRecord::Migration[5.0]
  def change
    create_table :materials do |t|
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
