// To parse this JSON data, do
//
//     final placesResponse = placesResponseFromJson(jsonString);

// To parse this JSON data, do
//
//     final placesResponse = placesResponseFromJson(jsonString);

import 'dart:convert';

PlacesResponse placesResponseFromJson(String str) =>
    PlacesResponse.fromJson(json.decode(str));

String placesResponseToJson(PlacesResponse data) => json.encode(data.toJson());

class PlacesResponse {
  PlacesResponse({
    this.type,
    //this.query,
    this.features,
    this.attribution,
  });

  String? type;
  //List<String>? query;
  List<Feature>? features;
  String? attribution;

  factory PlacesResponse.fromJson(Map<String, dynamic> json) => PlacesResponse(
        type: json["type"],
        //query: List<String>.from(json["query"].map((x) => x())),
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
        attribution: json["attribution"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        //"query": List<dynamic>.from(query!.map((x) => x)),
        "features": List<dynamic>.from(features!.map((x) => x.toJson())),
        "attribution": attribution,
      };
}

class Feature {
  Feature({
    this.id,
    this.type,
    this.placeType,
    //this.relevance,
    this.properties,
    this.textEs,
    this.placeNameEs,
    this.text,
    this.placeName,
    this.center,
    this.geometry,
    this.context,
  });

  String? id;
  String? type;
  List<String>? placeType;
  //int? relevance;
  Properties? properties;
  String? textEs;
  String? placeNameEs;
  String? text;
  String? placeName;
  List<double>? center;
  Geometry? geometry;
  List<Context>? context;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        //relevance: json["relevance"],
        properties: Properties.fromJson(json["properties"]),
        textEs: json["text_es"],
        placeNameEs: json["place_name_es"],
        text: json["text"],
        placeName: json["place_name"],
        center: List<double>.from(json["center"].map((x) => x.toDouble())),
        geometry: Geometry.fromJson(json["geometry"]),
        context:
            List<Context>.from(json["context"].map((x) => Context.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType!.map((x) => x)),
        //"relevance": relevance,
        "properties": properties!.toJson(),
        "text_es": textEs,
        "place_name_es": placeNameEs,
        "text": text,
        "place_name": placeName,
        "center": List<dynamic>.from(center!.map((x) => x)),
        "geometry": geometry!.toJson(),
        "context": List<dynamic>.from(context!.map((x) => x.toJson())),
      };
}

class Context {
  Context({
    this.id,
    this.textEs,
    this.text,
    this.wikidata,
    this.languageEs,
    this.language,
    this.shortCode,
  });

  String? id;
  String? textEs;
  String? text;
  String? wikidata;
  String? languageEs;
  String? language;
  String? shortCode;

  factory Context.fromJson(Map<String, dynamic> json) => Context(
        id: json["id"],
        textEs: json["text_es"],
        text: json["text"],
        wikidata: json["wikidata"] ?? '',
        languageEs: json["language_es"] ?? '',
        language: json["language"] ?? '',
        shortCode: json["short_code"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text_es": textEs,
        "text": text,
        "wikidata": wikidata ?? '',
        "language_es": languageEs ?? '',
        "language": language ?? '',
        "short_code": shortCode ?? '',
      };
}

class Geometry {
  Geometry({
    this.type,
    this.coordinates,
  });

  String? type;
  List<double>? coordinates;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates!.map((x) => x)),
      };
}

class Properties {
  Properties({
    this.accuracy,
  });

  String? accuracy;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        accuracy: json["accuracy"],
      );

  Map<String, dynamic> toJson() => {
        "accuracy": accuracy,
      };
}

/*
import 'dart:convert';

PlacesResponse placesResponseFromJson(String str) =>
    PlacesResponse.fromJson(json.decode(str));

String placesResponseToJson(PlacesResponse data) => json.encode(data.toJson());

class PlacesResponse {
  PlacesResponse({
    this.type,
    //this.query,
    this.features,
    this.attribution,
  });

  String? type;
  //List<String>? query;
  List<Feature>? features;
  String? attribution;

  factory PlacesResponse.fromJson(Map<String, dynamic> json) => PlacesResponse(
        type: json["type"],
        //query: List<String>.from(json["query"].map((x) => x())),
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
        attribution: json["attribution"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        //"query": List<dynamic>.from(query!.map((x) => x)),
        "features": List<dynamic>.from(features!.map((x) => x.toJson())),
        "attribution": attribution,
      };
}

class Feature {
  Feature({
    this.id,
    this.type,
    this.placeType,
    //this.relevance,
    this.properties,
    this.textEs,
    this.placeNameEs,
    this.text,
    this.placeName,
    this.center,
    this.geometry,
    this.context,
  });

  String? id;
  String? type;
  List<String>? placeType;
  //int? relevance;
  Properties? properties;
  String? textEs;
  String? placeNameEs;
  String? text;
  String? placeName;
  List<double>? center;
  Geometry? geometry;
  List<Context>? context;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        properties: Properties.fromMap(json["properties"]),
        textEs: json["text_es"],
        // languageEs: json["language_es"] == null ? null : languageValues.map[json["language_es"]],
        placeNameEs: json["place_name_es"],
        text: json["text"],
        language: json["language"],
        placeName: json["place_name"],
        matchingText: json["matching_text"],
        matchingPlaceName: json["matching_place_name"],
        center: List<double>.from(json["center"].map((x) => x.toDouble())),
        geometry: Geometry.fromMap(json["geometry"]),
        context: List<Context>.from(json["context"].map((x) => Context.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType.map((x) => x)),
        "properties": properties.toMap(),
        "text_es": textEs,
        // "language_es": languageEs == null ? null : languageValues.reverse[languageEs],
        "place_name_es": placeNameEs,
        "text": text,
        "language": language,
        "place_name": placeName,
        "matching_text": matchingText,
        "matching_place_name": matchingPlaceName,
        "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toMap(),
        "context": List<dynamic>.from(context.map((x) => x.toMap())),
    };

    @override
  String toString() {
    return 'Featureeee: $text';
  }
}

class Context {
    Context({
        required this.id,
        required this.textEs,
        required this.text,
        required this.wikidata,
        // required this.languageEs,
        required this.language,
        required this.shortCode,
    });

    final String id;
    final String textEs;
    final String text;
    final String? wikidata;
    // final Language? languageEs;
    final String? language;
    final String? shortCode;

    factory Context.fromJson(String str) => Context.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Context.fromMap(Map<String, dynamic> json) => Context(
        id: json["id"],
        textEs: json["text_es"],
        text: json["text"],
        wikidata: json["wikidata"],
        // languageEs: json["language_es"],
        language: json["language"],
        shortCode: json["short_code"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "text_es": textEs,
        "text": text,
        "wikidata": wikidata,
        // "language_es": languageEs == null ? null : languageValues.reverse[languageEs],
        "language": language,
        "short_code": shortCode,
    };
}

class Geometry {
    Geometry({
        required this.coordinates,
        required this.type,
    });

    final List<double> coordinates;
    final String type;

    factory Geometry.fromJson(String str) => Geometry.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Geometry.fromMap(Map<String, dynamic> json) => Geometry(
        coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        type: json["type"],
    );

    Map<String, dynamic> toMap() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "type": type,
    };
}

class Properties {
    Properties({
        required this.wikidata,
        required this.category,
        required this.landmark,
        required this.address,
        required this.foursquare,
        required this.maki,
    });

    final String? wikidata;
    final String? category;
    final bool? landmark;
    final String? address;
    final String? foursquare;
    final String? maki;

    factory Properties.fromJson(String str) => Properties.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Properties.fromMap(Map<String, dynamic> json) => Properties(
        wikidata: json["wikidata"],
        category: json["category"],
        landmark: json["landmark"],
        address: json["address"],
        foursquare: json["foursquare"],
        maki: json["maki"],
    );

    Map<String, dynamic> toMap() => {
        "wikidata": wikidata,
        "category": category,
        "landmark": landmark,
        "address": address,
        "foursquare": foursquare,
        "maki": maki,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap ??= map.map((k, v) => MapEntry(v, k));
        return reverseMap!;
    }
}

*/

/*
import 'dart:convert';

class PlacesResponse {
    PlacesResponse({
       required this.type,
       required this.query,
       required this.features,
       required this.attribution,
    });

    String type;
    List<double> query;
    List<Feature> features;
    String attribution;

    factory PlacesResponse.fromJson(String str) => PlacesResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PlacesResponse.fromMap(Map<String, dynamic> json) => PlacesResponse(
        type: json["type"],
        query: List<double>.from(json["query"].map((x) => x.toDouble())),
        features: List<Feature>.from(json["features"].map((x) => Feature.fromMap(x))),
        attribution: json["attribution"],
    );

    Map<String, dynamic> toMap() => {
        "type": type,
        "query": List<dynamic>.from(query.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toMap())),
        "attribution": attribution,
    };
}

class Feature {
    Feature({
       required this.id,
       required this.type,
       required this.placeType,
       required this.relevance,
       required this.properties,
       required this.textEs,
       required this.placeNameEs,
       required this.text,
       required this.placeName,
       required this.center,
       required this.geometry,
       required this.context,
    });

    String id;
    String type;
    List<String> placeType;
    int relevance;
    Properties properties;
    String textEs;
    String placeNameEs;
    String text;
    String placeName;
    List<double> center;
    Geometry geometry;
    List<Context> context;

    factory Feature.fromJson(String str) => Feature.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Feature.fromMap(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        relevance: json["relevance"],
        properties: Properties.fromMap(json["properties"]),
        textEs: json["text_es"],
        placeNameEs: json["place_name_es"],
        text: json["text"],
        placeName: json["place_name"],
        center: List<double>.from(json["center"].map((x) => x.toDouble())),
        geometry: Geometry.fromJson(json["geometry"]),
        context:
            List<Context>.from(json["context"].map((x) => Context.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType!.map((x) => x)),
        //"relevance": relevance,
        "properties": properties!.toJson(),
        "text_es": textEs,
        "place_name_es": placeNameEs,
        "text": text,
        "place_name": placeName,
        "center": List<dynamic>.from(center!.map((x) => x)),
        "geometry": geometry!.toJson(),
        "context": List<dynamic>.from(context!.map((x) => x.toJson())),
      };
}

class Context {
  Context({
    this.id,
    this.textEs,
    this.text,
    this.wikidata,
    this.languageEs,
    this.language,
    this.shortCode,
  });

  String? id;
  String? textEs;
  String? text;
  String? wikidata;
  String? languageEs;
  String? language;
  String? shortCode;

  factory Context.fromJson(Map<String, dynamic> json) => Context(
        id: json["id"],
        textEs: json["text_es"],
        text: json["text"],
        wikidata: json["wikidata"] == null ? null : json["wikidata"],
        languageEs: json["language_es"] == null ? null : json["language_es"],
        language: json["language"] == null ? null : json["language"],
        shortCode: json["short_code"] == null ? null : json["short_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text_es": textEs,
        "text": text,
        "wikidata": wikidata == null ? null : wikidata,
        "language_es": languageEs == null ? null : languageEs,
        "language": language == null ? null : language,
        "short_code": shortCode == null ? null : shortCode,
      };
}

class Geometry {
  Geometry({
    this.type,
    this.coordinates,
  });

  String? type;
  List<double>? coordinates;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates!.map((x) => x)),
      };
}

class Properties {
  Properties({
    this.accuracy,
  });

  String? accuracy;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        accuracy: json["accuracy"],
      );

  Map<String, dynamic> toJson() => {
        "accuracy": accuracy,
      };
}
*/