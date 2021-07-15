
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/cupertino.dart';

class BaseProvider with ChangeNotifier {
  CompositeSubscription compositeSubscription = CompositeSubscription();
  addSubscription(StreamSubscription subscription) {
    compositeSubscription.add(subscription);
  }

  @override
  void dispose() {
    if (!compositeSubscription.isDisposed) {
      compositeSubscription.dispose();
    }
    super.dispose();
  }
}