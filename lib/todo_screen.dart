import 'package:flutter/material.dart';
import 'package:sqlapp/database_helper.dart';
import 'package:sqlapp/note_model.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final dbHelper = DatabaseHelper.instance;

  Future<void> _addNote() async {
    final note = NoteModel(description: 'sALAM', txt: 'sALAM');
    await dbHelper.create(note);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<NoteModel>>(
          future: dbHelper.readAllNotes(),
          builder: (context, snapshot) {
            print(snapshot.hasData);
            print(snapshot.data?.length);
            if (!snapshot.hasData) return CircularProgressIndicator();
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final note = snapshot.data![index];
                return ListTile(
                  title: Text(note.txt),
                  subtitle: Text(note.description ?? 'Null'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {},
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        child: Icon(Icons.add),
      ),
    );
  }
}
