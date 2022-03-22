import 'package:flutter/material.dart';
import 'package:recete_app/Model/Recete.dart';
import 'package:recete_app/Model/Service.dart';
import 'package:recete_app/View/DetailPage.dart';
import 'package:recete_app/Widgets/SearchWidget.dart';



class MainPage extends StatefulWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {


  String query = '';
  List<Recete> _receteler =[];
 late  List<Recete> _tumReceteler = [];

  @override
  void  initState() {
    super.initState();
    Services.getRecete().then((receteler) {
      setState(() {
        _tumReceteler = receteler!;
        _receteler = receteler;
      });
    
    });
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("ReçetApp"),centerTitle: true,), body: Container(child: Column(
      children: [buildSearcBar(),
        PrescriptionsListView(receteler: _receteler),
      ],
    )),);
      

  }

  void searchBook(String query) {
    final recetler = _tumReceteler.where((book) {
      final titleLower = book.name?.toLowerCase();
      
      final searchLower = query.toLowerCase();

      return titleLower?.contains(searchLower) ?? false;
    }).toList();

    setState(() {
      this.query = query;
      this._receteler = recetler;
    });
  }

  Padding buildSearcBar() {
    return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Expanded(
          child: SearchWidget(text: query, onChanged: searchBook, hintText: "Ara")
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
