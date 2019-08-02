import 'package:dio/dio.dart';
import 'package:golsat_flutter_poc_app/src/shared/constants.dart';
import 'package:golsat_flutter_poc_app/src/shared/models/contact.dart';

class GeneralAPI {
  Dio dio;

  GeneralAPI() {
    dio = Dio();
    dio.options.baseUrl = URL_API;
  }

  Future<List<Contact>> getContacts() async {
    Response response = await dio.get("contacts");
    return (response as List)
        .map((contact) => Contact.fromJson(contact))
        .toList();
  }
} 