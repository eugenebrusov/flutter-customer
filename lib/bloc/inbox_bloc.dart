
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/data/model/resource.dart';
import 'package:customer/data/source/repository.dart';
import 'package:rxdart/rxdart.dart';

class InboxBloc {

  final Repository _repository;
  final PublishSubject<void> requestSubject;
  final Stream<Resource<String>> testStream;

  InboxBloc._(this._repository, this.requestSubject, this.testStream);

  factory InboxBloc(Repository repository) {
    // ignore: close_sinks
    PublishSubject<void> requestSubject = PublishSubject();
    Stream<Resource<String>> testStream = requestSubject
        .startWith(null)
        .switchMap((_) {
          return Firestore.instance
              .collection('users')
              .document('A1IW0vY7zXuXqufN5eKu')
              .get()
              .then((DocumentSnapshot ds) {
                return Resource.success(data: ds['surname'] as String);
              })
              .asStream();
        })
        .shareReplay(maxSize: 1);
    return InboxBloc._(repository, requestSubject, testStream);
  }

  void updateTest() {
    requestSubject.add(null);
  }

  void dispose() {
    requestSubject.close();
  }
}