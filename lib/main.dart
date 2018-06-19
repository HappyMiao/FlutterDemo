import 'package:flutter/material.dart';

import 'package:flutter_app/MovieData.dart';

import 'package:dio/dio.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '搜电影、电视剧',
      home: new ListDemo(),
    );
  }
}

class ListDemo extends StatefulWidget {
  @override
  createState() => new ListDemoContent();
}

class ListDemoContent extends State<ListDemo> {

  List<MovieData> movie = [];

  final _biggerFont = const TextStyle(fontSize: 18.0);

  //一进页面就请求接口，文档里没有找到这个，懵逼半天。。。
  @override
  void initState() {
    super.initState();
    getDta();
  }

  //发起网络请求，处理数据
  getDta() async {
    Dio dio = new Dio();
    Response response=await dio.get("http://api.douban.com//v2/movie/search?q=x战警");
    setState(() {
      try{
        movie = MovieData.processMovieData(response.data);
      }catch(exception){
        print('processMovieData error ' + exception.toString());
      }
    });
  }

  //创建List
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('搜电影、电视剧'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return new ListView.builder(
      padding: const EdgeInsets.all(10.0),
      itemBuilder: (context, i) {
        // 在每一列之前，添加一个1像素高的分隔线widget
        //if (i.isOdd) return new Divider();
        return _buildRow(i);
      },
    );
  }

  //创建行
  Widget _buildRow(int i) {
    MovieData movieData;
    if(movie != null && i < movie.length){
      movieData = movie[i];
    }
    return new ListTile(
      title: new Text(
        '作品: ' + movieData.title,
        style: _biggerFont,
      ),
      trailing: new Text(
        '年份：' + movieData.year,
        style: _biggerFont,
      ),
    );
  }

}
