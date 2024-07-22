// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:session_sqflite/cubit/notes_cubit.dart';
import 'package:session_sqflite/screens/home.dart';
import 'package:session_sqflite/widgets/custom_textform.dart';

class EditNotes extends StatefulWidget {
 const EditNotes(
      {super.key,
      required this.id,
      required this.title,
      required this.note,
      required this.time,
      required this.date});
  final int id;
  final String title;
  final String note;
  final String time;
  final String date;

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  GlobalKey<FormState> formState = GlobalKey();

  TextEditingController titleC = TextEditingController();

  TextEditingController noteC = TextEditingController();

  TextEditingController timeC = TextEditingController();

  TextEditingController dateC = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleC.text = widget.title;
    noteC.text = widget.note;
    timeC.text = widget.time;
    dateC.text = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    NotesCubit cubit = BlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Notes'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formState,
          child: ListView(
            children: [
              CustomTextForm(
                controller: titleC,
                hintText: 'Title',
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextForm(
                controller: noteC,
                hintText: 'Note',
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextForm(
                onTap: () {
                  showTimePicker(context: context, initialTime: TimeOfDay.now())
                      .then((value) =>
                          timeC.text = value!.format(context).toString());
                },
                controller: timeC,
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
                          dateC.text = DateFormat.yMMMd().format(value!));
                },
                controller: dateC,
                hintText: 'Date',
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                shape: const StadiumBorder(),
                height: 50,
                onPressed: () {
                  if (formState.currentState!.validate()) {
                    cubit.updateData(
                        title: titleC.text,
                        note: noteC.text,
                        date: dateC.text,
                        time: timeC.text,
                        id: widget.id);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
                  }
                },
                color: Colors.blueGrey,
                child: const Text("Edit notes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
