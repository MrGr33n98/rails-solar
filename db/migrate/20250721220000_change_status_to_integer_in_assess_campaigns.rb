class ChangeStatusToIntegerInAssessCampaigns < ActiveRecord::Migration[7.0]
  def up
    add_column :assess_campaigns, :status_tmp, :integer, default: 0, null: false
    status_map = { 'draft' => 0, 'active' => 1, 'completed' => 2, 'cancelled' => 3 }
    status_map.each do |str, int|
      execute <<-SQL.squish
        UPDATE assess_campaigns SET status_tmp = #{int} WHERE status = '#{str}'
      SQL
    end
    remove_column :assess_campaigns, :status
    rename_column :assess_campaigns, :status_tmp, :status
  end

  def down
    add_column :assess_campaigns, :status_tmp, :string
    status_map = { 0 => 'draft', 1 => 'active', 2 => 'completed', 3 => 'cancelled' }
    status_map.each do |int, str|
      execute <<-SQL.squish
        UPDATE assess_campaigns SET status_tmp = '#{str}' WHERE status = #{int}
      SQL
    end
    remove_column :assess_campaigns, :status
    rename_column :assess_campaigns, :status_tmp, :status
  end
end
