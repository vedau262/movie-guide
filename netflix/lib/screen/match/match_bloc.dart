import 'package:flutter/cupertino.dart';
import 'package:netflix/base/base_bloc.dart';
import 'package:netflix/base/log.dart';
import 'package:rxdart/rxdart.dart';

@immutable
abstract class MatchAction {}

class SetMatchAction extends MatchAction {
  final int vietnam;
  final int indo;
  SetMatchAction(this.vietnam, this.indo);
}

class MatchBloc extends BaseBloc {
  //Input
  final PublishSubject<MatchAction> action = PublishSubject<MatchAction>();
  final BehaviorSubject<int> vietnam = BehaviorSubject<int>.seeded(0);
  final BehaviorSubject<int> indo = BehaviorSubject<int>.seeded(0);

  @override
  void dispose() {
    super.dispose();
    action.close();
  }

  MatchBloc(){
    action.listen((MatchAction event) {
      if(event is SetMatchAction){
        logDebug("MatchAction ${event.vietnam} ${event.indo}");
        vietnam.value = event.vietnam;
        indo.value = event.indo;
      }
    });
  }
}