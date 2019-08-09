import 'dart:io';

import 'package:golsat_flutter_poc_app/src/models/contact.model.dart';
import 'package:golsat_flutter_poc_app/src/shared/constants.dart';
import 'package:http/http.dart' show Client, Response;
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

  Future<Contact> postContact(Contact contact) async {
    final response = await client.post(URL_API + "/contacts",
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json'
        },
        body: jsonEncode(contact.toJson()));
    if( response.statusCode == 201 ) {
      Contact contactResult = Contact.fromJson(json.decode(response.body));
      return contactResult;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}