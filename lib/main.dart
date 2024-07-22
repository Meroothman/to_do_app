import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:session_sqflite/cubit/notes_cubit.dart';
import 'package:session_sqflite/screens/home.dart';

void main() {
  runApp(const SqfliteAPP());
}

class SqfliteAPP extends StatelessWidget {
  const SqfliteAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
     create: (context) => NotesCubit()..createDbAndTable(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
