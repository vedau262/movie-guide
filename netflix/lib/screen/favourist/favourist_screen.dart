import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:netflix/config/constants.dart';
import 'package:netflix/model/contact.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:netflix/model/favourite.dart';
import 'package:netflix/model/movie.dart';
import 'package:netflix/screen/home/home_bloc.dart';
import 'package:netflix/screen/home/home_state.dart';
import 'package:netflix/utilities.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatefulWidget {
  FavouritePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  FavouriteState createState() => FavouriteState();
}

class FavouriteState extends State<FavouritePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
         child: Container(
           child: FutureBuilder(
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
         ),
        )
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
              padding: EdgeInsets.symmetric(vertical: 30),
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
                          padding: EdgeInsets.all(10),
                          child:  InkWell(
                            onTap: () {
                              bloc.action.add(SelectMovieAction(context, movie!));
                            },
                            child:
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                movie!.getPosterPath(),
                                width: screenWidth/2,
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