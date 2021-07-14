import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'BaseBloc.dart';


class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key, required this.bloc}) : super(key: key);

  final BaseBloc bloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: bloc.isLoading,
      builder: (context, state) {
        var isLoading = state.data;
        if (isLoading ?? true) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Container();
        }
      },
    );
  }
}