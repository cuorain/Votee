class CreateChoices < ActiveRecord::Migration[5.2]
  def change
    create_table :choices do |t|
      t.string :answer
      t.references :survey, index: true, foreign_key: true
      t.timestamps
    end
  end
end
