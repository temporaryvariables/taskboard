import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ColumnEdit extends StatefulWidget {
  const ColumnEdit({super.key, required this.index});

  final int index;

  @override
  State<ColumnEdit> createState() => _ColumnEditState();
}

class _ColumnEditState extends State<ColumnEdit> {
  final TextEditingController columnName = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Card(
            child: Column(
              children: [
                Text("Name"),
                TextField(
                  controller: columnName,
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.save))
              ],
            ),
          ),
        ],
      ),
    );
  }
}