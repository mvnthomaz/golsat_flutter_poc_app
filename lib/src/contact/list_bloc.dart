import 'package:golsat_flutter_poc_app/src/shared/repositories/general_api.dart';

class HomeBloc implements BlocBase {
  final GeneralAPI api;

  HomeBloc(this.api);

  final BehaviorSubject filmesController = BehaviorSubject.seeded(true);
  Sink get listIn => filmesController.sink;
  Observable<List<Filme>> get filmesStream =>
      filmesController.stream.asyncMap((v) => api.getMovies());

  @override
  void dispose() {
    filmesController.close();
  }
}