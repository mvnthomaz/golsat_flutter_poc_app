import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:golsat_flutter_poc_app/src/shared/models/contact.dart';
import 'package:golsat_flutter_poc_app/src/shared/repositories/general_api.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc implements BlocBase {
  final GeneralAPI api;

  HomeBloc(this.api);

  final BehaviorSubject contactsController = BehaviorSubject.seeded(true);
  Sink get listIn => contactsController.sink;
  Observable<List<Contact>> get contactsStream =>
      contactsController.stream.asyncMap((v) => api.getContacts());

  @override
  void dispose() {
    contactsController.close();
  }

  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => null;

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(listener) {
    // TODO: implement removeListener
  }
}