import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// page개념 refesh 둘다 있어서 stateful
class DioTestScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DioTestScreenState();
  }
}

class DioTestScreenState extends State<DioTestScreen> {
  //서버에서 받은 데이터
  List datas = [];

  //ListView에 지정.. ListView의 스크롤 정보 활용..
  ScrollController controller = ScrollController();

  // 서버 전송 데이터
  int page = 1;
  int seed = 1;

  // 서버 요청 함수
  // Future 미래 발생하는 데이터 비동기를 위해 사용
  // 이 함수를 호출한 곳은 일반적으로 이 함수의 실행이 완료될때까지 대기된다.(동기)
  // 리턴 타입 Future 이 함수를 호출하자마자 Future 리턴되어 호출한 곳이 바로 그 다음 동작..
  Future<List<dynamic>> dioTest() async {
    try {
      var dio = Dio(
        BaseOptions(
          connectTimeout: Duration(seconds: 5),
          receiveTimeout: Duration(seconds: 5),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            HttpHeaders.acceptHeader: 'application/json',
          },
        ),
      );
      // 서버 요청
      Response<dynamic> response = await dio.get(
        'https://randomuser.me/api/?seed=${seed}&page=${page}&results=20',
      );
      return response.data['results'];
    } catch (e) {
      print(e);
    }
    return [];
  }

  // 스크롤 이벤트 콜백 함수
  scrollListner() async {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      // 끝까지 스크롤 된 상황
      //그 다음 페이지 데이터 요청
      page++;
      List result = await dioTest();
      setState(() {
        datas.addAll(result);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(scrollListner); //이벤트 등록
    // 최초 데이터 획득
    dioTest().then((value) {
      setState(() {
        datas = value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose(); //이벤트 해제
  }

  // 화면 refresh 이벤트 콜백
  Future<void> refresh() async {
    page = 1;
    seed++;
    List result = await dioTest();
    setState(() {
      datas = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dio')),
      // 빙빙빙 도는 녀석
      body: RefreshIndicator(
        // 사용자 함수 등록
        onRefresh: refresh,
        child: ListView.separated(
          controller: controller, // 스크롤 정보를 받을 수 있는 컨트롤러 지정
          itemCount: datas.length,
          itemBuilder: (BuildContext context, int position) {
            return ListTile(
              contentPadding: EdgeInsets.all(5),
              title: Text(
                "${datas[position]["name"]["first"]} ${datas[position]["name"]["last"]}",
              ),
              subtitle: Text(datas[position]["email"]),
              leading: CircleAvatar(
                radius: 25,
                child: ClipOval(
                  child: Image.network(datas[position]["picture"]['thumbnail']),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int position) {
            return Divider(color: Colors.black);
          },
        ),
      ),
    );
  }
}
