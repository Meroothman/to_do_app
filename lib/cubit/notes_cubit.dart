import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());
  static NotesCubit get (context)=> BlocProvider.of(context);
  List notes = [];
  Database? database;
  createDbAndTable() async {
    await openDatabase(
      'notes.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(''' CREATE TABLE notes (
        'id' INTEGER PRIMARY KEY AUTOINCREMENT,
        'title' TEXT  NOT NULL,
        'note' TEXT NOT NULL , 
        'date' TEXT NOT NULL,
        'time' TEXT NOT NULL)''');
      },
      onOpen: (Database db) {
        getData(db).then((value) {
          notes = value;
          emit(GetNotes());
        });
      },
    ).then((value) => database = value);

    emit(GetNotes());
  }

  insertData({
      String title = '',
      String note = '',
      String date = '',
      String time = ''}) async {
    await database?.transaction((txn) async {
      txn.rawInsert(
        'INSERT INTO Notes(title, note, date, time) VALUES("$title", "$note", "$date", "$time")')
          .then((value) {
            emit(GetNotes());
        getData(database!).then((value) {
          notes =value;
           emit(AddNote());
        }); 
      });
    });
  }

  Future<List<Map>> getData(Database db) async {
    return await db.rawQuery('SELECT * FROM Notes');
  }

  deleteData(int id) async {
    await database
        ?.rawDelete('DELETE FROM Notes WHERE id = ?', [id]).then((value) {
      emit( GetNotes());
      getData(database!).then((value) {
        notes = value;
        emit(DeleteNote());
      });
    });
  }

  updateData({String title = '',
      String note = '',
      String date = '',
      String time = '',
      int id = 0}) 
      async {
    await database?.rawUpdate(
        'UPDATE Notes SET title = ?, note = ?, date = ?, time = ? WHERE id = ?',
        [title, note, date, time, id]).then((value) {
      emit(GetNotes());
      getData(database!).then((value) {
        notes = value;
        emit(UpdateNote());
      });
    });
  }
}
