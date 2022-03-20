import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:recete_app/Model/Recete.dart';
import 'package:recete_app/Model/Service.dart';



class MainPage extends StatefulWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  List<Recete> _receteler =[];

  @override
  void  initState() {
    super.initState();
    Services.getRecete().then((receteler) {
      setState(() {
        _receteler = receteler!;
      });
    
    });
}


void filterSearchResult(String? query) {}



  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("ReçetApp"),centerTitle: true,), body: Container(child: Column(
      children: [buildSearcBar(),
        PrescriptionsListView(receteler: _receteler),
      ],
    )),);
      

  }

  Padding buildSearcBar() {
    return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Expanded(
          child: TextField(onChanged: (value) {}, decoration: InputDecoration(
            hintText: "Ara",
            prefix: Icon(Icons.search),
            
            
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
          ),),
        ), Padding(
          padding: const EdgeInsets.all(8.0),
          child:  Card(child: IconButton(icon: Icon(Icons.filter_alt_sharp) ,onPressed: () {},)) ),
       
       
      
      ],
    ),
  );
  }
}
 
   

   


class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(onChanged: (value) {}, decoration: InputDecoration(
              hintText: "Ara",
              prefix: Icon(Icons.search),
              
              
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
            ),),
          ), Padding(
            padding: const EdgeInsets.all(8.0),
            child:  IconButton(icon: Icon(Icons.filter) ,onPressed: () {},) ),
         
         
        
        ],
      ),
    );
  }
}



class PrescriptionsListView extends StatelessWidget {
  const PrescriptionsListView({
    Key? key,
    required List<Recete>? receteler,
  }) : _receteler = receteler, super(key: key);

  final List<Recete>? _receteler;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailPage(recete: 
                _receteler![index],)),
              );
            },
          title: Text(_receteler![index].name ?? ""),
          subtitle: Text(_receteler![index].recete ?? ""),
        );
      }, itemCount: _receteler?.length ?? 0,),
    );
  }
}

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