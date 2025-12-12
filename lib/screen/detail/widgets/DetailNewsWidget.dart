import 'package:flutter/material.dart';
import 'dart:async'; //future
import 'dart:convert'; //json
import 'package:http/http.dart' as http;
import '../dto/ArticleDto.dart';

class DetailNewsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DetailNewsWidgetState();
  }
}

class DetailNewsWidgetState extends State<DetailNewsWidget> {
  String _url =
      'https://newsapi.org/v2/everything?q=travel&apiKey=079dac74a5f94ebdb990ecf61c8854b7&pageSize=3';
  List<Article> list = [];
  late StreamController<List<Article>> streamController;
  
  // 서버데이터를 이용해서 목록화면으로 구성하는 함수
  Widget getItemWidget(List<Article> datas) {
    return ListView.builder(
      itemCount: datas.length,
      itemBuilder: (BuildContext context, int position) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                datas[position].title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                datas[position].publishedAt,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(datas[position].description),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Image.network(datas[position].urlToImage),
            ),
            if (position != datas.length - 1)
              Container(height: 15, color: Colors.grey),
          ],
        );
      },
    );
  }
  
  // 5초마다 반복적으로 서버 데이터를 가져오는 함수
  void periodicFetch() async {
    Stream.periodic(Duration(seconds: 5), (count)=> count+1)
        .take(5)
        .asyncMap((page) async {
          // 서버 요청 (비동기적으로 하기위해 async 붙임
        String url = '$_url&page=$page';
        http.Response response = await http.get(Uri.parse(url));
        List articles = json.decode(response.body)['articles'];
        // 우리가 만든 DTO로 변환
        return articles.map((item)=> Article(
          item['source']['name'],
          item['title'],
          item['description'],
          item['urlToImage'],
          item['publishedAt']
        )).toList();
    })
    .listen((articles)=> streamController.add(articles));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    streamController = StreamController<List<Article>>();
    periodicFetch();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    //Stream으로부터 넘어오는 데이터를 반복적으로 받아 화면 구성
    return StreamBuilder(
      stream: streamController.stream,
      // 최초에 한번 호출.. 데이터가 발생할때마다 호출
        // 두번째 매개변수가 발생한 데이터
      builder: (context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
          list.addAll(snapshot.data);
          return getItemWidget(list);
        }else if(snapshot.hasError){
          return Text('${snapshot.error}');
        }
        return CircularProgressIndicator();

      },
    );
  }
}
