import 'package:flutter/material.dart';
import '../models/note_model.dart';

class NoteCard  extends StatelessWidget {
    final Note note;
    final VoidCallback onEdit;
    final VoidCallback onDelete;

    const NoteCard({
        super.key, 
        required this.note,
        required this.onEdit,
        required this.onDelete,
    });

    @override
    Widget build(BuildContext context) {
        return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(
                            note.title,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                            ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                            note.description,
                            style: const TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        const SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                                IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.blue),
                                    onPressed: onEdit,
                                ),
                                IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: onDelete,
                                ),
                            ],
                        )
                    ],
                ),
            ),
        );
    }
}