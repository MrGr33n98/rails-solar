ActiveAdmin.register SaasPlan do

  permit_params :name, :saas_product_id, :tier, :features, :price, :active

  # Scopes para as abas
  scope("Clientes")      { |plans| plans.where(tier: 'clientes') }
  scope("Advanced")      { |plans| plans.where(tier: 'advanced') }
  scope("Profissional")  { |plans| plans.where(tier: 'profissional') }
  scope("Starter")       { |plans| plans.where(tier: 'starter') }
  scope("Prospecção")    { |plans| plans.where(tier: 'prospeccao') }
  scope("Growth")        { |plans| plans.where(tier: 'growth') }
  scope("Reputation")    { |plans| plans.where(tier: 'reputation') }
  scope("Gratuitos")     { |plans| plans.where(tier: 'gratuito') }
  scope :all, default: true

  index do
    selectable_column
    id_column
    column :name
    column :saas_product
    column :tier do |plan|
      plan.tier.humanize
    end
    column :price
    column :active
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :saas_product
      f.input :name
      f.input :tier, as: :select, collection: SaasPlan.tiers.keys.map { |k| [k.humanize, k] }
      f.input :features
      f.input :price
      f.input :active
    end
    f.actions
  end

  filter :name
  filter :saas_product
  filter :tier, as: :select, collection: SaasPlan.tiers.keys.map { |k| [k.humanize, k] }
  filter :price
  filter :active
  filter :created_at
  filter :updated_at

  show do
    attributes_table do
      row :saas_product
      row :name
      row :tier do |plan|
        plan.tier.humanize
      end
      row :features
      row :price
      row :active
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end
