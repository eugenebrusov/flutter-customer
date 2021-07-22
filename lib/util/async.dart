
import 'package:flutter/widgets.dart';

typedef StreamListener<T> = void Function(T value);

class StreamListenableBuilder<T> extends StreamBuilder<T> {

  final StreamListener<T> listener;

  StreamListenableBuilder._({
    Key key,
    T initialData,
    Stream<T> stream,
    @required this.listener,
    @required AsyncWidgetBuilder<T> builder,
  }) : super(key: key, initialData: initialData, stream: stream, builder: builder);

  factory StreamListenableBuilder({
    @required Stream<T> stream,
    @required StreamListener<T> listener
  }) {
    AsyncWidgetBuilder<T> builder = (context, snapshot) {
      return Container();
    };

    return StreamListenableBuilder._(stream: stream, listener: listener, builder: builder);
  }

  @override
  AsyncSnapshot<T> afterData(AsyncSnapshot<T> current, T data) {
    listener(data);
    return super.afterData(current, data);
  }
}