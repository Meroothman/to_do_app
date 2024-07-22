// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:session_sqflite/cubit/notes_cubit.dart';
import 'package:session_sqflite/screens/home.dart';
import 'package:session_sqflite/widgets/custom_textform.dart';

class AddNotes extends StatelessWidget {
  AddNotes({super.key});

  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    NotesCubit cubit = BlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Notes'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formState,
          child: ListView(
            children: [
              CustomTextForm(
                controller: title,
                hintText: 'Title',
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextForm(
                controller: note,
                hintText: 'Note',
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextForm(
                onTap: () {
                  showTimePicker(context: context, initialTime: TimeOfDay.now())
                      .then((value) =>
                          time.text = value!.format(context).toString());
                },
                controller: time,
                hintText: 'Time',
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextForm(
                onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2050))
                      .then((value) =>
                          date.text = DateFormat.yMMMd().format(value!));
                },
                controller: date,
                hintText: 'Date',
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                height: 50,
                onPressed: () {
                  if (formState.currentState!.validate()) {
                    formState.currentState!.save();
                    cubit.insertData(
                      title: title.text,
                      note: note.text,
                      time: time.text,
                      date: date.text,
                    );
                    // cubit.getData(cubit.database!);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                        (route) => false);
                  }
                },
                color: Colors.blueGrey,
                child: const Text("Add notes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
