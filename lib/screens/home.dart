import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:session_sqflite/screens/add_notes.dart';
import 'package:session_sqflite/cubit/notes_cubit.dart';
import 'package:session_sqflite/screens/edit_notes.dart';

import '../widgets/custom_snack_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
 Widget build(BuildContext context) {
    return BlocConsumer<NotesCubit, NotesState>(
      listener: (context, state) {
        if (state is DeleteNote) {
          customSnackBar(context, state.msg);
        } else if (state is AddNote) {
          customSnackBar(context, state.msg);
        } else if (state is UpdateNote) {
          customSnackBar(context, state.msg);
        }
      },
      builder: (context, state) {
        NotesCubit cubit = NotesCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Notes App'),
            backgroundColor: Colors.blueGrey,
          ),
          body: ListView(children: [
            ListView.builder(
                itemCount: cubit.notes.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                      leading: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.blueGrey,
                        child: Text(
                          cubit.notes[index]['time'].toString(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 10),
                        ),
                      ),
                      title: Text(
                        cubit.notes[index]['title'].toString(),
                      ),
                      subtitle: Text(
                        cubit.notes[index]['note'].toString(),
                      ),
                      trailing: Column(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      cubit.deleteData(cubit.notes[index]['id']);
                                    }),
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => EditNotes(
                                              title: cubit.notes[index]['title'],
                                              note: cubit.notes[index]['note'],
                                              time: cubit.notes[index]['time'],
                                              date: cubit.notes[index]['date'],
                                              id: cubit.notes[index]['id'],
                                        )));
                                  },
                                )
                              ],
                            ),
                          ),
                         Text(
                          cubit.notes[index]['date'].toString(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 10),
                        ),
                        ],
                      ));
                })
          ]),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blueGrey,
            foregroundColor: Colors.white,
            shape: const CircleBorder(),
            child: const Icon(Icons.add),
            onPressed: (){
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddNotes()));
            },
          ),
        );
      },
    );
  }
}

