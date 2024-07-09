import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

import 'package:marcacion_facial_ekuasoft_app/domain/domain.dart';
import 'package:marcacion_facial_ekuasoft_app/infraestructure/services/services.dart';


class TrafficService {
  final Dio _dioTraffic;
  final Dio _dioPlaces;

  final String _baseTrafficUrl = 'https://api.mapbox.com/directions/v5/mapbox';
  final String _basePlacesUrl = 'https://api.mapbox.com/geocoding/v5/mapbox.places'; //https://api.mapbox.com/geocoding/v5/mapbox.places

  TrafficService()
      : _dioTraffic = Dio()..interceptors.add(TrafficInterceptor()),
        _dioPlaces = Dio()..interceptors.add(PlacesInterceptor());

  Future<TrafficResponse> getCoorsStartToEnd(LatLng start, LatLng end) async {
    final coorsString =
        '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
    final url = '$_baseTrafficUrl/driving/$coorsString';

    final resp = await _dioTraffic.get(url);

    final data = TrafficResponse.fromMap(resp.data);

    return data;
  }

  Future<List<Feature>> getResultsByQuery(LatLng proximity, String query) async {
    try {
      if (query.isEmpty) return [];

      final url = '$_basePlacesUrl/$query.json';

      final resp = await _dioPlaces.get(url, queryParameters: {
        'proximity': '${proximity.longitude},${proximity.latitude}',
        'limit': 7
      });

      //print('Respuesta data: ${resp.data}');

      final placesResponse = PlacesResponse.fromJson(resp.data);

      return placesResponse.features!;
    } catch (e) {
      //print('Error en la búsqueda de direcciones en los mapas: $e');
      return [];
    }
  }

  Future<List<Feature>> getResultsByQueryGoogleMap(String newLocation) async {
    try {
      if (newLocation.isEmpty) return [];

      double latitud = double.parse(newLocation.split(',')[0].split(':')[1]);
      double longitud = double.parse(newLocation.split(',')[1].split(':')[1].split('}')[0]);

      List<Feature>? features = [];

      Feature objFeatures = Feature();

      List<double> lstCoordenadas = [];
      lstCoordenadas.add(longitud);
      lstCoordenadas.add(latitud);
      
      objFeatures = Feature(
        text: '',
        placeName: '',
        center: lstCoordenadas,
        geometry: Geometry(coordinates: lstCoordenadas)
      );

      features.add(objFeatures);

      return features;
    } catch (e) {
      return [];
    }
  }

  Future<Feature> getInformationByCoors(LatLng coors) async {
    final url = '$_basePlacesUrl/${coors.longitude},${coors.latitude}.json';
    final resp = await _dioPlaces.get(url, queryParameters: {'limit': 1});

    final placesResponse = PlacesResponse.fromJson(resp.data);

    return placesResponse.features![0];
  }


}
