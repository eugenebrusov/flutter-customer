
import 'package:customer/data/model/credentials.dart';
import 'package:customer/data/model/resource.dart';
import 'package:customer/data/source/repository.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final Repository _repository;

  final PublishSubject<void> requestSubject = PublishSubject();

  LoginBloc._(this._repository);

  factory LoginBloc(Repository repository) {
    return LoginBloc._(repository);
  }

  Stream<Resource<void>> testStream() => requestSubject
      .switchMap((value) {
        Credentials credentials = Credentials('966566888865', '206650');
        return _repository.login(credentials)
            .asStream()
            .map((event) => Resource.success())
            .onErrorReturnWith((error) => Resource.error())
            .startWith(Resource.loading());
      });

  void dispose() {
    requestSubject.close();
  }
}