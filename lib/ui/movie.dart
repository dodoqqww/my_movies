import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_movies/api/api_client.dart';
import 'package:my_movies/api/entites/error.dart';
import 'package:my_movies/api/entites/movie_info.dart';
import 'package:my_movies/common/textstyles.dart';
import 'package:my_movies/models/movie.dart';
import 'package:my_movies/ui/widgets/error.dart';
import 'package:provider/provider.dart';

class Movie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Selected film"),
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: FutureBuilder<Object>(
            future: fetchMovie(context.watch<MovieModel>().selectedFilm),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data is MovieInfo) {
                  return _ResultInfo(result: snapshot.data as MovieInfo);
                } else {
                  return ErrorTextWidget(error: snapshot.data as ApiError);
                }
              }
              return Center(child: CircularProgressIndicator());
            },
          )),
    ));
  }
}

class _ResultInfo extends StatelessWidget {
  final MovieInfo result;

  const _ResultInfo({Key key, @required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("itt");
    return ListView(
      shrinkWrap: true,
      children: [
        _MainDatasCard(
          result: result,
        ),
        //some custom design
        _SubDatasCard(result: "Actors:\n\t" + result.actors),
        _SubDatasCard(result: "Awards:\n\t" + result.awards),
        _SubDatasCard(result: "Plot:\n\t" + result.plot),
        _SubDatasCard(result: "ImdbRating:\n\t" + result.imdbRating),
      ],
    );
  }
}

class _SubDatasCard extends StatelessWidget {
  const _SubDatasCard({
    Key key,
    @required this.result,
  }) : super(key: key);

  final String result;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        child: Container(padding: EdgeInsets.all(10), child: Text(result)));
  }
}

class _MainDatasCard extends StatelessWidget {
  const _MainDatasCard({
    Key key,
    @required this.result,
  }) : super(key: key);

  final MovieInfo result;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.all(10),
          child: IntrinsicHeight(
            child: Row(
              children: [
                result.poster != "N/A"
                    ? Image.network(
                        result.poster,
                        height: 200,
                        width: 150,
                      )
                    : SizedBox(
                        height: 200,
                        width: 150,
                        child: Center(
                          child: Text(
                            "N/A",
                            style: TextStyle(fontSize: 50),
                          ),
                        ),
                      ),
                VerticalDivider(
                  width: 15,
                  thickness: 2,
                  color: Theme.of(context).primaryColor,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 175,
                        child: Text(
                          result.title,
                          overflow: TextOverflow.ellipsis,
                          style: titleStyle,
                          maxLines: 4,
                        )),
                    //  Text(result.imdbID),
                    Spacer(),

                    Column(
                      children: [
                        Text(result.year, style: subStyle),
                        Text(
                          result.type.toUpperCase(),
                          style: subStyle,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
