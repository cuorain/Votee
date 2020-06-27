class CreateSurveys < ActiveRecord::Migration[5.2]
  def change
    create_table :surveys do |t|
      t.string :question
      t.references :user, index: true, foreign_key: true
      t.timestamps
    end
    add_index :surveys, [:user_id, :created_at]
  end
end
