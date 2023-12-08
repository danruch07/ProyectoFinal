import 'package:flutter/material.dart';
import '../Widgets/loading_widget.dart';

class LoadingAlertDialog extends StatelessWidget {
  final String message;

  LoadingAlertDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          circularProgress(),
          const SizedBox(height: 10),
          const Text('Cargando...'),
        ],
      ),
    );
  }
}
