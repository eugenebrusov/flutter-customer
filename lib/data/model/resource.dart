import 'package:equatable/equatable.dart';

abstract class Resource<T> extends Equatable {
  const Resource._();

  factory Resource.success({T data}) = Success<T>;
  factory Resource.loading() = Loading<T>;
  factory Resource.error({dynamic error}) = Error<T>;
}

class Success<T> extends Resource<T> {
  const Success({this.data}): super._();

  final T data;

  @override
  List<Object> get props => [T, data];

  @override
  String toString() => 'Success{data: $data}';
}

class Loading<T> extends Resource<T> {
  const Loading(): super._();

  @override
  List<Object> get props => [T];
}

class Error<T> extends Resource<T> {
  const Error({this.error}): super._();

  final dynamic error;

  @override
  List<Object> get props => [T];
}