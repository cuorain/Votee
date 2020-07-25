class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :user, index: true
      t.references :survey, index: true
      t.references :choice, index: true
      t.string :comment
      t.timestamps
    end
    add_index :votes, [:user_id, :survey_id]
  end
end
