ActiveAdmin.register Reply do

  permit_params :user_id, :discussion_id, :body, :status

  index do
    selectable_column
    id_column
    column :discussion
    column :user
    column :body
    column :status do |reply|
      reply.status.humanize
    end
    column :created_at
    actions
  end

  filter :discussion
  filter :user
  filter :status, as: :select, collection: Reply.statuses.keys.map { |k| [k.humanize, k] }
  filter :created_at

  form do |f|
    f.inputs do
      f.input :discussion
      f.input :user
      f.input :body
      f.input :status, as: :select, collection: Reply.statuses.keys.map { |k| [k.humanize, k] }
    end
    f.actions
  end

  show do
    attributes_table do
      row :discussion
      row :user
      row :body
      row :status do |reply|
        reply.status.humanize
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  action_item :approve, only: :show do
    link_to 'Approve', approve_admin_reply_path(reply), method: :put unless reply.approved?
  end

  action_item :reject, only: :show do
    link_to 'Reject', reject_admin_reply_path(reply), method: :put unless reply.rejected?
  end

  member_action :approve, method: :put do
    reply = Reply.find(params[:id])
    reply.approved!
    redirect_to admin_reply_path(reply), notice: "Reply approved!"
  end

  member_action :reject, method: :put do
    reply = Reply.find(params[:id])
    reply.rejected!
    redirect_to admin_reply_path(reply), notice: "Reply rejected!"
  end

end
