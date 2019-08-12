import 'dart:io';

import 'package:golsat_flutter_poc_app/src/models/contact.model.dart';
import 'package:golsat_flutter_poc_app/src/models/result_image.model.dart';
import 'package:golsat_flutter_poc_app/src/repositories/contact.repository.dart';
import 'package:rxdart/rxdart.dart';

class ContactBloc {
  final _repository  = ContactRepository();
  final _contactsFetcher = PublishSubject<List<Contact>>();

  Observable<List<Contact>> get allContacts => _contactsFetcher.stream;

  fetchAllContacts() async {
    List<Contact> contact = await _repository.fetchAllContacts();
    _contactsFetcher.sink.add(contact);
  }

  Future<ResultImage> postImage(File image) async => _repository.postImage(image);
  Future<Contact> postContact(Contact contact) async => _repository.postContact(contact);

  dispose() {
    _contactsFetcher.close();
  }
}

final bloc = ContactBloc();