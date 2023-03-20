import 'package:flutter/material.dart';
import 'package:note_pad/note_data_base.dart';
import 'package:note_pad/comon.dart';
import 'package:note_pad/model/note.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class EditorScreen extends StatefulWidget {
  EditorScreen({super.key, this.note, required this.refreshUI});
  final Note? note;
  final NoteDataBase dbConn = NoteDataBase();
  final TextEditingController textTitleController = TextEditingController();
  final TextEditingController textContentController = TextEditingController();
  final void Function() refreshUI;
  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  @override
  void initState() {
    widget.textTitleController.text = widget.note?.title ?? "";
    widget.textContentController.text = widget.note?.content ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Editor'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              icon: const Icon(Icons.save, size: 32),
              onPressed: () {
                if (widget.textContentController.text.isEmpty ||
                    widget.textTitleController.text.isEmpty) return;
                if (widget.note != null) {
                  widget.dbConn.updateNote(
                    (widget.note?.copyWith(
                      title: widget.textTitleController.text,
                      content: widget.textContentController.text,
                    ))!,
                  );
                } else {
                  widget.dbConn.addNote(
                    Note(
                      title: widget.textTitleController.text,
                      content: widget.textContentController.text,
                      date: DateTime.now().toString(),
                    ),
                  );
                }
                widget.refreshUI();
                context.showSnackBar(msg: 'The note is added.');
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: InputFieldForm(
                  textController: widget.textTitleController,
                  hitText: "Title...",
                  hintSize: 36.0,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                flex: 3,
                child: InputFieldForm(
                  textController: widget.textContentController,
                  hitText: "Type your note here...",
                  hintSize: 21.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InputFieldForm extends StatelessWidget {
  const InputFieldForm(
      {super.key,
      required this.textController,
      this.labelText = "",
      this.hitText = "",
      this.hintSize = 18.0});
  final String labelText;
  final String hitText;
  final double hintSize;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: hintSize, color: Colors.white),
      onChanged: (value) {},
      controller: textController,
      maxLines: null,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        hintText: hitText,
        hintStyle:
            TextStyle(fontSize: hintSize, color: const Color(0xFFD6D6D6)),
        border: InputBorder.none,
      ),
    );
  }
}
