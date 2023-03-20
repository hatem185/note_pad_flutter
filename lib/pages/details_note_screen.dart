import 'package:flutter/material.dart';
import 'package:note_pad/model/note.dart';
import 'package:note_pad/note_data_base.dart';
import 'package:note_pad/pages/editor_screen.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    super.key,
    required this.nId,
    required this.refreshUIOnUpdate,
  });
  final void Function() refreshUIOnUpdate;
  final int nId;
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final NoteDataBase dbConn = NoteDataBase();
  Note? _note;
  @override
  void initState() {
    super.initState();
    dbConn.getNote(widget.nId).then((value) {
      _note = value;
      setState(() => {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              icon: const Icon(Icons.edit_outlined, size: 32),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (conext) => EditorScreen(
                      note: _note,
                      refreshUI: widget.refreshUIOnUpdate,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _note?.title ?? "",
              style: const TextStyle(fontSize: 38, color: Color(0xFFD6D6D6)),
            ),
            const SizedBox(height: 10),
            Text(
              _note?.content ?? "",
              style: const TextStyle(fontSize: 28, color: Color(0xFFD6D6D6)),
            ),
          ],
        ),
      ),
    );
  }
}
