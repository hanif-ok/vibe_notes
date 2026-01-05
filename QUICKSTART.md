# Quick Start Guide - Vibe Notes

Get up and running with Vibe Notes in 5 minutes! 🚀

## Prerequisites

- Flutter 3.0+ installed ([Install Flutter](https://flutter.dev/docs/get-started/install))
- A Supabase account (free tier available at [supabase.com](https://supabase.com))

## Step 1: Clone the Repository

```bash
git clone https://github.com/hanif-ok/vibe_notes.git
cd vibe_notes
```

## Step 2: Create Supabase Project

1. Go to [https://supabase.com](https://supabase.com) and sign in
2. Click "New Project"
3. Enter project details and wait ~2 minutes for it to be ready

## Step 3: Set Up Database

1. In your Supabase project, go to **SQL Editor** (left sidebar)
2. Copy the contents of `supabase_schema.sql` from this repository
3. Paste into the SQL Editor and click **Run**

## Step 4: Get API Credentials

1. In Supabase, go to **Project Settings** → **API**
2. Copy these two values:
   - **Project URL**: `https://xxxxx.supabase.co`
   - **anon public key**: `eyJhbGc...`

## Step 5: Configure and Run

### Option A: Using Dev Script (Recommended)

**Linux/macOS:**
```bash
# Create .env file
cp .env.example .env

# Edit .env and add your credentials
nano .env

# Or use your favorite editor
code .env

# Run setup
./dev.sh setup

# Run the app
./dev.sh run
```

**Windows:**
```cmd
# Create .env file
copy .env.example .env

# Edit .env and add your credentials
notepad .env

# Run setup
dev.bat setup

# Run the app
dev.bat run
```

### Option B: Manual Run

```bash
# Install dependencies
flutter pub get

# Run the app with your credentials
flutter run \
  --dart-define=SUPABASE_URL=https://your-project.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=your_anon_key_here
```

## Step 6: Test the App

1. The app should launch on your device/emulator
2. Tap the **New Note** floating button
3. Enter a title and content
4. Tap the checkmark ✓ to save
5. Your note appears in the list!

## Troubleshooting

### "Failed to fetch notes" Error
- ✅ Check your Supabase URL and key are correct
- ✅ Verify you ran the SQL schema
- ✅ Ensure your device has internet

### Dependencies Won't Install
```bash
flutter clean
flutter pub get
```

### Can't Find Flutter Command
- Make sure Flutter is in your PATH
- Run: `flutter doctor` to check installation

## What's Next?

- 📖 Read the [full README](README.md) for detailed documentation
- 🏗️ Check out [ARCHITECTURE.md](ARCHITECTURE.md) to understand the code structure
- 🤝 Want to contribute? See [CONTRIBUTING.md](CONTRIBUTING.md)
- 🔧 Customize the app for your needs

## Platform-Specific Builds

### Android APK
```bash
./dev.sh build apk
# or
flutter build apk --release --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...
```

### Web
```bash
./dev.sh build web
# or
flutter build web --release --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...
```

### iOS
```bash
flutter build ios --release --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...
```

## Need Help?

- 📝 Create an [issue](https://github.com/hanif-ok/vibe_notes/issues) if you find a bug
- 💡 Have an idea? Submit a [feature request](https://github.com/hanif-ok/vibe_notes/issues/new?template=feature_request.md)
- 📚 Check the [SETUP.md](SETUP.md) for more detailed instructions

## Pro Tips

- Use `./dev.sh check` to run tests and code analysis
- Use `./dev.sh format` to auto-format your code
- Set up IDE shortcuts for faster development
- Enable hot reload for faster development cycles

Happy coding! 🎉
