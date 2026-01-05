import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/note.dart';

class NotesService {
  final _supabase = Supabase.instance.client;
  final _uuid = const Uuid();
  static const String tableName = 'notes';

  // Get all notes ordered by updated_at descending
  Future<List<Note>> getNotes() async {
    try {
      final response = await _supabase
          .from(tableName)
          .select()
          .order('updated_at', ascending: false);
      
      return (response as List).map((json) => Note.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch notes: $e');
    }
  }

  // Get a single note by ID
  Future<Note?> getNote(String id) async {
    try {
      final response = await _supabase
          .from(tableName)
          .select()
          .eq('id', id)
          .maybeSingle();
      
      if (response == null) return null;
      return Note.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch note: $e');
    }
  }

  // Create a new note
  Future<Note> createNote({
    required String title,
    required String content,
  }) async {
    try {
      final now = DateTime.now();
      final noteData = {
        'id': _uuid.v4(),
        'title': title,
        'content': content,
        'created_at': now.toIso8601String(),
        'updated_at': now.toIso8601String(),
      };

      final response = await _supabase
          .from(tableName)
          .insert(noteData)
          .select()
          .single();

      return Note.fromJson(response);
    } catch (e) {
      throw Exception('Failed to create note: $e');
    }
  }

  // Update an existing note
  Future<Note> updateNote({
    required String id,
    required String title,
    required String content,
  }) async {
    try {
      final now = DateTime.now();
      final noteData = {
        'title': title,
        'content': content,
        'updated_at': now.toIso8601String(),
      };

      final response = await _supabase
          .from(tableName)
          .update(noteData)
          .eq('id', id)
          .select()
          .single();

      return Note.fromJson(response);
    } catch (e) {
      throw Exception('Failed to update note: $e');
    }
  }

  // Delete a note
  Future<void> deleteNote(String id) async {
    try {
      await _supabase
          .from(tableName)
          .delete()
          .eq('id', id);
    } catch (e) {
      throw Exception('Failed to delete note: $e');
    }
  }

  // Stream notes for real-time updates
  Stream<List<Note>> watchNotes() {
    return _supabase
        .from(tableName)
        .stream(primaryKey: ['id'])
        .order('updated_at', ascending: false)
        .map((data) => data.map((json) => Note.fromJson(json)).toList());
  }
}
