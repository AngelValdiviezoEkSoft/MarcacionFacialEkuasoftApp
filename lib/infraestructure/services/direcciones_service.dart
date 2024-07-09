import 'dart:io';

import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:marcacion_facial_ekuasoft_app/config/config.dart';

import '../../domain/domain.dart';

FeatureApp objFeatureAppService = FeatureApp();

class DireccionesService {
  
  Future<List<Feature>> getResultsByGoogle(String query, String apiKey, String nombreDireccion) async {
    try {
      List<Feature> lstFeatures = [];
      if (query.isEmpty) return [];
/*
      final direccionBusca = BlocProvider.of<SuscripcionBloc>(context);
      direccionBusca.setDireccionUsuario(value);
      */

      
      List<PlaceField> placeFields = [
        PlaceField.Address,
        PlaceField.AddressComponents,
        PlaceField.BusinessStatus,
        PlaceField.Id,
        PlaceField.Location,
        PlaceField.Name,
        PlaceField.OpeningHours,
        PlaceField.PhoneNumber,
        PlaceField.PhotoMetadatas,
        PlaceField.PlusCode,
        PlaceField.PriceLevel,
        PlaceField.Rating,
        PlaceField.Types,
        PlaceField.UserRatingsTotal,
        PlaceField.UTCOffset,
        PlaceField.Viewport,
        PlaceField.WebsiteUri,
      ];

      if(Platform.isAndroid) {
        apiKey = objFeatureAppService.apiKeyAndroid;
      }

      if(Platform.isIOS) {
        apiKey = objFeatureAppService.apiKeyIos;
      }

      final places = FlutterGooglePlacesSdk(apiKey);
      final predictions = await places.findAutocompletePredictions(query.trim());
            
      if(predictions.predictions.length - 1 > 0) {
        for(int i = 0; i < predictions.predictions.length; i++) { 
          if(predictions.predictions[i].fullText.toLowerCase().contains('ecuador')) {
            final predictions2 = await places.fetchPlace(predictions.predictions[i].placeId,fields: placeFields);
            
            final ubicacionLatLong = predictions2.place!.latLng!;
              
            double latitud = double.parse(ubicacionLatLong.toString().split(',')[0].split(':')[1]);
            double longitud = double.parse(ubicacionLatLong.toString().split(',')[1].split(':')[1].split('}')[0]);

            Feature objFeatures = Feature();

            List<double> lstCoordenadas = [];
            lstCoordenadas.add(longitud);
            lstCoordenadas.add(latitud);
            
            objFeatures = Feature(
              text: predictions.predictions[i].primaryText,
              placeName: predictions.predictions[i].secondaryText,
              center: lstCoordenadas,
              geometry: Geometry(coordinates: lstCoordenadas)
            );
            lstFeatures.add(objFeatures);
          }
        }
      }

      return lstFeatures;
    } catch (e) {
      //print('Error en la búsqueda de direcciones en los mapas: $e');
      return [];
    }
  }

    Future<Feature?> getResultsByQueryGoogleMap(String newLocation, String nombreDireccion) async {
    try {
      if (newLocation.isEmpty) return null;

      double latitud = double.parse(newLocation.split(',')[0].split(':')[1]);
      double longitud = double.parse(newLocation.split(',')[1].split(':')[1].split('}')[0]);

      List<Feature>? features = [];

      Feature objFeatures = Feature();

      List<double> lstCoordenadas = [];
      lstCoordenadas.add(longitud);
      lstCoordenadas.add(latitud);
      
      objFeatures = Feature(
        text: nombreDireccion,
        placeName: nombreDireccion,
        center: lstCoordenadas,
        geometry: Geometry(coordinates: lstCoordenadas)
      );

      features.add(objFeatures);

      return objFeatures;
    } catch (e) {
      return null;
    }
  }

}
