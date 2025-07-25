user1 = User.create(email: 'test1@test.com', name: 'test1', password: 'password', password_confirmation: 'password', role: :editor)
user2 = User.create(email: 'test2@test.com', name: 'test2', password: 'password', password_confirmation: 'password', role: :editor)

3.times do |i|
  post1 = Post.create(title: "Title #{i}", body: "Body #{i} words goes here idk...", user_id: user1.id)
  post2 = Post.create(title: "Title #{i}", body: "Body #{i} words goes here idk...", user_id: user2.id)

  3.times do |_j|
    Comment.create(post_id: post1.id, user_id: user2.id, body: "Comment body for Post #{post1.id} by User #{user2.id}")
    Comment.create(post_id: post2.id, user_id: user1.id, body: "Comment body for Post #{post2.id} by User #{user1.id}")
  end
end

# Create some categories with a simple parent/child hierarchy
tech = Category.create!(name: 'Solar Technology')
%w[Panels Inverters Batteries 'Mounting Systems'].each do |child_name|
  Category.create!(name: child_name, parent: tech)
end

services = Category.create!(name: 'Services')
%w[Installation Maintenance Consulting Financing Monitoring].each do |child_name|
  Category.create!(name: child_name, parent: services)
end

# Create five companies tied to the users created above
5.times do |i|
  owner = i.even? ? user1 : user2
  Company.create!(
    name: "Company #{i + 1}",
    description: "Demo company number #{i + 1}",
    location: "City #{i + 1}",
    target_segment: Company.target_segments.keys.sample,
    user: owner,
    verified: [true, false].sample,
    annual_energy_output: rand(500..1500),
    installation_count: rand(10..100)
  )
end

if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', role: :admin)
end
