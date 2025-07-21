ActiveAdmin.register Discussion do

  permit_params :user_id, :product_id, :category_id, :subject, :body, :status

  index do
    selectable_column
    id_column
    column :subject
    column :user
    column :product
    column :category
    column :status do |discussion|
      discussion.status.humanize
    end
    column :created_at
    actions
  end

  filter :subject
  filter :user
  filter :product
  filter :category
  filter :status, as: :select, collection: Discussion.statuses.keys.map { |k| [k.humanize, k] }
  filter :created_at

  form do |f|
    f.inputs do
      f.input :user
      f.input :product
      f.input :category
      f.input :subject
      f.input :body
      f.input :status, as: :select, collection: Discussion.statuses.keys.map { |k| [k.humanize, k] }
    end
    f.actions
  end

  show do
    attributes_table do
      row :user
      row :product
      row :category
      row :subject
      row :body
      row :status do |discussion|
        discussion.status.humanize
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  action_item :close, only: :show do
    link_to 'Close Discussion', close_admin_discussion_path(discussion), method: :put unless discussion.closed?
  end

  action_item :open, only: :show do
    link_to 'Open Discussion', open_admin_discussion_path(discussion), method: :put if discussion.closed?
  end

  member_action :close, method: :put do
    discussion = Discussion.find(params[:id])
    discussion.closed!
    redirect_to admin_discussion_path(discussion), notice: "Discussion closed!"
  end

  member_action :open, method: :put do
    discussion = Discussion.find(params[:id])
    discussion.open!
    redirect_to admin_discussion_path(discussion), notice: "Discussion opened!"
  end

end
