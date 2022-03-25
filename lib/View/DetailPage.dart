import 'package:flutter/material.dart';
import 'package:recete_app/Model/Recete.dart';

class DetailPage extends StatelessWidget {
  final Recete recete;

  const DetailPage({required this.recete});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
 
      body: Container(child: Row(children: [buildPrescriptionTitle(),],),)
      
    );
  }

  Widget buildPrescriptionTitle() {
  return Container(
    margin: EdgeInsets.fromLTRB(32, 112, 32, 32),
    child: Text(
      recete.name ?? "",
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    )  );
}






}

