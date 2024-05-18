import 'package:flutter/material.dart';

class SpecificScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String? payload =
        ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
        title: Text('Specific Screen'),
      ),
      body: Center(
        child: Text('Payload: $payload'),
      ),
    );
  }
}
