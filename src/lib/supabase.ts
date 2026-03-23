import { createClient } from '@supabase/supabase-js';

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL as string;
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY as string;

if (!supabaseUrl || !supabaseAnonKey) {
  throw new Error('Supabase URL e/ou ANON KEY não configurados no ficheiro .env');
}

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

// ---- Tipos das tabelas ----

export interface CmsSettings {
  id: number;
  autoplay_enabled: boolean;
  video_url: string | null;
  updated_at: string;
}

export interface GalleryImage {
  id: number;
  data_url: string;
  created_at: string;
}
