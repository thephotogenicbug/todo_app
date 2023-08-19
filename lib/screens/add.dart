import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo"),
      ),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        const TextField(
          decoration: InputDecoration(hintText: "Title"),
        ),
        const TextField(
          decoration: InputDecoration(hintText: "Description"),
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
}
