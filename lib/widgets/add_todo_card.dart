import 'package:flutter/material.dart';
import '../models/todo.dart';

class AddTodoCard extends StatefulWidget {
  final Function(Todo) onAdd;

  const AddTodoCard({super.key, required this.onAdd});

  @override
  State<AddTodoCard> createState() => _AddTodoCardState();
}

class _AddTodoCardState extends State<AddTodoCard> {
  final TextEditingController titleController = TextEditingController();
  Priority priority = Priority.low;
  DateTime selectedDate = DateTime.now();

  Future<void> pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() => selectedDate = pickedDate);
    }
  }

  void submit() {
    if (titleController.text.trim().isEmpty) return;

    widget.onAdd(
      Todo(
        title: titleController.text.trim(),
        date: selectedDate,
        priority: priority,
      ),
    );

    titleController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            Row(
              children: [
                const Icon(Icons.add_task_rounded),
                const SizedBox(width: 8),
                Text(
                  'Add New Task',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// TASK TITLE
            TextField(
              controller: titleController,
              decoration: InputDecoration(
              
                labelText: 'Task title',
                hintText: 'What do you want to do?',
                filled: true,
                contentPadding: const EdgeInsets.fromLTRB(16, 22, 16, 22),
                fillColor: theme.colorScheme.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// DATE PICKER
            InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: pickDate,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Due: ${selectedDate.toLocal().toString().split(' ')[0]}',
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// PRIORITY
            DropdownButtonFormField<Priority>(
              value: priority,
              decoration: InputDecoration(
                labelText: 'Priority',
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 20,
                ),
                fillColor: theme.colorScheme.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
              items: Priority.values.map((p) {
                return DropdownMenuItem(
                  value: p,
                  child: Text(p.name.toUpperCase()),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => priority = value!);
              },
            ),

            const SizedBox(height: 20),

            /// ADD BUTTON
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: submit,
                icon: const Icon(Icons.add),
                label: const Text('Add Task'),
                
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
