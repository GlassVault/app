import 'package:black_vault/main.dart';
import 'package:black_vault/ui/screen/drawer.dart';
import 'package:flutter/material.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({Key? key}) : super(key: key);

  @override
  _DocumentsScreenState createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: VaultDrawer(),
      primary: true,
      appBar: AppBar(
        title: GradientText(
          "Documents",
          gradient: RadialGradient(
              colors: Grad.sol, center: Alignment(2.5, 0), radius: 12),
        ),
      ),
      body: Center(child: Text("Documents go here")),
    );
  }
}
