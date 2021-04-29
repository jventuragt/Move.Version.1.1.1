import 'package:flutter/material.dart';
import 'package:move_app_1/src/models/travel_history.dart';
import 'package:move_app_1/src/providers/travel_history_provider.dart';
import 'package:move_app_1/src/utils/snackbar.dart' as utils;

class ClientTravelCalificationController {
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey();
  Function refresh;

  String idTravelHistory;

  TravelHistoryProvider _travelHistoryProvider;
  TravelHistory travelHistory;

  double calification;

  Future init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;

    idTravelHistory = ModalRoute.of(context).settings.arguments as String;

    _travelHistoryProvider = new TravelHistoryProvider();

    print("ID DEL TRAVEL HISTORY: $idTravelHistory");

    getTravelHistory();
  }

  void calificate() async {
    if (calification == null) {
      utils.Snackbar.showSnackbar(
          context, key, "Por favor Califica a tu Cliente");
      return;
    }
    if (calification == 0) {
      utils.Snackbar.showSnackbar(context, key, "La Calificacion minima es 1");
      return;
    }
    Map<String, dynamic> data = {"calificationDriver": calification};

    await _travelHistoryProvider.update(data, idTravelHistory);
    Navigator.pushNamedAndRemoveUntil(context, "client/map", (route) => false);
  }

  void getTravelHistory() async {
    travelHistory = await _travelHistoryProvider.getById(idTravelHistory);
    refresh();
  }
}