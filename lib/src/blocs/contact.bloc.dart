import 'package:golsat_flutter_poc_app/src/models/contact.model.dart';
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

  postContact(Contact contact) async {
    /*Contact contact2 = */await _repository.postContact(contact);
  }

  dispose() {
    _contactsFetcher.close();
  }
}

final bloc = ContactBloc();