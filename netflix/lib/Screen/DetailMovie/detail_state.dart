import 'package:flutter/cupertino.dart';

abstract class DetailAction{}

class GetDetailAction extends DetailAction{
  final int movieId;
  GetDetailAction(this.movieId);
}

class PlayTrailerAction extends DetailAction{
  final String videoLink;
  PlayTrailerAction(this.videoLink){
   print("PlayTrailer: $videoLink");
  }
}

class ShowSnackBarAction extends DetailAction {
  final BuildContext context;
  final String message;
  ShowSnackBarAction(this.context, this.message);
}
