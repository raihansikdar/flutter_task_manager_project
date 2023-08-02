import 'package:flutter/material.dart';

class TaskListTile extends StatelessWidget {
  final Color color;
  final String chipText;
  const TaskListTile({
    super.key,
    required this.color, required this.chipText,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Title will be here'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Title will be here'),
          const Text('Date'),
          Row(
            children: [
              Chip(
                label:  Text(
                  chipText,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: color,
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.green,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.red.shade300,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
