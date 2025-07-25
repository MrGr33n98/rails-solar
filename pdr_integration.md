# PDR Integration Guide

This document outlines the steps to integrate the Rails API with a Next.js front‑end.

## 1. Setup Ruby/Rails dependencies

1. Install Ruby 3.2 and Bundler.
2. Install gems:
   ```bash
   bundle install
   ```
3. Prepare the database:
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed   # loads demo data
   ```

## 2. Start the Rails API

Run the development server:
```bash
rails server
```
The API will be accessible at `http://localhost:3000`.

## 3. Create or connect a Next.js app

You can generate a new Next.js project:
```bash
npx create-next-app frontend
```
Inside the front‑end project, configure the API base URL (e.g. in `.env.local`):
```
NEXT_PUBLIC_API_BASE_URL=http://localhost:3000/api/v1
```
Use this variable when fetching data from the Rails API.

If CORS errors occur, add a `rack-cors` initializer in `config/initializers`:
```ruby
# config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'localhost:3000', 'http://localhost:3001'
    resource '*', headers: :any, methods: [:get, :post, :options]
  end
end
```
Restart the server after editing this file.

## 4. Verify demo data

After seeding, confirm the API returns the sample records:
```bash
curl http://localhost:3000/api/v1/companies    # expect 5 companies
curl http://localhost:3000/api/v1/categories   # expect 10 categories
```
If the correct counts are returned, the integration is working.
