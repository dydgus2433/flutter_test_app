// flutter 표준은 다 flutter패키지
// 구글의 material design에 입각해서 준비된 위젯을 제공
// 원한다면 cupertino(ios스타일의 위젯)
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
void main() => runApp(MyApp());

// 위젯 트리의 루트 역할을 하는 개발자 위젯은 일반적으로 stateless로 선언한다.
// stateful 로 선언이 가능하기는 하지만.. 그렇게 되면 화면 갱신시에 너무 많은 위젯 객체가
// 다시 생성될 수 있고, 성능이 문제가 될 수 있다.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 개발자 화면 단위 위젯의 루트는 일반적으로 MaterialApp(테마, 라우팅)
    return MaterialApp(
      // 화면의 기본 구조를 제공하는 위젯..
      home: Scaffold(
        appBar: AppBar(title: Text('Widgets Text'), backgroundColor: Colors.pinkAccent,),
        body: Column(
          children: [
            MyStatelessWidget(),
            MyStatefulWidget(),
            ]
        ),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  //statelessWidget은 상태를 유지하지 못한다는 것이지, 변수를 선언하지 못한다는게 아님
  bool favorited = false;
  int favoritedCount = 10;

  void toggleFavorite(){
    print('Stateless... toggleFavorite');

    if(favorited){
      favorited = false;
      favoritedCount--;
    }else{
      favorited = true;
      favoritedCount++;
    }


  }

  @override
  Widget build(BuildContext context) {
    print('Stateless... build....');
    return Row(
      children: [
        IconButton(
            onPressed: toggleFavorite,
            icon: (favorited ? Icon(Icons.star): Icon(Icons.star_border)),
            color: Colors.red
        ),
        Text('${favoritedCount}')
      ],
    );
  }
}

class MyStatefulWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createElement
    return MyState();
  }
}

class MyState extends State<MyStatefulWidget>{
  bool favorited = false;
  int favoritedCount = 10;

  void toggleFavorite(){
    print('Stateful... toggleFavorite');
    // state의 변수가 변경되었다고 화면이 갱신되는것이 아니라 화면 갱신 명령을
    // setState() 로 해줘야함
    // setState의 매개변수에 지정한 함수가 먼저 호출이 되고... 그 함수가 호출이 끝나면 화면갱신이 된다. 
    // 화면 갱신하기 전에 값 변경은 setState()의 매개변수 함수에서
    setState(() {
      if(favorited){
        favorited = false;
        favoritedCount--;
      }else{
        favorited = true;
        favoritedCount++;
      }
    });


  }

  @override
  Widget build(BuildContext context) {
    print('Stateful... build....');
    return Row(
      children: [
        IconButton(
            onPressed: toggleFavorite,
            icon: (favorited ? Icon(Icons.star, size: 25,): Icon(Icons.star_border, size: 25,)),
            color: Colors.lightBlue
        ),
        Text('${favoritedCount}')
      ],
    );
  }
}
