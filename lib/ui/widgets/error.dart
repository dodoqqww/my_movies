import 'package:flutter/material.dart';
import 'package:my_movies/services/movie_entites/error.dart';

class ErrorTextWidget extends StatelessWidget {
  const ErrorTextWidget({
    Key key,
    @required this.error,
  }) : super(key: key);

  final ApiError error;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 300),
        child: Center(child: Text(error.error)));
  }
}
