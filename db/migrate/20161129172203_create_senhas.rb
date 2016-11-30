class CreateSenhas < ActiveRecord::Migration[5.0]
  def change
    create_table :senhas do |t|
      t.string :senha
      t.datetime :dataGeracao, nil: false
      t.boolean :chamado, default: false
      t.datetime :dataChamado, default: nil
      t.boolean :rechamado, default: false
      t.datetime :dataRechamado, default: nil
      t.boolean :isPrioritario, default: false
      t.integer :setor_id
      t.integer :usuario_id

      t.timestamps
    end
  end
end
