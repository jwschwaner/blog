import { createClient } from '@supabase/supabase-js'

// Use only public env vars in the client bundle
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!

if (!supabaseUrl || !supabaseAnonKey) {
  // Avoid throwing at module import; log a dev-friendly warning instead
  if (typeof window !== 'undefined') {
    // eslint-disable-next-line no-console
    console.warn('[supabase] Missing NEXT_PUBLIC_SUPABASE_URL or NEXT_PUBLIC_SUPABASE_ANON_KEY')
  }
}

export const supabase = createClient(supabaseUrl ?? '', supabaseAnonKey ?? '')
