import 'package:flutter/material.dart';
import 'package:flutter_lab1/provider/MyInfoModel.dart';
import 'package:flutter_lab1/screen/bloc/BlocMainScreen.dart';
import 'package:flutter_lab1/screen/detail/DetailScreen.dart';
import 'package:flutter_lab1/screen/dio/DioTestScreen.dart';
import 'package:flutter_lab1/screen/event/EventScreen.dart';
import 'package:flutter_lab1/screen/main/MainScreen.dart';
import 'package:flutter_lab1/screen/myinfo/MyInfoScreen.dart';
import 'package:flutter_lab1/screen/platform/PlatformScreen.dart';
import 'package:flutter_lab1/screen/provider/ProviderMainScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyInfoModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // 디버그 띠 보이지않게
        initialRoute: '/main',
        //중첩구조 등록 가능하다. 화면이 너무 많을 경우 한곳에서 다 등록하지 않고 나누어서 등록이 가능하다.
        // main - MaterialApp -> UserHome
        // UserHome에서 다시 MaterialApp을 이용해 자신업무에 필요한 화면을 다시 등록가능
        routes: {
          '/main': (context) => Mainscreen(),
          '/event': (context) => EventScreen(),
          '/myinfo': (context) => MyInfoScreen(),
          '/dio': (context) => DioTestScreen(),
          '/provider': (context) => ProviderMainScreen(),
          '/bloc': (context) => BlocMainScreen(),
          '/platform': (context) => PlatformScreen(),
        },
        //화면 전환 요청을 받았을때 처리할 로직이 있다면 무언가 판단해서 다르게 화면전환을 하고싶거나
        //화면 전환시에 어떤 데이터가 미리 준비되어야하거나
        //매개변수는 지금 발생한 화면전환 요청 정보 이름 및 arguments
        onGenerateRoute: (settings) {
          if (settings.name == '/detail') {
            // 로직 돌리고..
            // 리턴 시키는 Route 정보대로 화면 전환
            return MaterialPageRoute(
              builder: (context) => DetailScreen(),
              settings:
                  settings, // 추가해주어야한다. 화면 전환 요청한 곳에서 전달한 데이터가 있을 수 있다 그대로 전달되어야함
            );
          }
        },
      ),
    );
  }
}
