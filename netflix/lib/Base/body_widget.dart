import 'package:flutter/material.dart';
import 'package:netflix/config/Result.dart';
import 'package:netflix/Screen/DetailMovie/detail_movie_bloc.dart';
import 'package:netflix/Screen/DetailMovie/detail_state.dart';
import 'package:netflix/config/Result.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

abstract class ResponseWidget<T> {

  final BuildContext context;
  final BehaviorSubject<Result<T>> stream;

  ResponseWidget(this.context, this.stream);

  StreamBuilder getBuilder() {
    return StreamBuilder(
        stream: stream,
        builder: (context, itemSnapShot) {
          if (!itemSnapShot.hasData) {
            return Container();
          } else if (itemSnapShot.data is Loading &&
              (itemSnapShot.data as Loading).isLoading == true) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (itemSnapShot.data is ErrorState) {
            return getErrorWidget((itemSnapShot.data as ErrorState).error.message ?? "");
          } else if (itemSnapShot.data is SuccessState<T>) {
            return generateResponseBody((itemSnapShot.data as SuccessState<T>).value);
          } else {
            return Container();
          }
        }
    );
  }

  Widget generateResponseBody(T data);

  Widget getErrorWidget(String mes) {
    return Text(
      "$mes",
      style: TextStyle(
        color: Colors.red,
        fontSize: 25,
      ),
    );
  }
}