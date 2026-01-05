# Vibe Notes 📝

A simple and elegant notes app built with Flutter and Supabase. Create, edit, and delete notes with real-time synchronization.

## Features

- ✨ Clean and modern UI with Material Design 3
- 📱 Cross-platform (Android, iOS, Web, Desktop)
- 🔄 Real-time synchronization with Supabase
- 🌙 Dark mode support
- 💾 Create, read, update, and delete notes
- 🔍 Notes are ordered by last update time
- ⚡ Fast and responsive

## Prerequisites

Before you begin, ensure you have the following installed:
- Flutter SDK (3.0.0 or higher)
- Dart SDK (included with Flutter)
- A Supabase account and project

## Supabase Setup

1. Create a free account at [Supabase](https://supabase.com)
2. Create a new project
3. In your project dashboard, go to the SQL Editor
4. Run the following SQL to create the notes table:

```sql
-- Create notes table
CREATE TABLE notes (
  id UUID PRIMARY KEY,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Enable Row Level Security
ALTER TABLE notes ENABLE ROW LEVEL SECURITY;

-- Create policy to allow all operations for now
-- Note: In production, you should restrict this based on authentication
CREATE POLICY "Allow all operations on notes" ON notes
  FOR ALL
  USING (true)
  WITH CHECK (true);

-- Create index for faster queries
CREATE INDEX idx_notes_updated_at ON notes (updated_at DESC);
```

5. Get your Supabase URL and anon key from Project Settings > API

## Installation

1. Clone the repository:
```bash
git clone https://github.com/hanif-ok/vibe_notes.git
cd vibe_notes
```

2. Install dependencies:
```bash
flutter pub get
```

3. Configure Supabase credentials:

You can provide your Supabase credentials in two ways:

**Option A: Using environment variables (recommended for development)**
```bash
flutter run --dart-define=SUPABASE_URL=your_supabase_url --dart-define=SUPABASE_ANON_KEY=your_anon_key
```

**Option B: Edit lib/main.dart directly** (not recommended for production)
```dart
await Supabase.initialize(
  url: 'your_supabase_url',
  anonKey: 'your_anon_key',
);
```

## Running the App

### Mobile (Android/iOS)
```bash
# Run on connected device or emulator
flutter run --dart-define=SUPABASE_URL=your_url --dart-define=SUPABASE_ANON_KEY=your_key
```

### Web
```bash
flutter run -d chrome --dart-define=SUPABASE_URL=your_url --dart-define=SUPABASE_ANON_KEY=your_key
```

### Desktop
```bash
# Linux
flutter run -d linux --dart-define=SUPABASE_URL=your_url --dart-define=SUPABASE_ANON_KEY=your_key

# macOS
flutter run -d macos --dart-define=SUPABASE_URL=your_url --dart-define=SUPABASE_ANON_KEY=your_key

# Windows
flutter run -d windows --dart-define=SUPABASE_URL=your_url --dart-define=SUPABASE_ANON_KEY=your_key
```

## Building for Production

### Android APK
```bash
flutter build apk --release --dart-define=SUPABASE_URL=your_url --dart-define=SUPABASE_ANON_KEY=your_key
```

### iOS
```bash
flutter build ios --release --dart-define=SUPABASE_URL=your_url --dart-define=SUPABASE_ANON_KEY=your_key
```

### Web
```bash
flutter build web --release --dart-define=SUPABASE_URL=your_url --dart-define=SUPABASE_ANON_KEY=your_key
```

## Project Structure

```
lib/
├── main.dart                 # App entry point and initialization
├── models/
│   └── note.dart            # Note data model
├── services/
│   └── notes_service.dart   # Supabase service layer
└── screens/
    ├── notes_screen.dart    # Home screen (notes list)
    └── note_editor_screen.dart  # Note create/edit screen
```

## Architecture

- **Models**: Data models representing app entities
- **Services**: Business logic and Supabase interaction
- **Screens**: UI components and user interaction

## Dependencies

- `supabase_flutter`: Supabase client for Flutter
- `intl`: Date formatting
- `uuid`: Generate unique IDs for notes

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the MIT License.

## Support

If you encounter any issues or have questions, please file an issue on the GitHub repository.
