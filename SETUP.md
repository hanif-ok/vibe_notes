# Vibe Notes Configuration Guide

## Quick Start

This guide will help you set up Vibe Notes with Supabase in under 5 minutes.

## Step 1: Create Supabase Project

1. Go to [https://supabase.com](https://supabase.com)
2. Sign up or log in
3. Click "New Project"
4. Fill in:
   - Project name: `vibe-notes` (or any name you prefer)
   - Database password: (choose a strong password)
   - Region: (select closest to you)
5. Click "Create new project" and wait for it to be ready (~2 minutes)

## Step 2: Set Up Database

1. In your Supabase project dashboard, click on "SQL Editor" in the left sidebar
2. Click "New query"
3. Copy and paste the contents of `supabase_schema.sql` file from this repository
4. Click "Run" to execute the SQL
5. You should see a success message

## Step 3: Get API Credentials

1. In your Supabase project, go to "Project Settings" (gear icon in the left sidebar)
2. Click on "API" in the settings menu
3. You'll see two important values:
   - **Project URL** (looks like: `https://xxxxx.supabase.co`)
   - **anon public key** (a long string starting with `eyJ...`)
4. Copy these values - you'll need them in the next step

## Step 4: Configure the App

**For development/testing:**

Run the app with environment variables:

```bash
flutter run \
  --dart-define=SUPABASE_URL=https://xxxxx.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=eyJhbGc...your_key_here
```

**For production builds:**

Use the same approach with build commands:

```bash
flutter build apk \
  --dart-define=SUPABASE_URL=https://xxxxx.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=eyJhbGc...your_key_here
```

## Step 5: Test the App

1. Run the app on your device or simulator
2. If you see an error screen, check:
   - Your Supabase URL and key are correct
   - You ran the SQL schema
   - Your device has internet connection
3. Try creating a note by tapping the "New Note" button
4. Add a title and content, then tap the checkmark to save
5. Your note should appear in the list!

## Troubleshooting

### "Failed to fetch notes" error

- **Check credentials**: Make sure your Supabase URL and anon key are correct
- **Check internet**: Ensure your device has internet connectivity
- **Check Supabase status**: Go to your Supabase dashboard to ensure the project is active

### "Failed to create note" error

- **Check RLS policies**: Ensure you ran the entire SQL schema including the policies
- **Check table**: Verify the `notes` table exists in Supabase Table Editor

### App crashes on startup

- **Check dependencies**: Run `flutter pub get` to ensure all packages are installed
- **Check Flutter version**: Ensure you're using Flutter 3.0.0 or higher

## Security Notes

⚠️ **Important**: The default setup allows anyone to create, read, update, and delete notes. For production:

1. Implement user authentication with Supabase Auth
2. Add a `user_id` column to the notes table
3. Update RLS policies to restrict access based on `auth.uid()`

Example production policy:
```sql
CREATE POLICY "Users can only access their own notes" ON notes
  FOR ALL
  USING (auth.uid()::text = user_id)
  WITH CHECK (auth.uid()::text = user_id);
```

## Next Steps

- Add user authentication
- Implement note sharing
- Add categories or tags
- Enable rich text formatting
- Add image attachments
- Implement search functionality

## Need Help?

If you run into any issues, please open an issue on the GitHub repository with:
- The error message
- Your Flutter version (`flutter --version`)
- Steps to reproduce the issue
