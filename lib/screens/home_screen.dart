import 'package:flutter/material.dart';
import '../models/note_model.dart';
import '../widgets/note_card.dart';

class HomeScreen extends StatefulWidget {
    const HomeScreen({super.key});

    @override 
    State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    final List<Note> notes = [];

    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    
    void openNoteDialog({Note? note, int? index}) {
        if (note != null) {
            titleController.text = note.title;
            descriptionController.text = note.description;
        } else {
            titleController.clear();
            descriptionController.clear();
        }

        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                title: Text(note = null ?  'Add Note' : 'Edit Note'),
                content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                        TextField(
                            controller: titleController,
                            decoration: const InputDecoration(labelText: 'Title'),
                        ),
                        TextField(
                            controller: descriptionController,
                            decoration: const InputDecoration(labelText: 'Description'),
                        ),
                    ],
                ),
                actions: [
                    TextButton(
                        onPressed: () => Naviagtor.pop(context),
                        child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                        onPressed: () {
                            if (note == null) {
                                setState(() {
                                    notes.add(
                                        Note(
                                            title: titleController.text,
                                            description: descriptionController.text,
                                        );
                                    );
                                }); 
                            } else {
                                setState(() {
                                    notes[index!] = Note(
                                        title: titleController.text,
                                        description: descriptionController.text,
                                    );
                                });
                            }
                            Naviagtor.pop(context);
                        },
                        child: const Text('Save'),
                    ),
                ],
            ),
        );
    }

    void deleteNote(int index) {
        setState(() {
            notes.removeAt(index);
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Daily Notes'),
                centerTitle: true,
            ),
            body: notes.isEmpty
                ? const Center(child: Text('No notes yet!'))
                : ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                        return NoteCard(
                            note: notes[index],
                            onEdit: () => openNoteDialog(
                                note: notes[index],
                                index: index,
                            ),
                            onDelete: () =>deleteNote(index),
                        );
                    },
                ),
            floatingActionButton: FloatingActionButton(
                onPressed: () => openNoteDialog(),
                child: const Icon(Icons.add),
            ),
        );
    }
}