    # Análise do Modelo de Dados do Projeto

    Este documento detalha os domínios, tabelas, seus atributos e relacionamentos no projeto `noticed_v2`.

    ## Convenções

    *   **Domínio/Tabela:** Representa uma entidade principal no sistema, geralmente mapeada para uma tabela no banco de dados.
    *   **Atributos:** Colunas da tabela, com seus tipos de dados.
    *   **Relacionamentos:** Associações entre domínios (ex: `belongs_to`, `has_many`).
    *   **Validações:** Regras de integridade de dados aplicadas aos atributos.
    *   **Enums:** Listas predefinidas de valores para um atributo.
    *   **Escopos:** Métodos de consulta predefinidos para um domínio.

    ---

    ## Domínios

    ### AdminUser

    *   **Descrição:** Usuários administradores do sistema, com funcionalidades de autenticação.
    *   **Tabela:** `admin_users`
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `email`: `string` (default: "", not null)
        *   `encrypted_password`: `string` (default: "", not null)
        *   `reset_password_token`: `string`
        *   `reset_password_sent_at`: `datetime`
        *   `remember_created_at`: `datetime`
        *   `created_at`: `datetime` (not null)
        *   `updated_at`: `datetime` (not null)
        *   `role`: `integer`
    *   **Relacionamentos:** Nenhum explícito no modelo, mas é um usuário do Devise.
    *   **Validações:**
        *   `email`: `presence: true`, `uniqueness: true`, `format: { with: URI::MailTo::EMAIL_REGEXP }`
        *   `role`: `presence: true`
    *   **Enums:**
        *   `role`: `admin: 0`, `super_admin: 1`

    ### AssessCampaign

    *   **Descrição:** Campanhas de avaliação ou promoção de produtos.
    *   **Tabela:** `assess_campaigns`
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `product_id`: `integer` (FK, not null)
        *   `title`: `string`
        *   `code`: `string`
        *   `owner_id`: `integer` (FK, not null)
        *   `goal`: `integer`
        *   `achieved`: `integer`
        *   `shares`: `integer`
        *   `prize`: `string`
        *   `starts_at`: `date`
        *   `ends_at`: `date`
        *   `debutantes`: `integer`
        *   `created_at`: `datetime` (not null)
        *   `updated_at`: `datetime` (not null)
        *   `status`: `string`
    *   **Relacionamentos:**
        *   `belongs_to :product`
        *   `belongs_to :owner, class_name: 'User'`
    *   **Validações:**
        *   `title`, `code`, `goal`, `starts_at`, `ends_at`, `status`: `presence: true`
        *   `goal`: `numericality: { greater_than: 0 }`
        *   `ends_at`: `cannot be before starts_at`
    *   **Enums:**
        *   `status`: `draft: 0`, `active: 1`, `completed: 2`, `cancelled: 3`
    *   **Escopos:**
        *   `ongoing`: Campanhas ativas no período atual.
        *   `completed`: Campanhas com data de término no passado.

    ### Category

    *   **Descrição:** Categorias para organizar produtos ou discussões, com suporte a hierarquia.
    *   **Tabela:** `categories`
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `name`: `string`
        *   `slug`: `string`
        *   `description`: `text`
        *   `parent_id`: `integer` (FK, opcional)
        *   `active`: `boolean`
        *   `created_at`: `datetime` (not null)
        *   `updated_at`: `datetime` (not null)
        *   `seo_title`: `string`
        *   `seo_description`: `text`
        *   `seo_keywords`: `string`
        *   `canonical_url`: `string`
        *   `meta_robots`: `string`
        *   `h1`: `string`
        *   `intro_text`: `text`
        *   `schema_markup`: `text`
    *   **Relacionamentos:**
        *   `belongs_to :parent, class_name: 'Category', optional: true`
        *   `has_many :children, class_name: 'Category', foreign_key: :parent_id, dependent: :nullify`
        *   `has_and_belongs_to_many :products` (via `categories_products` join table)
        *   `has_one_attached :seo_image`
    *   **Validações:**
        *   `name`: `presence: true`
        *   `slug`: `presence: true`, `uniqueness: { scope: :parent_id, message: 'must be unique within its level' }`
    *   **Callbacks:**
        *   `before_validation :generate_slug, on: :create`

    ### Certification

    *   **Descrição:** Certificações obtidas por empresas.
    *   **Tabela:** `certifications`
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `company_id`: `integer` (FK, not null)
        *   `name`: `string`
        *   `issued_by`: `string`
        *   `issued_at`: `date`
        *   `expires_at`: `date`
        *   `created_at`: `datetime` (not null)
        *   `updated_at`: `datetime` (not null)
    *   **Relacionamentos:**
        *   `belongs_to :company`
    *   **Validações:**
        *   `name`, `issued_by`, `issued_at`, `expires_at`: `presence: true`
        *   `issued_at`: `must be before expires_at`

    ### Comment

    *   **Descrição:** Comentários em posts.
    *   **Tabela:** `comments`
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `post_id`: `integer` (FK, not null)
        *   `user_id`: `integer` (FK, not null)
        *   `created_at`: `datetime` (not null)
        *   `updated_at`: `datetime` (not null)
        *   `status`: `integer`
    *   **Relacionamentos:**
        *   `belongs_to :post`
        *   `belongs_to :user`
        *   `has_rich_text :body`
        *   `has_noticed_notifications model_name: 'Noticed::Event'`
        *   `has_many :notification_mentions, as: :record, dependent: :destroy, class_name: 'Noticed::Event'`
    *   **Validações:**
        *   `body`: `presence: true`, `length: { minimum: 5 }`
        *   `no_curse_words`: Valida se o corpo não contém palavras proibidas.
    *   **Enums:**
        *   `status`: `pending: 0`, `approved: 1`, `rejected: 2`
    *   **Callbacks:**
        *   `after_create_commit :notify_recipient`
        *   `before_destroy :cleanup_notifications`
        *   `before_create :set_default_status`

    ### Company

    *   **Descrição:** Informações sobre empresas, incluindo dados de energia solar.
    *   **Tabela:** `companies`
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `name`: `string`
        *   `description`: `text`
        *   `user_id`: `integer` (FK, not null)
        *   `verified`: `boolean`
        *   `target_segment`: `integer`
        *   `annual_energy_output`: `decimal`
        *   `installation_count`: `integer`
        *   `created_at`: `datetime` (not null)
        *   `updated_at`: `datetime` (not null)
        *   `location`: `string`
    *   **Relacionamentos:**
        *   `has_one_attached :logo`
        *   `belongs_to :user`
        *   `has_many :certifications, dependent: :destroy`
        *   `has_many :reviews, dependent: :destroy`
        *   `has_many :quotes, dependent: :destroy`
    *   **Validações:**
        *   `name`, `description`, `location`, `target_segment`: `presence: true`
    *   **Enums:**
        *   `target_segment`: `residential: 0`, `commercial: 1`, `industrial: 2`, `public_sector: 3`

    ### Content

    *   **Descrição:** Conteúdo diverso, como artigos, vídeos, etc.
    *   **Tabela:** `contents`
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `title`: `string`
        *   `short_description`: `string`
        *   `tags`: `string`
        *   `lp_url`: `string`
        *   `format`: `string`
        *   `level`: `string`
        *   `active`: `boolean`
        *   `created_at`: `datetime` (not null)
        *   `updated_at`: `datetime` (not null)
    *   **Relacionamentos:** Nenhum explícito.
    *   **Validações:**
        *   `title`, `short_description`, `format`, `level`: `presence: true`
        *   `format`: `inclusion: { in: %w[article video infographic podcast] }`
        *   `level`: `inclusion: { in: %w[beginner intermediate advanced] }`
    *   **Escopos:**
        *   `published`: Conteúdos ativos.

    ### Discussion

    *   **Descrição:** Fóruns de discussão ou tópicos.
    *   **Tabela:** `discussions`
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `user_id`: `integer` (FK, not null)
        *   `product_id`: `integer` (FK, not null)
        *   `category_id`: `integer` (FK, not null)
        *   `subject`: `string`
        *   `body`: `text`
        *   `status`: `integer`
        *   `created_at`: `datetime` (not null)
        *   `updated_at`: `datetime` (not null)
    *   **Relacionamentos:**
        *   `belongs_to :user`
        *   `belongs_to :product`
        *   `belongs_to :category`
    *   **Validações:**
        *   `subject`: `presence: true`, `length: { minimum: 5 }`
        *   `body`: `presence: true`, `length: { minimum: 10 }`
        *   `status`: `presence: true`
    *   **Enums:**
        *   `status`: `open: 0`, `closed: 1`, `archived: 2`
    *   **Escopos:**
        *   `recent`: Discussões mais recentes.

    ### Feature

    *   **Descrição:** Características ou funcionalidades de um produto, agrupadas por `FeatureGroup`.
    *   **Tabela:** `features`
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `name`: `string`
        *   `feature_group_id`: `integer` (FK, not null)
        *   `created_at`: `datetime` (not null)
        *   `updated_at`: `datetime` (not null)
    *   **Relacionamentos:**
        *   `belongs_to :feature_group`
    *   **Validações:**
        *   `name`: `presence: true`, `uniqueness: { scope: :feature_group_id }`

    ### FeatureGroup

    *   **Descrição:** Grupos de características ou funcionalidades.
    *   **Tabela:** `feature_groups`
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `name`: `string`
        *   `created_at`: `datetime` (not null)
        *   `updated_at`: `datetime` (not null)
    *   **Relacionamentos:**
        *   `has_many :features, dependent: :destroy`
    *   **Validações:**
        *   `name`: `presence: true`, `uniqueness: true`

    ### Lead

    *   **Descrição:** Leads gerados para produtos.
    *   **Tabela:** `leads`
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `user_id`: `integer` (FK, not null)
        *   `product_id`: `integer` (FK, not null)
        *   `name`: `string`
        *   `email`: `string`
        *   `role`: `string`
        *   `company_size`: `string`
        *   `desired_category`: `string`
        *   `funnel_stage`: `string`
        *   `score`: `integer`
        *   `sent_at`: `date`
        *   `created_at`: `datetime` (not null)
        *   `updated_at`: `datetime` (not null)
    *   **Relacionamentos:**
        *   `belongs_to :user`
        *   `belongs_to :product`
    *   **Validações:**
        *   `name`, `email`, `role`, `conversion_state`: `presence: true`
        *   `email`: `format: { with: URI::MailTo::EMAIL_REGEXP }`
    *   **Enums:**
        *   `conversion_state`: `new_lead: 0`, `contacted: 1`, `qualified: 2`, `unqualified: 3`, `converted: 4`
    *   **Escopos:**
        *   `qualified`: Leads qualificados.
    *   **Métodos:**
        *   `convert!`: Marca o lead como convertido.
        *   `full_name`: Retorna o nome completo do lead.

    ### MarketingCampaign

    *   **Descrição:** Campanhas de marketing.
    *   **Tabela:** `marketing_campaigns`
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `name`: `string`
        *   `channel`: `integer`
        *   `template`: `text`
        *   `scheduled_at`: `datetime`
        *   `created_at`: `datetime` (not null)
        *   `updated_at`: `datetime` (not null)
    *   **Relacionamentos:** Nenhum explícito.
    *   **Validações:**
        *   `name`, `channel`, `template`, `scheduled_at`: `presence: true`
        *   `scheduled_at`: `must be in the future`
    *   **Enums:**
        *   `channel`: `email: 0`, `sms: 1`, `push: 2`
    *   **Escopos:**
        *   `upcoming`: Campanhas futuras.
        *   `past`: Campanhas passadas.

    ### Post

    *   **Descrição:** Posts de blog ou artigos.
    *   **Tabela:** `posts`
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `title`: `string`
        *   `body`: `text`
        *   `created_at`: `datetime` (not null)
        *   `updated_at`: `datetime` (not null)
        *   `views`: `integer` (default: 0)
        *   `user_id`: `integer` (FK, not null)
        *   `published_at`: `datetime`
    *   **Relacionamentos:**
        *   `belongs_to :user` (autor do post)
        *   `has_many :comments, dependent: :destroy`
        *   `has_many :notifications, through: :user, dependent: :destroy`
        *   `has_many :notification_mentions, through: :user, dependent: :destroy`
        *   `has_noticed_notifications model_name: 'Noticed::Notification'`
    *   **Validações:**
        *   `title`: `presence: true`, `length: { minimum: 5, maximum: 50 }`
        *   `body`: `presence: true`, `length: { minimum: 10, maximum: 1000 }`
        *   `no_curse_words`: Valida se o título e o corpo não contêm palavras proibidas.
    *   **Escopos:**
        *   `published`: Posts publicados.
        *   `draft`: Posts em rascunho.

    ### Pricing

    *   **Descrição:** Informações de precificação para produtos.
    *   **Tabela:** `pricings`
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `product_id`: `integer` (FK, not null)
        *   `title`: `string`
        *   `currency`: `string`
        *   `value`: `decimal`
        *   `charge_type`: `string`
        *   `frequency`: `string`
        *   `payment_methods`: `text`
        *   `position`: `integer`
        *   `state`: `string`
        *   `created_at`: `datetime` (not null)
        *   `updated_at`: `datetime` (not null)
    *   **Relacionamentos:**
        *   `belongs_to :product`
    *   **Validações:**
        *   `title`, `currency`, `value`, `charge_type`, `frequency`: `presence: true`
        *   `value`: `numericality: { greater_than_or_equal_to: 0.01 }`
    *   **Escopos:**
        *   `active`: Precificações ativas.
        *   `by_currency`: Precificações por moeda.

    ### PricingRule

    *   **Descrição:** Regras de precificação para aplicar descontos.
    *   **Tabela:** `pricing_rules`
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `name`: `string`
        *   `condition`: `text`
        *   `discount_pct`: `decimal`
        *   `created_at`: `datetime` (not null)
        *   `updated_at`: `datetime` (not null)
    *   **Relacionamentos:** Nenhum explícito.
    *   **Validações:**
        *   `name`, `condition`, `discount_pct`: `presence: true`
        *   `discount_pct`: `numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }`
        *   `condition`: `format` (regex para caracteres válidos)

    ### Product

    *   **Descrição:** Produtos oferecidos no sistema.
    *   **Tabela:** `products`
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `name`: `string`
        *   `seo_url`: `string`
        *   `seo_title`: `string`
        *   `status`: `string`
        *   `kind`: `string`
        *   `premium_until`: `date`
        *   `source`: `string`
        *   `country`: `string`
        *   `created_at`: `datetime` (not null)
        *   `updated_at`: `datetime` (not null)
    *   **Relacionamentos:**
        *   `has_and_belongs_to_many :categories` (via `categories_products` join table)
        *   `has_many :pricings`
        *   `has_many :assess_campaigns`
        *   `has_many :leads`
        *   `has_many :discussions`
    *   **Validações:** (Não há validações explícitas no modelo fornecido, mas geralmente teriam `presence: true` para `name` e `status`.)

    ### Quote

    *   **Descrição:** Solicitações de orçamento de clientes para empresas.
    *   **Tabela:** `quotes`
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `name`: `string`
        *   `email`: `string`
        *   `phone`: `string`
        *   `message`: `text`
        *   `company_id`: `integer` (FK, not null)
        *   `status`: `integer`
        *   `estimated_kwh`: `decimal`
        *   `created_at`: `datetime` (not null)
        *   `updated_at`: `datetime` (not null)
    *   **Relacionamentos:**
        *   `belongs_to :company`
        *   `belongs_to :user, optional: true`
    *   **Validações:**
        *   `name`, `email`, `phone`, `message`: `presence: true`
    *   **Enums:**
        *   `status`: `pending: 0`, `responded: 1`, `closed: 2`

    ### Reply

    *   **Descrição:** Respostas a discussões.
    *   **Tabela:** `replies`
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `user_id`: `integer` (FK, not null)
        *   `discussion_id`: `integer` (FK, not null)
        *   `body`: `text`
        *   `status`: `integer`
        *   `created_at`: `datetime` (not null)
        *   `updated_at`: `datetime` (not null)
    *   **Relacionamentos:**
        *   `belongs_to :user`
        *   `belongs_to :discussion`
    *   **Validações:**
        *   `body`: `presence: true`, `length: { minimum: 5 }`
    *   **Enums:**
        *   `status`: `pending: 0`, `approved: 1`, `rejected: 2`

    ### Review

    *   **Descrição:** Avaliações de empresas por usuários.
    *   **Tabela:** `reviews`
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `user_id`: `integer` (FK, not null)
        *   `company_id`: `integer` (FK, not null)
        *   `rating`: `integer`
        *   `title`: `string`
        *   `content`: `text`
        *   `status`: `integer`
        *   `cliente`: `boolean`
        *   `created_at`: `datetime` (not null)
        *   `updated_at`: `datetime` (not null)
    *   **Relacionamentos:**
        *   `belongs_to :user`
        *   `belongs_to :company`
    *   **Validações:**
        *   `rating`: `inclusion: { in: 1..5 }`
        *   `title`, `content`: `presence: true`
    *   **Enums:**
        *   `status`: `pending: 0`, `approved: 1`, `rejected: 2`
    *   **Escopos:**
        *   `top_rated`: Avaliações com 4 ou 5 estrelas.

    ### SaasLead

    *   **Descrição:** Leads específicos para produtos SaaS.
    *   **Tabela:** `saa_s_leads`
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `first_name`: `string` (not null)
        *   `last_name`: `string` (not null)
        *   `email`: `string` (not null)
        *   `phone_number`: `string`
        *   `preferred_contact_time`: `string`
        *   `contact_method`: `string`
        *   `company_name`: `string`
        *   `building_type`: `string`
        *   `roof_type`: `string`
        *   `available_roof_area`: `decimal` (precision: 8, scale: 2)
        *   `address`: `string`
        *   `city`: `string`
        *   `state`: `string`
        *   `monthly_energy_consumption_kwh`: `integer`
        *   `budget_range`: `string`
        *   `decision_timeline`: `string`
        *   `current_energy_provider`: `string`
        *   `score`: `integer` (default: 0)
        *   `status`: `integer` (default: 0, not null)
        *   `pain_points`: `text`
        *   `competitor_considered`: `string`
        *   `lead_source`: `string`
        *   `utm_campaign`: `string`
        *   `utm_source`: `string`
        *   `utm_medium`: `string`
        *   `saas_plan_id`: `integer` (FK)
        *   `b2b`: `boolean` (default: false)
        *   `funnel_stage`: `string`
        *   `site_visit_scheduled`: `boolean` (default: false)
        *   `site_visit_date`: `datetime`
        *   `converted_at`: `datetime`
        *   `proposal_sent_at`: `datetime`
        *   `follow_up_date`: `datetime`
        *   `created_at`: `datetime` (not null)
        *   `updated_at`: `datetime` (not null)
    *   **Relacionamentos:**
        *   `belongs_to :user`
        *   `belongs_to :saas_product`
        *   `belongs_to :saas_plan, optional: true`
    *   **Validações:**
        *   `first_name`, `last_name`, `email`, `phone`, `status`: `presence: true`
        *   `email`: `format: { with: URI::MailTo::EMAIL_REGEXP }`
        *   `contacted_at`: `presence: true` (se o status for `contacted`, `qualified`, `unqualified` ou `converted`)
    *   **Enums:**
        *   `status`: `new_lead: 0`, `contacted: 1`, `proposal_sent: 2`, `won: 3`, `lost: 4`
    *   **Escopos:**
        *   `recent_leads`: Últimos 10 leads.

    ### SaasPlan

    *   **Descrição:** Planos de assinatura para produtos SaaS.
    *   **Tabela:** `saa_s_plans`
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `name`: `string`
        *   `saas_product_id`: `integer` (FK, not null)
        *   `tier`: `integer`
        *   `features`: `text`
        *   `price`: `decimal`
        *   `active`: `boolean`
        *   `created_at`: `datetime` (not null)
        *   `updated_at`: `datetime` (not null)
    *   **Relacionamentos:**
        *   `belongs_to :saas_product`
    *   **Validações:**
        *   `name`, `price`, `tier`: `presence: true`
        *   `price`: `numericality: { greater_than_or_equal_to: 0.01 }`
        *   `features`: `must be a valid JSON string`
    *   **Enums:**
        *   `tier`: `basic: 0`, `standard: 1`, `premium: 2`
    *   **Escopos:**
        *   `by_tier`: Planos por nível.

    ### SaasProduct

    *   **Descrição:** Produtos de Software como Serviço (SaaS).
    *   **Tabela:** `saa_s_products`
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `name`: `string`
        *   `description`: `text`
        *   `price`: `decimal`
        *   `billing_cycle`: `string`
        *   `features`: `text`
        *   `active`: `boolean`
        *   `created_at`: `datetime` (not null)
        *   `updated_at`: `datetime` (not null)
        *   `status`: `string`
    *   **Relacionamentos:**
        *   `has_many :saas_plans`
        *   `has_many :saas_leads`
    *   **Validações:**
        *   `name`, `description`, `price`, `billing_cycle`: `presence: true`
        *   `price`: `numericality: { greater_than_or_equal_to: 0 }`
        *   `billing_cycle`: `inclusion: { in: %w[monthly annually one_time] }`
    *   **Escopos:**
        *   `active_products`: Produtos ativos.

    ### User

    *   **Descrição:** Usuários gerais do sistema, com funcionalidades de autenticação e diversas associações.
    *   **Tabela:** `users`
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `email`: `string` (default: "", not null)
        *   `encrypted_password`: `string` (default: "", not null)
        *   `reset_password_token`: `string`
        *   `reset_password_sent_at`: `datetime`
        *   `remember_created_at`: `datetime`
        *   `created_at`: `datetime` (not null)
        *   `updated_at`: `datetime` (not null)
        *   `name`: `string`
        *   `views`: `integer` (default: 0)
        *   `role`: `integer`
    *   **Relacionamentos:**
        *   `has_many :posts, dependent: :destroy`
        *   `has_many :comments, dependent: :destroy`
        *   `has_many :reviews, dependent: :destroy`
        *   `has_many :quotes, dependent: :destroy`
        *   `has_many :leads, dependent: :destroy`
        *   `has_many :saas_leads, dependent: :destroy`
        *   `has_many :notifications, as: :recipient, dependent: :destroy, class_name: 'Noticed::Notification'`
        *   `has_many :notification_mentions, as: :record, dependent: :destroy, class_name: 'Noticed::Event'`
    *   **Validações:**
        *   `email`: `uniqueness: { case_sensitive: false }`
        *   `role`: `presence: true`
    *   **Enums:**
        *   `role`: `admin: 0`, `editor: 1`

    ---

    ## Tabelas de Junção (Join Tables)

    ### categories_products

    *   **Descrição:** Tabela de junção para o relacionamento muitos-para-muitos entre `Category` e `Product`.
    *   **Atributos:**
        *   `category_id`: `integer` (FK, not null)
        *   `product_id`: `integer` (FK, not null)
    *   **Índices:**
        *   `index_categories_products_on_category_and_product` (unique: true)
        *   `index_categories_products_on_product_and_category`

    ---

    ## Tabelas de Suporte do Rails/Gemas

    ### action_text_rich_texts

    *   **Descrição:** Armazena conteúdo de texto rico (rich text) para o Action Text.
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `name`: `string` (not null)
        *   `body`: `text`
        *   `record_type`: `string` (not null)
        *   `record_id`: `bigint` (not null)
        *   `created_at`: `datetime` (not null)
        *   `updated_at`: `datetime` (not null)

    ### active_admin_comments

    *   **Descrição:** Comentários internos do Active Admin.
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `namespace`: `string`
        *   `body`: `text`
        *   `resource_type`: `string`
        *   `resource_id`: `integer`
        *   `author_type`: `string`
        *   `author_id`: `integer`
        *   `created_at`: `datetime` (not null)
        *   `updated_at`: `datetime` (not null)

    ### active_storage_attachments

    *   **Descrição:** Anexos de arquivos gerenciados pelo Active Storage.
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `name`: `string` (not null)
        *   `record_type`: `string` (not null)
        *   `record_id`: `bigint` (not null)
        *   `blob_id`: `bigint` (FK, not null)
        *   `created_at`: `datetime` (not null)

    ### active_storage_blobs

    *   **Descrição:** Metadados de arquivos armazenados pelo Active Storage.
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `key`: `string` (not null)
        *   `filename`: `string` (not null)
        *   `content_type`: `string`
        *   `metadata`: `text`
        *   `service_name`: `string` (not null)
        *   `byte_size`: `integer` (not null)
        *   `checksum`: `string`
        *   `created_at`: `datetime` (not null)

    ### active_storage_variant_records

    *   **Descrição:** Registros de variantes de imagens para Active Storage.
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `blob_id`: `bigint` (FK, not null)
        *   `variation_digest`: `string` (not null)

    ### friendly_id_slugs

    *   **Descrição:** Armazena slugs para o FriendlyId, permitindo URLs amigáveis e históricos.
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `slug`: `string` (not null)
        *   `sluggable_id`: `integer` (not null)
        *   `sluggable_type`: `string` (limit: 50)
        *   `scope`: `string`
        *   `created_at`: `datetime`

    ### noticed_events

    *   **Descrição:** Eventos de notificação gerados pela gem Noticed.
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `type`: `string`
        *   `record_type`: `string`
        *   `record_id`: `bigint`
        *   `params`: `json`
        *   `created_at`: `datetime` (not null)
        *   `updated_at`: `datetime` (not null)
        *   `notifications_count`: `integer`

    ### noticed_notifications

    *   **Descrição:** Notificações individuais para destinatários, geradas pela gem Noticed.
    *   **Atributos:**
        *   `id`: `integer` (PK)
        *   `type`: `string`
        *   `event_id`: `bigint` (FK, not null)
        *   `recipient_type`: `string` (not null)
        *   `recipient_id`: `bigint` (not null)
        *   `read_at`: `datetime`
        *   `seen_at`: `datetime`
        *   `created_at`: `datetime` (not null)
        *   `updated_at`: `datetime` (not null)

    ---

    ## Concerns (Módulos Reutilizáveis)

    ### Auditable

    *   **Descrição:** Módulo para adicionar lógica de auditoria aos modelos.
    *   **Funcionalidade:**
        *   `before_save :log_changes`: Um callback que é executado antes de salvar um registro, com um placeholder para a lógica de log de mudanças.
    *   **Uso:** Incluído em `ApplicationRecord`, o que significa que todos os modelos que herdam de `ApplicationRecord` terão essa funcionalidade.

    ---
