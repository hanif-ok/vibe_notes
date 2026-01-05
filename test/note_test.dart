import 'package:flutter_test/flutter_test.dart';
import 'package:vibe_notes/models/note.dart';

void main() {
  group('Note Model Tests', () {
    test('Note should be created from JSON', () {
      final json = {
        'id': '123',
        'title': 'Test Note',
        'content': 'Test Content',
        'created_at': '2024-01-01T00:00:00.000Z',
        'updated_at': '2024-01-01T00:00:00.000Z',
      };

      final note = Note.fromJson(json);

      expect(note.id, '123');
      expect(note.title, 'Test Note');
      expect(note.content, 'Test Content');
      expect(note.createdAt, isA<DateTime>());
      expect(note.updatedAt, isA<DateTime>());
    });

    test('Note should convert to JSON', () {
      final note = Note(
        id: '123',
        title: 'Test Note',
        content: 'Test Content',
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
      );

      final json = note.toJson();

      expect(json['id'], '123');
      expect(json['title'], 'Test Note');
      expect(json['content'], 'Test Content');
      expect(json['created_at'], isA<String>());
      expect(json['updated_at'], isA<String>());
    });

    test('Note should format date correctly', () {
      final note = Note(
        id: '123',
        title: 'Test Note',
        content: 'Test Content',
        createdAt: DateTime(2024, 1, 15, 14, 30),
        updatedAt: DateTime(2024, 1, 15, 14, 30),
      );

      expect(note.formattedDate, contains('Jan'));
      expect(note.formattedDate, contains('15'));
      expect(note.formattedDate, contains('2024'));
    });

    test('Note copyWith should work correctly', () {
      final note = Note(
        id: '123',
        title: 'Original Title',
        content: 'Original Content',
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
      );

      final updatedNote = note.copyWith(
        title: 'Updated Title',
      );

      expect(updatedNote.id, note.id);
      expect(updatedNote.title, 'Updated Title');
      expect(updatedNote.content, note.content);
      expect(updatedNote.createdAt, note.createdAt);
    });
  });
}
