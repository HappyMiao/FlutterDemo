import 'package:meta/meta.dart';

class MovieData {
  final String title;//影视作品名称
  final String subtype;//作品类型 tv、movie
  final String year;//上映时间

  MovieData({
    @required this.title,
    @required this.subtype,
    @required this.year,
  });

  static List<MovieData> processMovieData(dynamic json) {

    List<MovieData> mMovieData = [];

    List<dynamic> movies = json['subjects'];

    for(int i = 0;i < movies.length;i++){
      MovieData movieData = new MovieData(title: movies[i]['title'],
                                          subtype: movies[i]['subtype'],
                                          year: movies[i]['year'].toString());
      mMovieData.add(movieData);
    }
  return mMovieData;
  }

}