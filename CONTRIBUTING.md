# Contributing to Vibe Notes

Thank you for your interest in contributing to Vibe Notes! This document provides guidelines and instructions for contributing.

## Code of Conduct

- Be respectful and inclusive
- Welcome newcomers and help them get started
- Focus on constructive feedback
- Keep discussions on-topic

## How to Contribute

### Reporting Bugs

If you find a bug, please create an issue with:
- Clear description of the problem
- Steps to reproduce
- Expected vs actual behavior
- Screenshots if applicable
- Your environment (OS, Flutter version, device)

### Suggesting Features

Feature requests are welcome! Please:
- Check if the feature is already requested
- Provide a clear use case
- Explain why it would benefit users
- Consider implementation complexity

### Pull Requests

1. **Fork the repository**
   ```bash
   git clone https://github.com/hanif-ok/vibe_notes.git
   cd vibe_notes
   ```

2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**
   - Follow the existing code style
   - Add tests if applicable
   - Update documentation
   - Keep commits focused and atomic

4. **Test your changes**
   ```bash
   flutter test
   flutter analyze
   ```

5. **Commit your changes**
   ```bash
   git add .
   git commit -m "feat: add your feature description"
   ```

   Use conventional commit messages:
   - `feat:` - New feature
   - `fix:` - Bug fix
   - `docs:` - Documentation changes
   - `style:` - Code style changes
   - `refactor:` - Code refactoring
   - `test:` - Adding tests
   - `chore:` - Maintenance tasks

6. **Push and create PR**
   ```bash
   git push origin feature/your-feature-name
   ```
   Then create a pull request on GitHub.

## Development Setup

1. **Install Flutter**
   - Follow [Flutter installation guide](https://flutter.dev/docs/get-started/install)
   - Ensure Flutter 3.0+ is installed

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up Supabase**
   - Create a Supabase project
   - Run the SQL schema from `supabase_schema.sql`
   - Get your credentials from project settings

4. **Run the app**
   ```bash
   flutter run --dart-define=SUPABASE_URL=your_url --dart-define=SUPABASE_ANON_KEY=your_key
   ```

## Code Style

### Dart/Flutter Guidelines

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart)
- Use `flutter analyze` to check for issues
- Run `dart format .` before committing
- Prefer `const` constructors when possible
- Use meaningful variable and function names

### File Organization

```
lib/
├── models/          # Data models
├── services/        # Business logic and API calls
├── screens/         # UI screens
├── widgets/         # Reusable widgets
└── utils/           # Helper functions
```

### Naming Conventions

- Files: `snake_case.dart`
- Classes: `PascalCase`
- Variables/Functions: `camelCase`
- Constants: `camelCase` or `SCREAMING_SNAKE_CASE`
- Private members: `_leadingUnderscore`

## Testing Guidelines

### Writing Tests

- Write tests for new features
- Maintain existing test coverage
- Test edge cases and error scenarios
- Use descriptive test names

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/note_test.dart

# Run with coverage
flutter test --coverage
```

## Documentation

- Update README.md for user-facing changes
- Update ARCHITECTURE.md for technical changes
- Add inline comments for complex logic
- Update SETUP.md if configuration changes

## Review Process

1. **Automated Checks**
   - Code must pass `flutter analyze`
   - Tests must pass
   - Code should be formatted

2. **Manual Review**
   - Code quality and style
   - Test coverage
   - Documentation updates
   - Breaking changes consideration

3. **Feedback**
   - Address review comments
   - Update PR as needed
   - Rebase if requested

## Areas for Contribution

### Easy (Good for beginners)
- Fix typos in documentation
- Add more test cases
- Improve error messages
- UI/UX enhancements

### Medium
- Add new features (tags, search)
- Improve performance
- Add accessibility features
- Implement offline support

### Advanced
- Add authentication
- Real-time collaboration
- Custom state management
- Native platform features

## Questions?

- Open an issue for questions
- Tag issues with `question` label
- Join discussions in existing issues

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

Thank you for contributing to Vibe Notes! 🎉
