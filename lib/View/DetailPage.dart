import 'package:flutter/material.dart';
import 'package:recete_app/Model/Recete.dart';

class DetailPage extends StatelessWidget {
  final Recete recete;

  const DetailPage({required this.recete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recete.name?? ""),
      ),
      body: Center(
        child: Text(recete.recete?? ""),
      ),
    );
  }
}