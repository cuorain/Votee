class CreateVotesChoices < ActiveRecord::Migration[5.2]
  def change
    create_table :votes_choices do |t|
      t.integer :vote_id
      t.integer :choice_id
      t.timestamps
    end
  end
end
