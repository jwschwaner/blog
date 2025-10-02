# Personal Blog (Next.js + TypeScript + Gluestack + Supabase)

A single-user personal blog built from scratch. The goal is full ownership over the stack and content, with a simple, fast authoring workflow and an admin-only UI.

## Tech Stack
- Framework: Next.js (App Router)
- Language: TypeScript
- UI: Gluestack
- Auth & DB: Supabase (PostgreSQL + Auth)
- Styling: Tailwind CSS (planned) or Gluestack styling primitives
- Deployment: Vercel or any Node-capable host (planned)

## Core Requirements
- Single user (admin = you). No multi-tenant blog support.
- Create article feature (title, slug, content, cover image [optional], published flag, timestamps)
- Tags feature (many-to-many with articles)
- Category feature (one category per article)
- Basic public pages: Home (list), Article detail, Category page, Tag page
- Admin-only pages: Create/Edit Article, Manage Tags & Categories

## Planned Data Model (initial)
- Article: id, title, slug, content, cover_image_url, published, category_id, created_at, updated_at
- Category: id, name, slug
- Tag: id, name, slug
- ArticleTag: article_id, tag_id (junction)

## High-Level Architecture
- Next.js App Router with server components where possible
- Supabase client for server-side data access (RLS policies to restrict writes to admin)
- Minimal API routes for admin actions (if needed), else direct server actions
- Gluestack for UI primitives and layout primitives

## MVP Milestones
1) Scaffold Next.js + TypeScript project
2) Install and configure Gluestack
3) Set up Supabase project, tables, and RLS
4) Implement public pages (home list, article detail)
5) Implement admin auth (Supabase) and basic admin pages (create/edit)
6) Add tags and category relationships to UI and queries

## Local Setup (to do next)
- Create Next.js app with TypeScript
  - npx create-next-app@latest (select TypeScript)
- Install dependencies
  - gluestack, supabase-js, and any styling libs (e.g., Tailwind)
- Configure Supabase
  - Create project, set env vars locally (NEXT_PUBLIC_SUPABASE_URL, NEXT_PUBLIC_SUPABASE_ANON_KEY)
  - Create tables for Article, Category, Tag, ArticleTag
  - Add RLS policies to allow public reads and admin-only writes
- Run the dev server
  - npm run dev or pnpm dev

## Scripts (to be completed once scaffolded)
- dev: Start Next.js dev server
- build: Build production bundle
- start: Run production server
- lint/test: Linting and tests (optional for now)

## Notes
- Keep first iteration simple: server actions for admin create/update, minimal WYSIWYG (or plain Markdown) to start.
- Export content if needed later (e.g., JSON/Markdown) for portability.

## License
TBD
