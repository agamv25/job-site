class AddUniqueIndexToJobsSourceUrl < ActiveRecord::Migration[8.1]
  def change
    add_index :jobs, :source_url, unique: true
  end
end
