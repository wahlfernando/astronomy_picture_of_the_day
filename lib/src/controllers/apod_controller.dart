import 'package:astronomy_picture_of_the_day/src/models/apod_model.dart';
import 'package:astronomy_picture_of_the_day/src/utils/api_service.dart';
import 'package:flutter/material.dart';

class APODController extends ChangeNotifier {
  APIService apiService = APIService();
  List<APODModel> apods = [];
  bool isLoading = false;

  Future<void> fetchAPODs(List<String> dates) async {
    isLoading = true;
    notifyListeners();

    List<APODModel> tempApods = [];
    for (String date in dates) {
      final jsonData = await apiService.fetchAPOD(date);
      tempApods.add(APODModel.fromJson(jsonData));
    }

    apods = tempApods;
    isLoading = false;
    notifyListeners();
  }
}
