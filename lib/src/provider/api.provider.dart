import 'package:golsat_flutter_poc_app/src/models/contact.model.dart';
import 'package:golsat_flutter_poc_app/src/shared/constants.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

class ContactApiProvider {
  Client client = Client();

  Future<List<Contact>> fetchContactList() async {
    final response = await client
        .get(URL_API + "/contacts");
    if (response.statusCode == 200) {
      List<dynamic> responseJson = json.decode(response.body);
      return responseJson.map((m) => new Contact.fromJson(m)).toList();
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}