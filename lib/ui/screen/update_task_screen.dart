import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/models/network_response.dart';
import '../../data/service/network_caller.dart';
import '../../data/utils/urls.dart';

class UpdateTaskSheet extends StatefulWidget {
  const UpdateTaskSheet({
    super.key,
    required TextEditingController titleController,
    required TextEditingController descriptionController,
    required this.onUpdate,
  })  : _titleController = titleController,
        _descriptionController = descriptionController;

  final TextEditingController _titleController;
  final TextEditingController _descriptionController;

  final VoidCallback onUpdate;

  @override
  State<UpdateTaskSheet> createState() => _UpdateTaskSheetState();
}

class _UpdateTaskSheetState extends State<UpdateTaskSheet> {
  bool updateProgres = false;
  Future<void> updateTask() async {
    updateProgres = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestBody = {
      "title": widget._titleController.text.trim(),
      "description": widget._descriptionController.text.trim(),
    };
    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.createTask, requestBody);

    updateProgres = false;
    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      widget._titleController.clear();
      widget._descriptionController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Task update successfully')));
      }
      widget.onUpdate();
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Task update failed!')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Update task',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: widget._titleController,
                decoration: const InputDecoration(hintText: 'Title'),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: widget._descriptionController,
                maxLines: 10,
                decoration: const InputDecoration(
                  hintText: 'Description',
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    updateTask();
                  },
                  // child: Text("Update"),
                  child: updateProgres
                      ? const CupertinoActivityIndicator(
                          color: Colors.white,
                          radius: 13.0,
                        )
                      : const Icon(Icons.arrow_circle_right_outlined),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
