class CreateSaaSLeads < ActiveRecord::Migration[7.0]
  def change
    create_table :saa_s_leads do |t|
      ## Contato
      t.string   :first_name,                null: false
      t.string   :last_name,                 null: false
      t.string   :email,                     null: false, index: true
      t.string   :phone_number
      t.string   :preferred_contact_time
      t.string   :contact_method             # e.g. "Telefone", "E‑mail", "WhatsApp"

      ## Empresa / Local
      t.string   :company_name
      t.string   :building_type              # "Residência", "Comércio", "Indústria"
      t.string   :roof_type                  # "Fibrocimento", "Cerâmica", "Metálico"…
      t.decimal  :available_roof_area,       precision: 8, scale: 2  # m²
      t.string   :address
      t.string   :city
      t.string   :state

      ## Consumo e expectativa
      t.integer  :monthly_energy_consumption_kwh
      t.string   :budget_range               # ex. "Até 5k", "5–10k", "10–20k"
      t.string   :decision_timeline          # ex. "Imediato", "1–3 meses", "3–6 meses"
      t.string   :current_energy_provider

      ## Qualificação interna
      t.integer  :score,                     default: 0, index: true
      t.integer  :status,                    null: false, default: 0
      # status enum: { new: 0, contact_made: 1, proposal_sent: 2, won: 3, lost: 4 }
      t.text     :pain_points
      t.string   :competitor_considered

      ## Origem e Marketing
      t.string   :lead_source                # e.g. "Google Ads", "Facebook", "Indicação", "Orgânico"
      t.string   :utm_campaign
      t.string   :utm_source
      t.string   :utm_medium

      ## Pré‑venda e controle de funil
      t.references :saas_plan, foreign_key: true
      t.boolean  :b2b,                       default: false, index: true
      t.string   :funnel_stage               # ex. "novo", "qualificado", "em contato", "fechado"
      t.boolean  :site_visit_scheduled,      default: false
      t.datetime :site_visit_date
      t.datetime :converted_at               # data de conversão em empresa
      t.datetime :proposal_sent_at
      t.datetime :follow_up_date

      t.timestamps
    end

    add_index :saa_s_leads, :lead_source
    add_index :saa_s_leads, :funnel_stage
  end
end
