import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlatformScreen extends StatefulWidget {
  @override
  PlatformScreenState createState() => PlatformScreenState();
}

class PlatformScreenState extends State<PlatformScreen> {
  String? resultMessage;
  String? receiveMessage;

  Future<Null> callNative() async {
    // native와 이름만 동일하면 된다.
    // 하나의 앱에서 여러 채널을 만들어도 된다.
    // 1:1 통신이다..
    var channel = BasicMessageChannel<String>(
      'myMessageChannel',
      StringCodec(),
    );
    // native에 데이터를 넘겨서 일을 시키기
    // native의 결과값.. 리턴으로 받으면 된다.
    String? result = await channel.send("Hello, I am flutter message");
    // Native가 전달한 메세지 제대로 전달됐는지 찍어봄
    setState(() {
      resultMessage = result;
    });

    // native의 데이터를 받기 위해서
    channel.setMessageHandler((String? message) async {
      setState(() {
        receiveMessage = message;
      });
      return "Hi from Dart";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Channel Test")),
      body: Center(
        child: Column(
          children: (<Widget>[
            Text('resultMessage : ${resultMessage}'),
            Text('receiveMessage : ${receiveMessage}'),
            ElevatedButton(onPressed: callNative, child: Text('Native Call')),
          ]),
        ),
      ),
    );
  }
}
