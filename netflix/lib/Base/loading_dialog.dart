import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future _showLoadingDialog(BuildContext c, LoadingDialog loading,
    {bool cancelable = true}) =>
    showDialog(
        context: c,
        barrierDismissible: cancelable,
        builder: (BuildContext c) => loading);


class LoadingDialog extends CupertinoAlertDialog {
  final BuildContext parentContext;
  BuildContext? currentContext;
  bool showing = false;
  static LoadingDialog? _singleton;


  LoadingDialog(this.parentContext);

  static show(BuildContext context) {
    if (_singleton == null) {
      _singleton = LoadingDialog(context);
      _singleton?.showing = true;
    }

    if (_singleton != null) {
      _showLoadingDialog(context, _singleton!).then((_) {
        _singleton?.showing = false;
      });
    }
  }
  static hide() {
    print("AAAAAAAAAAAAAAAAAAAAAA ${_singleton}");
    print("AAAAAAAAAAAAAAAAAAAAAA ${_singleton?.showing}");
    print("AAAAAAAAAAAAAAAAAAAAAA ${_singleton?.parentContext}");
    if (_singleton != null && _singleton?.showing == true && _singleton?.parentContext != null) {
      print("AAAAAAAAAAAAAAAAAAAAAA");
      Navigator.removeRoute(_singleton!.parentContext, ModalRoute.of(_singleton!.currentContext!)!);
      _singleton = null;
    }
  }
  @override
  Widget build(BuildContext context) {
    currentContext = context;
    return WillPopScope(
      onWillPop: () => Future.value(true),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Center(
            child: Container(
              width: 120,
              height: 120,
              child: CupertinoPopupSurface(
                child: Semantics(
                  namesRoute: true,
                  scopesRoute: true,
                  explicitChildNodes: true,
                  child: const Center(
                    child: CupertinoActivityIndicator(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}