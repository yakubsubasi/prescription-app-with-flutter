// To parse this JSON data, do
//
//     final Recete = ReceteFromJson(jsonString);

import 'dart:convert';

List<Recete> receteFromJson(String str) => List<Recete>.from(json.decode(str).map((x) => Recete.fromJson(x)));



String receteToJson(List<Recete> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Recete {
    Recete({
        this.id,
        this.name,
        this.recete,
        this.speciality,
    });

    String? id;
    String? name;
    String? recete;
    List<String>? speciality;

    factory Recete.fromJson(Map<String, dynamic> json) => Recete(
        id: json["id"],
        name: json["name"],
        recete: json["recete"],
        speciality: List<String>.from(json["bölümler"].map((x) => x)),
    );

    

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "recete": recete,
        "bölümler": List<dynamic>.from(speciality!.map((x) => x)),
    };
}
