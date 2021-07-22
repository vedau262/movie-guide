import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:netflix/base/permission_handler.dart';
import 'package:netflix/config/config_base.dart';
import 'package:netflix/config/constants.dart';
import 'package:netflix/model/contact.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:netflix/model/favourite.dart';
import 'package:netflix/model/movie.dart';
import 'package:netflix/screen/home/home_bloc.dart';
import 'package:netflix/screen/home/home_state.dart';
import 'package:netflix/utilities.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../theme_bloc.dart';

class FavouritePage extends StatefulWidget {
  FavouritePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  FavouriteState createState() => FavouriteState();
}

class FavouriteState extends State<FavouritePage> {
  static const platform = const MethodChannel(favouriteChannelName);
  static const EventChannel eventChannel = EventChannel(CHARGING_CHANNEL);
  String _batteryLevel = 'No data';
  String _chargingStatus = 'Battery status: unknown.';
  bool _readWritePermission = false;

  Future<void> _getBatteryLevel()  async {
    logDebug("_getBatteryLevel");
    String batteryLevel ;
    try {
      final int result = await platform.invokeMethod(getBatteryLevelMethodName,{'key_put_string': 'value here'});
      logDebug("_getBatteryLevel $result");
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e){
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel =batteryLevel;
    });

  }

  Future<void> _requestPermission()  async {
    logDebug("requestPermission");
    bool isGranted = false ;
    // try {
    //   final bool result = await platform.invokeMethod(requestPermissionMethodName);
    //   logDebug("_requestPermission $result");
    //   isGranted = result;
    // } on PlatformException catch (e){
    //   isGranted = false;
    // }

    // if (await Permission.contacts.request().isGranted) {
    //   logDebug("Permission true");
    // } else {
    //   await openAppSettings();
    //   logDebug("Permission false");
    // }

     isGranted = await PermissionService().requestPermission(onPermissionDenied: () {
      openAppSettings();
    });

    setState(() {
      _readWritePermission = isGranted;
    });

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
  }

  void _onEvent(Object? event) {
    logDebug("_onEvent $event");
    setState(() {
      _chargingStatus = "Battery status: ${event == 'charging' ? '' : 'dis'}charging.";
    });
  }

  void _onError(Object error) {
    logDebug("_onError $error");
    setState(() {
      _chargingStatus = 'Battery status: unknownnnnnnnnnnnnnnnnnn.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
         child: Column(
           mainAxisSize: MainAxisSize.min,
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children :[
             SingleChildScrollView(
               scrollDirection: Axis.horizontal,
               child: Row(
                   mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children : [
                     Text(
                       _batteryLevel,
                       overflow: TextOverflow.clip,
                     ),
                     IconButton(
                       icon: Icon(Icons.refresh),
                       onPressed: () {
                         _getBatteryLevel();
                       },
                     ),
                     Text(
                       "read Write Permission: $_readWritePermission",
                       overflow: TextOverflow.ellipsis,
                     ).paddingDirection(horizontal: 20),
                     IconButton(
                       icon: Icon(Icons.get_app),
                       onPressed: ()  async{
                         _requestPermission();
                       },
                     ),
                     Text(_chargingStatus),
                   ],
               ),
             ),


             FutureBuilder(
             future: Hive.openBox<Movie>(hiveMovieFileName),
             builder: (context, snapshot) {
               if(snapshot.connectionState == ConnectionState.done){
                 if(snapshot.hasError){
                   return Container(
                     child: Text(snapshot.error.toString() ),
                   );
                 }
                 else return Center(
                     child: _buildListView());
               } else {
                 return Container(
                   child: CircularProgressIndicator(),
                 );
               }
             },
           ),
         ]
        ).marginOnly(top: 30)
        ),
    );
  }

  Widget _buildListView() {
    final bloc = Provider.of<HomeBloc>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              height: screenHeight,
              padding: EdgeInsets.only(top: 30, bottom: 56),
              child: ValueListenableBuilder(
                valueListenable: Hive.box<Movie>(hiveMovieFileName).listenable(),
                builder: (context, Box<Movie> box, _) {
                  if (box.values.isEmpty || box.values.length==0) {
                    return Center(
                      child: Text('Favorites is empty!!!',
                        style: heading1Style,
                      ),
                    );
                  } else {
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      // shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: box.values.length,
                      itemBuilder: (context, index) {
                        var movie = box.getAt(index);
                        return Container(
                          padding: EdgeInsets.all(5),
                          child:  InkWell(
                            onTap: () {
                              bloc.action.add(SelectMovieAction(context, movie!));
                            },
                            child:
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.network(
                                movie!.getPosterPath(),
                                width: screenWidth/2,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              )
          ),
        ],
      )
    );
  }

}