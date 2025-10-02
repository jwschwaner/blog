-- db/schema.sql
-- Initial multi-tenant schema for the showcase blog (Supabase/Postgres)
-- Safe to run in an empty database. Adjust naming to your needs.

create table if not exists organizations (
  id uuid primary key default gen_random_uuid(),
  slug text unique not null,
  name text not null,
  branding_json jsonb default '{}'::jsonb,
  created_at timestamptz not null default now()
);

create table if not exists profiles (
  user_id uuid primary key references auth.users(id) on delete cascade,
  display_name text,
  avatar_url text,
  created_at timestamptz not null default now()
);

-- Roles: owner, admin, author, viewer
create table if not exists memberships (
  user_id uuid not null references auth.users(id) on delete cascade,
  org_id uuid not null references organizations(id) on delete cascade,
  role text not null check (role in ('owner','admin','author','viewer')),
  created_at timestamptz not null default now(),
  primary key (user_id, org_id)
);

create table if not exists categories (
  id uuid primary key default gen_random_uuid(),
  org_id uuid not null references organizations(id) on delete cascade,
  name text not null,
  slug text not null,
  unique (org_id, slug)
);

create table if not exists tags (
  id uuid primary key default gen_random_uuid(),
  org_id uuid not null references organizations(id) on delete cascade,
  name text not null,
  slug text not null,
  unique (org_id, slug)
);

create table if not exists posts (
  id uuid primary key default gen_random_uuid(),
  org_id uuid not null references organizations(id) on delete cascade,
  author_id uuid not null references auth.users(id) on delete restrict,
  title text not null,
  slug text not null,
  content text not null,
  status text not null check (status in ('draft','published','scheduled')),
  published_at timestamptz,
  updated_at timestamptz not null default now(),
  cover_image_url text,
  category_id uuid references categories(id) on delete set null,
  unique (org_id, slug)
);

create table if not exists post_tags (
  post_id uuid not null references posts(id) on delete cascade,
  tag_id uuid not null references tags(id) on delete cascade,
  primary key (post_id, tag_id)
);

create table if not exists revisions (
  id uuid primary key default gen_random_uuid(),
  post_id uuid not null references posts(id) on delete cascade,
  version int not null,
  content text not null,
  created_by uuid not null references auth.users(id) on delete set null,
  created_at timestamptz not null default now(),
  unique (post_id, version)
);

create table if not exists domains (
  id uuid primary key default gen_random_uuid(),
  org_id uuid not null references organizations(id) on delete cascade,
  hostname text not null unique,
  is_primary boolean not null default false
);

-- Helpful indexes
create index if not exists idx_posts_org_published on posts(org_id, status, published_at desc);
create index if not exists idx_categories_org on categories(org_id);
create index if not exists idx_tags_org on tags(org_id);
create index if not exists idx_memberships_user on memberships(user_id);
