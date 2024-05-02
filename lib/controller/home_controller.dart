import 'dart:convert';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

import '../config/api_route.dart';
class HomeController extends GetxController {

  final imageData = [].obs;
  final page = 1.obs;
  final isLoading = false.obs;
  RxString searchValue = "".obs;

  Future<void> fetchData({String? query}) async {
    if (!isLoading.value) {
      isLoading.value = true;
      update();
      try{
        final response = await http.get(Uri.parse(
            '${APIEndpoints.appApiBaseUrl}?key=43678131-fd4adea993169a75ed92157d6&q=$query&image_type=photo&page=$page&per_page=20'));

        if (response.statusCode == 200) {
          if(page.value == 1){
            imageData.clear();
            var data = json.decode(response.body)['hits'];
            imageData.addAll(data);
            page.value++;
            isLoading.value = false;
            update();
          } else{
            var data = json.decode(response.body)['hits'];
            imageData.addAll(data);
            page.value++;
            isLoading.value = false;
            update();
          }
        } else {
          throw Exception('Failed to load images');
        }
      } catch(e){
        throw Exception('Error: $e');
      }
    }
  }
}