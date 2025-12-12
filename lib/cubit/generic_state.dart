import 'package:flutter/foundation.dart';

@immutable
abstract class GenericState<T> {}

class GenericInitial<T> extends GenericState<T> {}

class GenericLoading<T> extends GenericState<T> {}

class GenericLoaded<T> extends GenericState<T> {
  final T? data;

  GenericLoaded(this.data);
}

class GenericEmpty<T> extends GenericState<T> {}

class GenericLoadedList<T> extends GenericState<T> {
  final List<T> data;

  GenericLoadedList(this.data);
}

class GenericError<T> extends GenericState<T> {
  final String errorMessage;

  GenericError(this.errorMessage);
}
