class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :status
      t.references :user
      t.timestamps
    end
  end
end
