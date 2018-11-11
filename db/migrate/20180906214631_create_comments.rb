class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :post, foreign_key: true
      t.string :name, null: false #必須入力にする
      t.text :comment, null: false #必須入力にする

      t.timestamps
    end
  end
end
