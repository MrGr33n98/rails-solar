user1 = User.find_or_create_by!(email: 'test1@test.com') do |u|
  u.name = 'test1'
  u.password = 'password'
  u.password_confirmation = 'password'
  u.role = 'admin'
end

user2 = User.find_or_create_by!(email: 'test2@test.com') do |u|
  u.name = 'test2'
  u.password = 'password'
  u.password_confirmation = 'password'
  u.role = 'editor'
end

3.times do |i|
  post1 = Post.create(title: "Title #{i}", body: "Body #{i} words goes here idk...", user_id: user1.id)
  post2 = Post.create(title: "Title #{i}", body: "Body #{i} words goes here idk...", user_id: user2.id)

  3.times do |_j|
    Comment.create(post_id: post1.id, user_id: user2.id, body: "Comment body for Post #{post1.id} by User #{user2.id}")
    Comment.create(post_id: post2.id, user_id: user1.id, body: "Comment body for Post #{post2.id} by User #{user1.id}")
  end
end

if Rails.env.development?
  AdminUser.find_or_create_by!(email: "admin@example.com") do |user|
    user.password = "password"
    user.role = "admin"
  end
end

# Seeds para categorias principais do portal B2B de energia solar
categories = [
  {
    name: "Placas Solares",
    slug: "placas-solares",
    description: "Fornecimento e instalação de módulos fotovoltaicos monocristalinos e policristalinos.",
    parent_id: nil,
    active: true,
    depth: 1,
    seo_title: "Placas Solares – Módulos Fotovoltaicos para Empresas",
    seo_description: "Conheça nossas placas solares de alta eficiência para projetos comerciais e industriais.",
    seo_keywords: "placas solares, módulos fotovoltaicos, energia solar industrial",
    canonical_url: "/placas-solares",
    meta_robots: "index, follow",
    h1: "Placas Solares",
    intro_text: "Soluções em módulos fotovoltaicos para demandas empresariais de todos os portes.",
    schema_markup: '{"@context": "https://schema.org", "@type": "ProductCategory", "name": "Placas Solares", "url": "https://www.seusite.com/placas-solares"}'
  },
  {
    name: "Inversores Fotovoltaicos",
    slug: "inversores-fotovoltaicos",
    description: "Equipamentos que convertem energia DC em AC para rede ou uso local.",
    parent_id: nil,
    active: true,
    depth: 1,
    seo_title: "Inversores Fotovoltaicos – Inversão de Energia Solar",
    seo_description: "Inversores string, centrais e microinversores com tecnologia de ponta para empresas.",
    seo_keywords: "inversores solares, microinversores, string inverters",
    canonical_url: "/inversores-fotovoltaicos",
    meta_robots: "index, follow",
    h1: "Inversores Fotovoltaicos",
    intro_text: "Garanta máxima eficiência na conversão de energia solar com nossos inversores.",
    schema_markup: '{"@context": "https://schema.org", "@type": "ProductCategory", "name": "Inversores Fotovoltaicos", "url": "https://www.seusite.com/inversores-fotovoltaicos"}'
  },
  {
    name: "Estruturas de Fixação",
    slug: "estruturas-fixacao",
    description: "Sistemas de montagem em telhados, solo e estruturas especiais.",
    parent_id: nil,
    active: true,
    depth: 1,
    seo_title: "Estruturas de Fixação – Montagem de Painéis Solares",
    seo_description: "Perfis, trilhos e suportes para instalar placas solares em qualquer tipo de cobertura.",
    seo_keywords: "montagem solar, estruturas fixação, racks solares",
    canonical_url: "/estruturas-fixacao",
    meta_robots: "index, follow",
    h1: "Estruturas de Fixação",
    intro_text: "Soluções robustas para instalação segura de sistemas fotovoltaicos.",
    schema_markup: '{"@context": "https://schema.org", "@type": "ProductCategory", "name": "Estruturas de Fixação", "url": "https://www.seusite.com/estruturas-fixacao"}'
  },
  {
    name: "Bancos de Bateria",
    slug: "bancos-de-bateria",
    description: "Sistemas de armazenamento de energia com baterias de íon‑lítio e chumbo.",
    parent_id: nil,
    active: true,
    depth: 1,
    seo_title: "Bancos de Bateria – Armazenamento de Energia Solar",
    seo_description: "Garanta autonomia e backup com soluções de baterias para grandes instalações.",
    seo_keywords: "baterias solares, armazenamento energia, banco de baterias",
    canonical_url: "/bancos-de-bateria",
    meta_robots: "index, follow",
    h1: "Bancos de Bateria",
    intro_text: "Tecnologia de ponta para estocar e gerenciar energia fotovoltaica.",
    schema_markup: '{"@context": "https://schema.org", "@type": "ProductCategory", "name": "Bancos de Bateria", "url": "https://www.seusite.com/bancos-de-bateria"}'
  },
  {
    name: "Sistemas Off‑Grid",
    slug: "sistemas-off-grid",
    description: "Soluções independentes da rede elétrica para áreas remotas.",
    parent_id: nil,
    active: true,
    depth: 1,
    seo_title: "Sistemas Off‑Grid – Energia Solar Isolada",
    seo_description: "Projetos completos off‑grid com geração, armazenamento e controle para empresas.",
    seo_keywords: "off-grid solar, sistemas isolados, energia remota",
    canonical_url: "/sistemas-off-grid",
    meta_robots: "index, follow",
    h1: "Sistemas Off‑Grid",
    intro_text: "Autonomia total em locais sem acesso à rede convencional.",
    schema_markup: '{"@context": "https://schema.org", "@type": "ProductCategory", "name": "Sistemas Off‑Grid", "url": "https://www.seusite.com/sistemas-off-grid"}'
  },
  {
    name: "Monitoramento & Software",
    slug: "monitoramento-software",
    description: "Plataformas de gestão, supervisão e análise de desempenho de usinas.",
    parent_id: nil,
    active: true,
    depth: 1,
    seo_title: "Monitoramento & Software – Gestão de Energia Solar",
    seo_description: "Ferramentas em tempo real para acompanhar produtividade e manutenção preditiva.",
    seo_keywords: "monitoramento solar, software fotovoltaico, SCADA solar",
    canonical_url: "/monitoramento-software",
    meta_robots: "index, follow",
    h1: "Monitoramento & Software",
    intro_text: "Controle e otimize sua planta fotovoltaica via dashboards inteligentes.",
    schema_markup: '{"@context": "https://schema.org", "@type": "ProductCategory", "name": "Monitoramento & Software", "url": "https://www.seusite.com/monitoramento-software"}'
  },
  {
    name: "Serviços de Instalação (EPC)",
    slug: "servicos-instalacao-epc",
    description: "Engenharia, suprimento e construção turnkey para projetos solares.",
    parent_id: nil,
    active: true,
    depth: 1,
    seo_title: "Serviços de Instalação EPC – Turnkey Solar",
    seo_description: "Equipe completa para entrega de usinas fotovoltaicas “chave na mão”.",
    seo_keywords: "EPC solar, engenharia solar, construção usina",
    canonical_url: "/servicos-instalacao-epc",
    meta_robots: "index, follow",
    h1: "Serviços de Instalação (EPC)",
    intro_text: "Projetos fotovoltaicos integrados do design à operação.",
    schema_markup: '{"@context": "https://schema.org", "@type": "Service", "name": "Serviços de Instalação EPC", "url": "https://www.seusite.com/servicos-instalacao-epc"}'
  },
  {
    name: "Projetos & Consultoria",
    slug: "projetos-consultoria",
    description: "Assessoria técnica, estudos de viabilidade e modelagem financeira.",
    parent_id: nil,
    active: true,
    depth: 1,
    seo_title: "Projetos & Consultoria – Viabilidade Solar",
    seo_description: "Análises de site, simulações de geração e retorno de investimento.",
    seo_keywords: "consultoria solar, viabilidade fotovoltaica, modelagem financeira",
    canonical_url: "/projetos-consultoria",
    meta_robots: "index, follow",
    h1: "Projetos & Consultoria",
    intro_text: "Expertises para garantir o sucesso de projetos solares.",
    schema_markup: '{"@context": "https://schema.org", "@type": "Service", "name": "Projetos & Consultoria", "url": "https://www.seusite.com/projetos-consultoria"}'
  },
  {
    name: "Financiamento & Leasing",
    slug: "financiamento-leasing",
    description: "Opções de crédito, leasing operacional e parcerias financeiras.",
    parent_id: nil,
    active: true,
    depth: 1,
    seo_title: "Financiamento & Leasing – Crédito Solar Empresarial",
    seo_description: "Linhas de financiamento e leasing para viabilizar projetos fotovoltaicos.",
    seo_keywords: "financiamento solar, leasing energia, crédito fotovoltaico",
    canonical_url: "/financiamento-leasing",
    meta_robots: "index, follow",
    h1: "Financiamento & Leasing",
    intro_text: "Facilite o CAPEX do seu projeto com soluções financeiras especializadas.",
    schema_markup: '{"@context": "https://schema.org", "@type": "Service", "name": "Financiamento & Leasing", "url": "https://www.seusite.com/financiamento-leasing"}'
  },
  {
    name: "Manutenção & Operação",
    slug: "manutencao-operacao",
    description: "Serviços de O&M, limpeza, inspeção termográfica e reparos.",
    parent_id: nil,
    active: true,
    depth: 1,
    seo_title: "Manutenção & Operação – O&M Solar",
    seo_description: "Planos de operação e manutenção para garantir a performance contínua.",
    seo_keywords: "manutenção solar, O&M, inspeção fotovoltaica",
    canonical_url: "/manutencao-operacao",
    meta_robots: "index, follow",
    h1: "Manutenção & Operação",
    intro_text: "Programas completos de O&M para sua usina solar.",
    schema_markup: '{"@context": "https://schema.org", "@type": "Service", "name": "Manutenção & Operação", "url": "https://www.seusite.com/manutencao-operacao"}'
  },
  {
    name: "Energia Solar Comercial",
    slug: "energia-solar-comercial",
    description: "Sistemas fotovoltaicos dedicados a estabelecimentos comerciais.",
    parent_id: nil,
    active: true,
    depth: 1,
    seo_title: "Energia Solar Comercial – Soluções para Empresas",
    seo_description: "Reduza custos operacionais com sistemas solares para comércios.",
    seo_keywords: "solar comercial, energia para empresas, custo operacional",
    canonical_url: "/energia-solar-comercial",
    meta_robots: "index, follow",
    h1: "Energia Solar Comercial",
    intro_text: "Projetos dimensionados para as necessidades de seu negócio.",
    schema_markup: '{"@context": "https://schema.org", "@type": "ProductCategory", "name": "Energia Solar Comercial", "url": "https://www.seusite.com/energia-solar-comercial"}'
  },
  {
    name: "Energia Solar Residencial",
    slug: "energia-solar-residencial",
    description: "Sistemas solares para condomínios e edifícios residenciais.",
    parent_id: nil,
    active: true,
    depth: 1,
    seo_title: "Energia Solar Residencial – Condomínios e Apartamentos",
    seo_description: "Soluções compartilhadas e individualizadas para residências.",
    seo_keywords: "solar residencial, condomínio solar, energia em casa",
    canonical_url: "/energia-solar-residencial",
    meta_robots: "index, follow",
    h1: "Energia Solar Residencial",
    intro_text: "Programa de geração distribuída para seu condomínio ou casa.",
    schema_markup: '{"@context": "https://schema.org", "@type": "ProductCategory", "name": "Energia Solar Residencial", "url": "https://www.seusite.com/energia-solar-residencial"}'
  },
  {
    name: "Sistemas Híbridos",
    slug: "sistemas-hibridos",
    description: "Combinação de geração solar com geradores a diesel ou eólicos.",
    parent_id: nil,
    active: true,
    depth: 1,
    seo_title: "Sistemas Híbridos – Solar + Backup Diesel/Eólico",
    seo_description: "Entregue energia confiável com soluções híbridas para áreas críticas.",
    seo_keywords: "sistemas híbridos, solar + diesel, solar + eólico",
    canonical_url: "/sistemas-hibridos",
    meta_robots: "index, follow",
    h1: "Sistemas Híbridos",
    intro_text: "Otimize disponibilidade com múltiplas fontes de energia.",
    schema_markup: '{"@context": "https://schema.org", "@type": "ProductCategory", "name": "Sistemas Híbridos", "url": "https://www.seusite.com/sistemas-hibridos"}'
  },
  {
    name: "Treinamento & Capacitação",
    slug: "treinamento-capacitacao",
    description: "Cursos e workshops para técnicos e engenheiros em fotovoltaica.",
    parent_id: nil,
    active: true,
    depth: 1,
    seo_title: "Treinamento & Capacitação – Cursos de Energia Solar",
    seo_description: "Capacite sua equipe com treinamentos práticos e certificações.",
    seo_keywords: "curso solar, capacitação fotovoltaica, treinamento técnico",
    canonical_url: "/treinamento-capacitacao",
    meta_robots: "index, follow",
    h1: "Treinamento & Capacitação",
    intro_text: "Aprimore habilidades em projeto, instalação e manutenção solar.",
    schema_markup: '{"@context": "https://schema.org", "@type": "Course", "name": "Treinamento & Capacitação", "url": "https://www.seusite.com/treinamento-capacitacao"}'
  },
  {
    name: "Peças & Componentes",
    slug: "pecas-componentes",
    description: "Conectores MC4, cabos, fusíveis, caixas de junção e acessórios.",
    parent_id: nil,
    active: true,
    depth: 1,
    seo_title: "Peças & Componentes – Acessórios para Sistema Solar",
    seo_description: "Tudo em acessórios para montagem e segurança de instalações fotovoltaicas.",
    seo_keywords: "conectores solares, cabos fotovoltaicos, componentes solares",
    canonical_url: "/pecas-componentes",
    meta_robots: "index, follow",
    h1: "Peças & Componentes",
    intro_text: "Itens essenciais para completar seu sistema solar com qualidade.",
    schema_markup: '{"@context": "https://schema.org", "@type": "ProductCategory", "name": "Peças & Componentes", "url": "https://www.seusite.com/pecas-componentes"}'
  }
]

categories.each do |attrs|
  Category.create!(attrs)
end

Category.create!(
  name: "Placas Solares",
  slug: "placas-solares",
  description: "Fornecimento e instalação de módulos fotovoltaicos monocristalinos e policristalinos.",
  parent_id: nil,
  active: true,
  depth: 1,
  seo_title: "Placas Solares – Módulos Fotovoltaicos para Empresas",
  seo_description: "Conheça nossas placas solares de alta eficiência para projetos comerciais e industriais.",
  seo_keywords: "placas solares, módulos fotovoltaicos, energia solar industrial",
  canonical_url: "/placas-solares",
  meta_robots: "index, follow",
  h1: "Placas Solares",
  intro_text: "Soluções em módulos fotovoltaicos para demandas empresariais de todos os portes.",
  schema_markup: '{"@context": "https://schema.org", "@type": "ProductCategory", "name": "Placas Solares", "url": "https://www.seusite.com/placas-solares"}'
  # O campo seo_image deve ser anexado manualmente pelo ActiveAdmin
)