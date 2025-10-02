# WARP: Working in this repo with the terminal assistant

This file documents common, repeatable terminal actions to keep development fast and reproducible. Commands assume PowerShell on Windows and the project root at C:\Personal\blog.

Principles
- Keep README.md as the source of truth. Update it whenever the plan changes.
- Never paste secrets directly into commands; use environment variables or secret managers.
- Prefer pnpm (or npm) consistently across the team.

Initial repo tasks
```powershell path=null start=null
# Verify git status
git -C C:\Personal\blog status --short

# Install Node dependencies (once the Next.js app is scaffolded)
pnpm install

# Start dev server (after scaffold)
pnpm dev
```

Branching and commits
```powershell path=null start=null
# Create a feature branch
git -C C:\Personal\blog checkout -b feat/tenant-middleware

# Stage and commit changes
git -C C:\Personal\blog add .
git -C C:\Personal\blog commit -m "feat(tenant): resolve org by host"

# Push and open a PR
git -C C:\Personal\blog push -u origin feat/tenant-middleware
```

Scaffold Next.js (planned step)
```powershell path=null start=null
# From project root
npx create-next-app@latest . --ts
pnpm add @gluestack-ui/themed @gluestack-style/react @gluestack-ui/config
pnpm add @supabase/supabase-js
pnpm add -D tailwindcss postcss autoprefixer @types/node @types/react typescript eslint prettier
npx tailwindcss init -p
```

Environment variables
```powershell path=null start=null
# Create .env.local with placeholders (do not commit real secrets)
@'
NEXT_PUBLIC_SUPABASE_URL={{NEXT_PUBLIC_SUPABASE_URL}}
NEXT_PUBLIC_SUPABASE_ANON_KEY={{NEXT_PUBLIC_SUPABASE_ANON_KEY}}
'@ | Set-Content -NoNewline .\.env.local
```

Supabase schema (planned)
- Place SQL files under /db or /supabase (e.g., /db/schema.sql, /db/seed.sql)
- Include RLS policies: public read of published posts; writes limited by memberships and roles

Quality checks
```powershell path=null start=null
# Lint and format (after config exists)
pnpm lint
pnpm format

# Run tests (once added)
pnpm test
```

CI/CD (planned)
- GitHub Actions: build, lint, test on PR
- Vercel: preview deployments per branch

Troubleshooting
- If push/auth fails over HTTPS, ensure Git Credential Manager is installed or switch to SSH
- If dev server fails to start, verify Node version (>= 18) and that .env.local exists with valid placeholders
