class ChengeSearchContentsAddColatte < ActiveRecord::Migration[7.0]
  def up
    # 一時的にテーブルを削除
    drop_table :search_contents

    # COLLATE オプションを指定してテーブルを再作成
    create_table :search_contents, options: 'COLLATE=utf8_unicode_ci' do |t|
      t.references :repertoire, index: true
      t.references :ingredient, index: true
      t.string :origin_repertoire_name
      t.string :repertoire_name
      t.text :origin_ingredient_name
      t.text :ingredient_name
    end
  end
end
