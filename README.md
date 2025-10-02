# Showcase Multi‑Tenant Blog Platform (Next.js + TypeScript + Gluestack + Supabase)

A portfolio‑grade, multi‑tenant blogging platform designed to demonstrate product thinking, backend fundamentals (RLS, multi‑tenant), solid UI/UX, and deployment best practices.

This README is the single source of truth and should ALWAYS reflect the current direction and state of the project.

## Goals
- Multi‑tenant: multiple blogs (organizations) and users per blog
- Professional polish: real RBAC, domain mapping, SEO, feeds, analytics, testing, CI/CD
- Modern stack and DX: Next.js App Router, server actions, Gluestack UI, Supabase Auth + Postgres

## Tech Stack
- Framework: Next.js (App Router)
- Language: TypeScript
- UI: Gluestack
- Auth & Database: Supabase (Auth + Postgres)
- Styling: Tailwind CSS (with Gluestack styling primitives)
- Deployment: Vercel (planned) + GitHub Actions CI

## Core Features (Planned)
- Multi‑tenant structure: Organizations (blogs), Users, Memberships (Owner/Admin/Author/Viewer)
- Content model: Posts, Categories, Tags, PostTags (many‑to‑many), Revisions, Drafts/Scheduled
- Routing: Per‑blog subdomain (blogSlug.yourdomain.com) and custom domains; middleware resolves tenant by host
- Auth & RBAC: Supabase Auth; RLS policies enforce org‑scoped reads/writes; public reads for published posts
- Admin: Post editor (Markdown/MDX first), media management, theme/branding, domain management
- Public: Home feed, post detail, category page, tag page, author page, search
- SEO & Feeds: Sitemap, RSS/Atom/JSON feeds, Open Graph image generation
- Quality: ESLint/Prettier, unit/integration tests, Playwright e2e, CI workflows

## Initial Data Model (High‑Level)
- organizations: id, slug, name, branding_json, created_at
- profiles: user_id, display_name, avatar_url, created_at (linked to Supabase auth users)
- memberships: user_id, org_id, role (Owner/Admin/Author/Viewer)
- posts: id, org_id, author_id, title, slug, content (Markdown/MDX), status (draft/published/scheduled),
  published_at, updated_at, cover_image_url, category_id
- categories: id, org_id, name, slug
- tags: id, org_id, name, slug
- post_tags: post_id, tag_id
- revisions: id, post_id, version, content, created_by, created_at
- domains: id, org_id, hostname, is_primary

RLS overview: Public read of published posts by org; all writes restricted to memberships with appropriate role.

## Architecture Overview
- Tenant resolution: Middleware inspects Host header, finds org by domain or subdomain, attaches org to request context
- Data access: Supabase server client; server actions for mutations; edge‑friendly where possible
- Rendering: Server components by default; client components where interactivity is needed (editor, media picker)
- Storage: Supabase Postgres + optional storage bucket for images

## Roadmap (MVP → Showcase)
1) Repo bootstrap and docs (this commit)
2) Scaffold Next.js + TypeScript project
3) Add Gluestack UI + Tailwind
4) Supabase schema + RLS + seed scripts
5) Tenant middleware (domain/subdomain) and basic public pages
6) Admin auth + minimal editor (Markdown) and post CRUD
7) Categories, Tags, PostTags UI and queries
8) Feeds (RSS/Atom/JSON), sitemap, OG image
9) Playwright e2e + GitHub Actions CI; Vercel deploy
10) Custom domains and branding polish

## Project Structure
- web/ — Next.js application (TypeScript, App Router, Tailwind, ESLint)

## Local Development (current status: scaffolded)
Requirements: Node 18+, npm (or pnpm), Docker (optional), Supabase project

```powershell
# Install deps
npm --prefix .\web install

# Run dev server
npm --prefix .\web run dev
```

Environment variables
```powershell
# Create web/.env.local with placeholders (do not commit real secrets)
@'
NEXT_PUBLIC_SUPABASE_URL={{NEXT_PUBLIC_SUPABASE_URL}}
NEXT_PUBLIC_SUPABASE_ANON_KEY={{NEXT_PUBLIC_SUPABASE_ANON_KEY}}
'@ | Set-Content -NoNewline .\web\.env.local
```

Install additional packages (already executed)
```powershell
# Gluestack UI + Supabase client
npm --prefix .\web install @gluestack-ui/themed @gluestack-style/react @gluestack-ui/config @supabase/supabase-js
```

Supabase schema and RLS will be added under /db with SQL files and a seed script.

## Contributing / Branching
- main is protected; feature branches for work; PRs with concise descriptions
- Conventional commits (e.g., "feat:", "fix:", "docs:")

## License
TBD
