import 'package:flutter/material.dart';
import 'package:flutter_lab1/screen/main/widgets/MainDrawer.dart';
import './dto/DestinationDto.dart';
import './widgets/DestinationCard.dart';

class Mainscreen extends StatelessWidget {
  // 화면 구성을 위한 가상의 데이터..
  final List<DestinationDto> destinations = [
    DestinationDto(
      id: 1,
      image: 'assets/images/main_swiss.jpg',
      destination: '스위스',
      discount: '최대 20% 할인',
    ),
    DestinationDto(
      id: 2,
      image: 'assets/images/main_australia.jpg',
      destination: '호주',
      discount: '최대 10% 할인',
    ),
    DestinationDto(
      id: 3,
      image: 'assets/images/main_georgia.jpg',
      destination: '조지아',
      discount: '최대 20% 할인',
    ),
    DestinationDto(
      id: 4,
      image: 'assets/images/main_mongolia.jpg',
      destination: '몽골',
      discount: '최대 20% 할인',
    ),
    DestinationDto(
      id: 5,
      image: 'assets/images/main_nepal.jpg',
      destination: '네팔',
      discount: '최대 15% 할인',
    ),
    DestinationDto(
      id: 6,
      image: 'assets/images/main_hawaii.jpg',
      destination: '하와이',
      discount: '최대 5% 할인',
    ),
  ];

  // 화면 구성을 위한 위젯을 준비하는 개발자 함수.. build에서 호출..
  List<Widget> makeDestinationGrid(){
    return destinations.map((destination){
      return DestinationCard(destination);
    }).toList();
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('MainScreen')
      ),
      drawer: MainDrawer(),
      // 화면을 구성해서 위젯이 나열되다가 화면을 벗어나게 되면
      // 스크롤을 신경쓰지 않았다는 검정/노랑 패턴의 경고 화면이 나온다.
      // 스크롤 준비해야한다. 위젯으로
      // SingleChildScrollView - 하위에 하나의 위젯만 추가
      // ListView - 여러개
      body:
      SingleChildScrollView(
        child:  Column(
          children: [
            // 화면에 출력되는 특정 영역을 다양한 설정
            Container(
                width: double.infinity,
                constraints: BoxConstraints(maxHeight: 300), // 화면의 제약.. 세로 방향의 최대는 300이내에서만..
                child: Image.asset(
                  'assets/images/main_bg_1.jpg',
                  width: double.infinity,
                  fit:BoxFit.cover,
                )
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '특가 여행지',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: (){
                      // 화면 전환 위젯을 명시해서
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> EventScreen()));
                      Navigator.pushNamed(context, '/event');
                    },
                    icon: Icon(Icons.arrow_drop_down, size: 20,),
                    label: Text('전체 여행지 보기'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF3899DD),
                        foregroundColor: Colors.white),
                  ),
                ],
              ),
            ),
            // symmetric 가로(왼쪽,오른쪽), 세로(위,아래) 동일 사이즈
            // 왼쪽따로 오른쪽따로는 only
            Padding(padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.count(
                //차지할만큼 무한으로 사이즈를 차지하지 말고.. 너네 콘텐츠 크기만큼만 차지해
                shrinkWrap: true,
                // GridView는 자체스크롤을 지원한다. 너네 스크롤 지원하지 말고 화면 전체의 스크롤을 따라.
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2, // 가로방향 2개
                childAspectRatio: 0.85, // 각 아이템의 가로:세로 비율
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: makeDestinationGrid(),
              ),
            ),
            // ElevatedButton(onPressed: (){
            //   Navigator.push(context, MaterialPageRoute(builder: (context)=>MyInfoScreen()));
            // }, child: Text('Go MyInfo'),
            // ),
          ],
        ),
      ),
    );
  }
}