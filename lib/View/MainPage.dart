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
  List<String> _allSpecialities = [];


  @override
  void  initState() {
    super.initState();
    Services.getRecete().then((receteler) {
      setState(() {
       
       // preparing prescription lists
       
        _tumReceteler = receteler!;
        _receteler = receteler;


      // Preparing specialties list

      List<String> allSpecialitiesTemp = [];
      
      for (var recete in _tumReceteler) {
        
        allSpecialitiesTemp.addAll(recete.speciality!);
        
      }
        _allSpecialities = allSpecialitiesTemp.toSet().toList();
        _allSpecialities.insert(0, "Hepsi");

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

  void searchRecete(String query) {
    final recetler = _tumReceteler.where((recete) {
      final titleLower = recete.name?.toLowerCase();
      
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
          child: SearchWidget(text: query, onChanged: searchRecete, hintText: "Ara")
        ), Padding(
          padding: const EdgeInsets.all(8.0),
          child:  Card(child: PopupMenuButton<String>( 
            icon: const Icon(Icons.filter_alt_sharp),
  onSelected: (String result) { filterList(result); },
  itemBuilder: (BuildContext context) {
    return List.generate(_allSpecialities.length, (index) => PopupMenuItem( child: Text(_allSpecialities[index]),value: _allSpecialities[index]));
  }
  ) ),
        )
      ],
    ),
    
      
  );
  }

  void filterList(String seleceted) {

    if (seleceted == 'Hepsi') {

      setState(() {
        _receteler = _tumReceteler;
      });
      
    } else {
       final recetler = _tumReceteler.where((recete) {
     

      return recete.speciality?.contains(seleceted)?? false;
    }).toList();

    setState(() {
      _receteler = recetler;
    });
    }
  

  }

}
 
   

   
    enum WhyFarther { harder, smarter, selfStarter, tradingCharter }




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
