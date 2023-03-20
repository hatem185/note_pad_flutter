import 'package:flutter/material.dart';
import 'package:note_pad/note_data_base.dart';
import 'package:note_pad/comon.dart';
// import 'package:note_pad/comon.dart';
import 'package:note_pad/model/note.dart';
import 'package:note_pad/pages/details_note_screen.dart';
import 'package:note_pad/pages/editor_screen.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required this.title});
  final NoteDataBase dbConn = NoteDataBase();
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> _notes = [];
  // var mainA =
  @override
  void initState() {
    super.initState();
    widget.dbConn.getNotes().then((value) {
      _notes = value;
      setState(() => {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (_notes.isNotEmpty)
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, i) => NoteCard(
                      note: _notes[i],
                      removeNoteOnDismissed: (dismissDirection) async {
                        await widget.dbConn.removeNote(_notes[i].id!);
                        _notes.removeAt(i);
                        setState(() {
                          context.showSnackBar(msg: 'The note is deleted.');
                        });
                      },
                      refreshUIOnUpdate: () {
                        widget.dbConn.getNotes().then((value) {
                          _notes = value;
                          setState(() => {});
                        });
                      }),
                  separatorBuilder: (context, i) => const SizedBox(height: 10),
                  itemCount: _notes.length,
                ),
              ),
            if (_notes.isEmpty)
              const Center(
                child: Text(
                  'No notes.',
                  style: TextStyle(fontSize: 48, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditorScreen(
                refreshUI: () {
                  widget.dbConn.getNotes().then((value) {
                    _notes = value;
                    setState(() => {});
                  });
                },
              ),
            ),
          );
        },
        tooltip: 'Add Note',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NoteCard extends StatefulWidget {
  const NoteCard(
      {super.key,
      required this.note,
      required this.removeNoteOnDismissed,
      required this.refreshUIOnUpdate});
  final Future<void> Function(DismissDirection) removeNoteOnDismissed;
  final Note note;
  final void Function() refreshUIOnUpdate;

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (constext) => DetailsScreen(
                nId: widget.note.id!,
                refreshUIOnUpdate: widget.refreshUIOnUpdate),
          ),
        );
      },
      child: Dismissible(
        key: ValueKey(widget.note.id.toString()),
        onDismissed: widget.removeNoteOnDismissed,
        child: Card(
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.note.title ?? "",
                    style: const TextStyle(fontSize: 28),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
