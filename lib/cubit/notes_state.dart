// ignore_for_file: must_be_immutable

part of 'notes_cubit.dart';

@immutable
sealed class NotesState {}

class NotesInitial extends NotesState {}

class GetNotes extends NotesState {}

class DeleteNote extends NotesState {
  String msg = 'Note deleted successfully';
}

class UpdateNote extends NotesState {
  String msg = 'Note updated successfully';
}

class AddNote extends NotesState {
  String msg = 'Note added successfully';
}