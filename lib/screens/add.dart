import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddPage extends StatefulWidget {
  final Map? todo;
  const AddPage({super.key, this.todo});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      titleController.text = title;
      descriptionController.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Todo' : "Add Todo"),
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
        ElevatedButton(
            onPressed: isEdit ? updateData : submitData,
            child: Text(isEdit ? 'Update' : "Submit"))
      ]),
    );
  }

  Future<void> submitData() async {
    // Get the data from form

    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      'title': title,
      'description': description,
      'is_completed': false,
    };

    // Submit data to the server
    const url = "https://api.nstack.in/v1/todos";
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    // show success message or fail message status
    if (response.statusCode == 201) {
      print("Creation Success");
      titleController.text = "";
      descriptionController.text = "";
      showSuccessMessage("Todo List Added Successfully");
    } else {
      print("Creation Failed");
      showErrorMessage("Failed To Add Todo List");
      print(response.body);
    }
  }

  Future<void> updateData() async {
    final todo = widget.todo;
    if (todo == null) {
      print('You cannot call without todo data');
      return;
    }
    final id = todo['_id'];
    final isCompleted = todo['is_completed'];
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      'title': title,
      'description': description,
      'is_completed': isCompleted,
    };
    final url = "https://api.nstack.in/v1/todos/$id";
    final uri = Uri.parse(url);
    final response = await http.put(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    // show success message or fail message status
    if (response.statusCode == 200) {
      titleController.text = "";
      descriptionController.text = "";
      showSuccessMessage("Todo List Updated Successfully");
    } else {
      showErrorMessage("Failed To Update Todo List");
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
