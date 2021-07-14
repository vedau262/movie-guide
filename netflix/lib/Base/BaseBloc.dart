import 'package:flutter/cupertino.dart';
import 'package:netflix/Config/Result.dart';
import 'package:rxdart/rxdart.dart';


class BaseMessage {
  final Error? error;

  BaseMessage.error(this.error);
}

typedef FunctionType<T> = T Function();
class BaseBloc {
  final BehaviorSubject<bool> isLoading = BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<ErrorState> error = BehaviorSubject<ErrorState>();
  void dispose() {
    isLoading.close();
    error.close();
  }
}
