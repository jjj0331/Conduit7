class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.text :body
      t.string :tagList, array: true, default: []
      t.timestamps
    end
  end
end
