import 'package:flutter/material.dart';
import 'package:my_movies/api/api_client.dart';
import 'package:my_movies/api/entites/error.dart';
import 'package:my_movies/api/entites/search.dart';
import 'package:my_movies/common/textstyles.dart';
import 'package:my_movies/models/movie.dart';
import 'package:my_movies/ui/widgets/error.dart';
import 'package:provider/provider.dart';

class MyMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("all build");
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Movies"),
          ),
          body: _MySearch()),
    );
  }
}

class _MySearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("search build");
    return ListView(
      padding: EdgeInsets.all(10),
      shrinkWrap: true,
      children: [_MySearchBar(), _MySearchResult()],
    );
  }
}

class _MySearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _myController = TextEditingController();
    print("bar build");
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      child: ListTile(
        trailing: FlatButton(
          child: Text("Search"),
          onPressed: () =>
              context.read<MovieModel>().pushSearch(_myController.text),
        ),
        title: TextField(
          controller: _myController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'Search',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class _MySearchResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("result build");
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: FutureBuilder<Object>(
        future: fetchSearch(context.watch<MovieModel>().search),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data is SearchResult) {
              return _ResultList(results: snapshot.data as SearchResult);
            } else {
              return ErrorTextWidget(error: snapshot.data as ApiError);
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class _ResultList extends StatelessWidget {
  const _ResultList({
    Key key,
    @required this.results,
  }) : super(key: key);

  final SearchResult results;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: results.search.length,
      itemBuilder: (context, index) =>
          _ResultCard(result: results.search[index]),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({
    Key key,
    @required this.result,
  }) : super(key: key);

  final Search result;

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
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(result.year, style: subStyle),
                            Text(
                              result.type.toUpperCase(),
                              style: subStyle,
                            ),
                          ],
                        ),
                        //Spacer(),
                        SizedBox(
                          width: 50,
                        ),
                        FlatButton(
                          onPressed: () => {
                            context.read<MovieModel>().selectedFilm =
                                result.imdbID,
                            Navigator.pushNamed(context, "/movie")
                          },
                          child: Text(
                            "More",
                            style: buttonStyle.copyWith(
                                color: Theme.of(context).primaryColor),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
