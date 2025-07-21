ActiveAdmin.register Review do

  permit_params :user_id, :company_id, :rating, :title, :content, :status

  index do
    selectable_column
    id_column
    column :user
    column :company
    column :rating
    column :title
    column :status do |review|
      review.status.humanize
    end
    column :created_at
    actions
  end

  filter :user
  filter :company
  filter :rating
  filter :status, as: :select, collection: Review.statuses.keys.map { |k| [k.humanize, k] }
  filter :created_at

  form do |f|
    f.inputs do
      f.input :user
      f.input :company
      f.input :rating
      f.input :title
      f.input :content
      f.input :status, as: :select, collection: Review.statuses.keys.map { |k| [k.humanize, k] }
    end
    f.actions
  end

  show do
    attributes_table do
      row :user
      row :company
      row :rating
      row :title
      row :content
      row :status do |review|
        review.status.humanize
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  action_item :approve, only: :show do
    link_to 'Approve', approve_admin_review_path(review), method: :put unless review.approved?
  end

  action_item :reject, only: :show do
    link_to 'Reject', reject_admin_review_path(review), method: :put unless review.rejected?
  end

  member_action :approve, method: :put do
    review = Review.find(params[:id])
    review.approved!
    redirect_to admin_review_path(review), notice: "Review approved!"
  end

  member_action :reject, method: :put do
    review = Review.find(params[:id])
    review.rejected!
    redirect_to admin_review_path(review), notice: "Review rejected!"
  end

end
