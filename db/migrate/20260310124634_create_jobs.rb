class CreateJobs < ActiveRecord::Migration[8.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :company
      t.string :location
      t.text :description
      t.string :source_url
      t.boolean :visa_friendly
      t.datetime :scraped_at

      t.timestamps
    end
  end
end
