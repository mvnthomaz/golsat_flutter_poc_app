import 'dart:io';

import 'package:golsat_flutter_poc_app/src/models/contact.model.dart';
import 'package:golsat_flutter_poc_app/src/models/result_image.model.dart';
import 'package:golsat_flutter_poc_app/src/shared/constants.dart';
import 'package:http/http.dart' show Client, MultipartRequest;
import 'package:http/http.dart';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:path/path.dart';


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

  Future<ResultImage> postImage(File image) async {
    Map<String, String> headers = {'Authorization': 'Client-ID 5887073169dd317'};

    final multipartRequest = MultipartRequest('POST', Uri.parse(URL_IMAGE_API + "/image"));
    multipartRequest.headers.addAll(headers);
    final stream = new ByteStream(DelegatingStream.typed(image.openRead()));
    final length = await image.length();
    multipartRequest.files.add(new MultipartFile('image', stream, length,
        filename: basename(image.path)));
    await multipartRequest.send().then((result) async {

      Response.fromStream(result)
          .then((response) {

        if (response.statusCode == 200) {
          ResultImage resultImage = ResultImage.fromJson(json.decode(response.body));
          return resultImage;
        }
        return null;
      });
    }).catchError((err) => print('error : '+err.toString()))
        .whenComplete(()
    {});
    return null;
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