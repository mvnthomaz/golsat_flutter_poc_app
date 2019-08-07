import 'package:golsat_flutter_poc_app/src/models/contact.model.dart';
import 'package:golsat_flutter_poc_app/src/provider/api.provider.dart';

class ContactRepository {
  final contactsApiProvider = ContactApiProvider();

  Future<List<Contact>> fetchAllContacts() => contactsApiProvider.fetchContactList();
  Future<Contact> postContact(Contact contact) => contactsApiProvider.postContact(contact);
}
