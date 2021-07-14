import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netflix/Base/toast.dart';

import 'BaseBloc.dart';
import 'loading_dialog.dart';

abstract class BaseState<V extends BaseBloc, T extends StatefulWidget> extends State<T> {

  late V bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = getBloc();
    bloc.isLoading.listen((value) {
      if (value) {
        LoadingDialog.show(context);
      } else {
        LoadingDialog.hide();
      }
    });
    bloc.error.listen((value) {
      Toast.show(value.error.message.toString(), context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.error.message ?? "Some thing went wrong!")));
    });
    initBloc();
  }

  V getBloc();

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildWidget(context);
  }

  Widget buildWidget(BuildContext context);

  void initBloc();
}