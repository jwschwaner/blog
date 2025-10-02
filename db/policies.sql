-- db/policies.sql
-- Row Level Security (RLS) policies for multi-tenant access control.
-- Note: Adjust these policies to your needs and test thoroughly.

-- Enable RLS
alter table organizations enable row level security;
alter table profiles enable row level security;
alter table memberships enable row level security;
alter table categories enable row level security;
alter table tags enable row level security;
alter table posts enable row level security;
alter table post_tags enable row level security;
alter table revisions enable row level security;
alter table domains enable row level security;

-- Helper: membership check
-- Usage pattern in policies (via EXISTS subquery) to verify membership of auth.uid() to an org with minimum role.
-- Roles hierarchy: owner > admin > author > viewer

-- Public read of published posts per org
create policy if not exists posts_public_read on posts
  for select
  using (
    status = 'published'
  );

-- Members can read all org content
create policy if not exists posts_member_read on posts
  for select
  using (
    exists (
      select 1 from memberships m
      where m.org_id = posts.org_id and m.user_id = auth.uid()
    )
  );

-- Authors and above can insert posts in their org
create policy if not exists posts_author_write on posts
  for insert
  with check (
    exists (
      select 1 from memberships m
      where m.org_id = posts.org_id and m.user_id = auth.uid() and m.role in ('owner','admin','author')
    )
  );

-- Authors and above can update their org posts
create policy if not exists posts_author_update on posts
  for update
  using (
    exists (
      select 1 from memberships m
      where m.org_id = posts.org_id and m.user_id = auth.uid() and m.role in ('owner','admin','author')
    )
  );

-- Admins and owners can delete posts in their org
create policy if not exists posts_admin_delete on posts
  for delete
  using (
    exists (
      select 1 from memberships m
      where m.org_id = posts.org_id and m.user_id = auth.uid() and m.role in ('owner','admin')
    )
  );
