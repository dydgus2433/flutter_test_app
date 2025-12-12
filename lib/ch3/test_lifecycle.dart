import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(ParentWidget());

class ParentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ParentState();

  }
}

class ParentState extends State<ParentWidget> {
  // 부모 위젯에서 관리하는 상태 데이터
  // 하위 위젯에 전파되는 데이터
  int counter = 0;

  void increment(){
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Life Cycle Test'),
        ),
        // 상위의 상태 데이터를 하위에 전파시키기 위한 코드
        body: Provider.value(value: counter,

            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text('I am parent Widget: $counter'),
                      ElevatedButton(onPressed: increment, child: Text('increment')),

                    ],
                  ),
                  ChildWidget(),
                ],
              ),
            )
        ) ,
      ),
    );
  }
}

class ChildWidget extends StatefulWidget {
  ChildWidget(){
    print('ChildWidget ... constructor');
  }

  @override
  State<StatefulWidget> createState() {
    return ChildState();
  }
}

// WidgetsBindingObserver - 앱 자체의 라이프사이클 확인. 앱이 화면에 나오는 순간 / 사라지는 순간
class ChildState extends State<ChildWidget> with WidgetsBindingObserver {
  
  int counter = 0;// 상위에서 전달받을 데이터
  
  ChildState(){
    print('ChildState ... constructor');
  }

  //최초한번
  //상태데이터 초기화
  //이벤트 등록
  @override
  void initState() {
    print('ChildState ... initState');
    WidgetsBinding.instance.addObserver(this); // 앱의 라이프사이클 감지 등록
  }

  //최후에 한번 호출
  //이벤트 등록해제
  @override
  void dispose(){
    print('ChildState ... dispose');
    WidgetsBinding.instance.removeObserver(this);
  }

  // init 다음 바로 호출
  // 반복호출 가능성이 있지만 상위 위젯의 상태가 변경될때
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('ChildState ... didChangeDependencies');
    counter = Provider.of<int>(context);// 상위 상태 데이터 획득
  }

  @override
  Widget build(BuildContext context) {
    print('ChildState ... build');
    return Text('I am ChildWidget : $counter');
  }
  
  // 앱 상태 변경 됐을 때의 콜백함수
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('didChangeAppLifecycleState ${state}');
  }
}
//
/*
최초화면 출력되는 순간

I/flutter (17220): ChildWidget ... constructor
I/flutter (17220): ChildState ... constructor
I/flutter (17220): ChildState ... initState
I/flutter (17220): ChildState ... didChangeDependencies
I/flutter (17220): ChildState ... build

상위 위젯 버튼을 누르는 순간
I/flutter (17220): ChildWidget ... constructor
I/flutter (17220): ChildState ... didChangeDependencies
I/flutter (17220): ChildState ... build
==> 상위 위젯의 상태가 변경되었다. 하위 위젯은 다시 생성된다. 위젯은 불변이다.
==> state는 다시 생성되지 않았다. 초기생성된 객체를 메모리에 지속시키면서 이용된다.

앱이 화면에 안나오는 순간

I/flutter (17220): didChangeAppLifecycleState AppLifecycleState.inactive
D/VRI[MainActivity](17220): visibilityChanged oldVisibility=true newVisibility=false
I/flutter (17220): didChangeAppLifecycleState AppLifecycleState.hidden
I/flutter (17220): didChangeAppLifecycleState AppLifecycleState.paused

나오는 순간

I/flutter (17220): didChangeAppLifecycleState AppLifecycleState.hidden
I/flutter (17220): didChangeAppLifecycleState AppLifecycleState.inactive
I/flutter (17220): didChangeAppLifecycleState AppLifecycleState.resumed


 */