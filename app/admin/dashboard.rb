# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recent Companies" do
          ul do
            Company.last(5).map do |company|
              li link_to(company.name, admin_company_path(company))
            end
          end
        end
      end

      column do
        panel "Recent Leads" do
          ul do
            Lead.last(5).map do |lead|
              li link_to(lead.email, admin_lead_path(lead))
            end
          end
        end
      end

      column do
        panel "Recent Quotes" do
          ul do
            Quote.last(5).map do |quote|
              li link_to(quote.name, admin_quote_path(quote))
            end
          end
        end
      end
    end

    columns do
      column do
        panel "Overview" do
          para "Welcome to the SolarInside Admin Dashboard!"
          para "Here you can manage companies, leads, quotes, and other essential data."
        end
      end
    end
  end # content
end
