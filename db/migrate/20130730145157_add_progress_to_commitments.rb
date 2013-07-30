class AddProgressToCommitments < ActiveRecord::Migration
  def change
    add_column :commitments, :progress, :integer, default: 0
  end
end
