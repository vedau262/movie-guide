import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:netflix/config/constants.dart';
import 'package:netflix/model/contact.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:netflix/model/favourite.dart';
import 'package:netflix/model/movie.dart';
import 'package:netflix/utilities.dart';

class FavouritePage extends StatefulWidget {
  FavouritePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  FavouriteState createState() => FavouriteState();
}

class FavouriteState extends State<FavouritePage> {
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
                 else return Container(child: _buildListView());
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
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 20),
            child: ValueListenableBuilder(
              valueListenable: Hive.box<Movie>(hiveMovieFileName).listenable(),
              builder: (context, Box<Movie> box, _) {
                if (box.values.isEmpty) {
                  return Text('data is empty');
                } else {
                  // return Text('data 2222222222222222');
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: box.values.length,
                    itemBuilder: (context, index) {
                      var movie = box.getAt(index);
                      return Container(
                        padding: EdgeInsets.all(10),
                        child:  ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            movie!.getPosterPath(),
                            width: screenWidth/2,
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
    );
  }

}