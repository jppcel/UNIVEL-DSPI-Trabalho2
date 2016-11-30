class CreateSetors < ActiveRecord::Migration[5.0]
  def change
    create_table :setors do |t|
      t.string :nomeSetor
      t.string :letraSetor
      t.integer :ultimaSenha, default: 0

      t.timestamps
    end
  end
end
