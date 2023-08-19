import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo"),
      ),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        TextField(
          controller: titleController,
          decoration: const InputDecoration(hintText: "Title"),
        ),
        TextField(
          controller: descriptionController,
          decoration: const InputDecoration(hintText: "Description"),
          keyboardType: TextInputType.multiline,
          minLines: 5,
          maxLines: 8,
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(onPressed: () {}, child: const Text("Submit"))
      ]),
    );
  }

  void submitData() {
    // Get the data from form

    final title = titleController.text;
    final description = descriptionController.text;

    // Submit data to the server
    // show success message or fail message status
  }
}
