-- Vibe Notes Database Schema for Supabase
-- Run this SQL in your Supabase SQL Editor

-- Create notes table
CREATE TABLE IF NOT EXISTS notes (
  id UUID PRIMARY KEY,
  title TEXT NOT NULL DEFAULT '',
  content TEXT NOT NULL DEFAULT '',
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE notes ENABLE ROW LEVEL SECURITY;

-- Create policy to allow all operations
-- Note: In production, you should restrict this based on user authentication
-- For example: USING (auth.uid() = user_id) for authenticated users
CREATE POLICY "Allow all operations on notes" ON notes
  FOR ALL
  USING (true)
  WITH CHECK (true);

-- Create index for faster queries on updated_at
CREATE INDEX IF NOT EXISTS idx_notes_updated_at ON notes (updated_at DESC);

-- Create index for faster queries on created_at
CREATE INDEX IF NOT EXISTS idx_notes_created_at ON notes (created_at DESC);

-- Optional: Add a function to automatically update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Optional: Create trigger to auto-update updated_at
CREATE TRIGGER update_notes_updated_at 
  BEFORE UPDATE ON notes 
  FOR EACH ROW 
  EXECUTE FUNCTION update_updated_at_column();
