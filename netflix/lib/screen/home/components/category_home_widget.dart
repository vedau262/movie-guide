import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/config/config_base.dart';
import 'package:netflix/base/extension/text_extension.dart';
import 'package:netflix/model/home_category.dart';
import 'package:netflix/screen/home/home_bloc.dart';
import 'package:netflix/screen/home/home_state.dart';
import 'package:provider/provider.dart';
import 'package:netflix/network/service/movie_category/movie_repo.dart';

class CategoryHome extends StatefulWidget {
  @override
  _CategoryHomeState createState() => _CategoryHomeState();
}

class _CategoryHomeState extends State<CategoryHome> {
  List<HomeCategory> categories = [HomeCategory.nowPlaying, HomeCategory.popular, HomeCategory.upcomming];

  @override
  void didChangeDependencies() {
    final bloc = Provider.of<HomeBloc>(context);
    bloc.action.add(GetListMovieAction(bloc.catgorySelected.value));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<HomeBloc>(context);
    return Flexible(
      flex: 0,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: Constant.DEFAULT_PADDING / 2),
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => buildCategory(index, context, bloc),
        ),
      ),
    );
  }

  Widget buildCategory(int index, BuildContext context, HomeBloc bloc) {
    return StreamBuilder<HomeCategory>(
        stream: bloc.catgorySelected,
        builder: (context, stateData) {
          var catgorySelected = stateData.data;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: Constant.DEFAULT_PADDING),
            child: GestureDetector(
              onTap: () {
                bloc.action.add(GetListMovieAction(categories[index]));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextExt.defaultText(categories[index].title(), categories[index].title() == catgorySelected?.title()
                      ? Colors.red
                      : Colors.black, FontWeight.bold, 17),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: Constant.DEFAULT_PADDING / 2),
                    height: 6,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: categories[index].title() == catgorySelected?.title()
                          ? Colors.red
                          : Colors.transparent,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}