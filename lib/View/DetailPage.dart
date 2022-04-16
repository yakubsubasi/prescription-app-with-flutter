import 'package:flutter/material.dart';
import 'package:recete_app/Model/Recete.dart';

class DetailPage extends StatelessWidget {
  final Recete recete;

  const DetailPage({required this.recete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.amber[300]),
        backgroundColor: Colors.amber[50],
        body: Container(
          child: ListView(
            children: [buildPrescriptionTitle(), buildPrescriptionDetail()],
          ),
        ));
  }

  Widget buildPrescriptionTitle() {
    return Container(
        margin: EdgeInsets.fromLTRB(32, 112, 32, 32),
        child: Text(
          recete.name ?? "",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ));
  }

  Widget buildPrescriptionDetail() {
    return Card(
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          // ignore: prefer_const_constructors
          Text(
            "Rp",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          const SizedBox(height: 25),
          Column(
            children: List.generate(
                recete.medicines?.length ?? 0,
                (index) => Column(
                  children: [
                    Text(
                          "${index + 1}- ${recete.medicines?[index]}" ?? "",
                          style: TextStyle(fontSize: 19),
                        ), SizedBox(height: 10,)
                  ],
                )),
            crossAxisAlignment: CrossAxisAlignment.start,
          )
        ], crossAxisAlignment: CrossAxisAlignment.start),
      ),
    );
  }
}
