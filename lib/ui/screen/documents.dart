import 'package:flutter/material.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({Key? key}) : super(key: key);

  @override
  _DocumentsScreenState createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        title: Text("Documents"),
      ),
      body: Center(child: Text("Documents go here")),
    );
  }
}
