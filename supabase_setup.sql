-- =================================================
-- Gold Services - Supabase Database Setup
-- Execute este SQL no dashboard do Supabase:
-- https://supabase.com/dashboard -> SQL Editor
-- =================================================

-- Tabela de configurações do CMS (1 linha apenas)
CREATE TABLE IF NOT EXISTS cms_settings (
  id BIGINT PRIMARY KEY DEFAULT 1,
  autoplay_enabled BOOLEAN NOT NULL DEFAULT true,
  volume_enabled BOOLEAN NOT NULL DEFAULT false,
  video_url TEXT DEFAULT NULL,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- MIGRATION: Se a tabela já existir, execute isto para adicionar a nova coluna:
-- ALTER TABLE cms_settings ADD COLUMN IF NOT EXISTS volume_enabled BOOLEAN NOT NULL DEFAULT false;

-- Inserir a linha inicial de configurações
INSERT INTO cms_settings (id, autoplay_enabled, video_url)
VALUES (1, true, null)
ON CONFLICT (id) DO NOTHING;

-- Tabela de imagens da galeria
CREATE TABLE IF NOT EXISTS gallery_images (
  id BIGSERIAL PRIMARY KEY,
  data_url TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Ativar Row Level Security (RLS) mas permitir acesso anónimo para leitura e escrita
-- (adequado para um CMS admin controlado por password no frontend)
ALTER TABLE cms_settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE gallery_images ENABLE ROW LEVEL SECURITY;

-- Políticas: permitir tudo ao anon (a autenticação é feita no frontend pelo admin)
CREATE POLICY "Allow all for anon" ON cms_settings FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for anon" ON gallery_images FOR ALL TO anon USING (true) WITH CHECK (true);
