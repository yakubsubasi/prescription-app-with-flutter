import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:recete_app/Model/Recete.dart';

class Services {

    static Future<List<Recete>?>  getRecete() async {
      try {

        final String jsonString = await rootBundle.loadString('assets/recete.json');
        final jsonResponse = json.decode(jsonString);
        final List <Recete> receteler = (jsonResponse as List).map((recete) => Recete.fromJson(recete)).toList();
        return receteler;
      } on PlatformException {
        return null;
      }


    }} 