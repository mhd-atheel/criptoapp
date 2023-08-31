import 'dart:convert';

import 'package:criptoapp/models/dataModel.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DataServices extends GetxController {
  final dataList = <DataModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future  <void> fetchData() async {
    final jsonFile = await rootBundle.loadString('assets/json/data.json');
    List<dynamic> result = json.decode(jsonFile);
    dataList.value = result.map((data) => DataModel.fromJson(data)).toList();
    List<DataModel> temp= dataList.value;
    for (int i=0; i <temp.length;i++){
      List<double> history = [];
      temp[i].history.forEach((element) {
        history.add(element);
      });
      dataList[i].history = history;
    }
  }
}
