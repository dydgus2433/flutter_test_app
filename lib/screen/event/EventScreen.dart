import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import './dto/EventDto.dart';
import './widget/EventCard.dart';

class EventScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EventScreenState();
  }
}

class EventScreenState extends State<EventScreen> {
  //EventDto dto = EventDto('assets/images/main_australia.jpg','호주','1일~3일','시드니+멜버른','20%');

  List<EventDto> datas = [
    EventDto(
      'assets/images/main_australia.jpg',
      '호주',
      '시드니+멜버른+브리즈번',
      '2.14(금) ~ 2.23(일)',
      '20%',
    ),
    EventDto(
      'assets/images/main_georgia.jpg',
      '조지아',
      '나리칼라+게르게티',
      '2.14(금) ~ 2.29(토)',
      '15%',
    ),
    EventDto(
      'assets/images/main_hawaii.jpg',
      '하와이',
      '호놀룰루+마우이',
      '2.15(토) ~ 2.20(목)',
      '20%',
    ),
    EventDto(
      'assets/images/main_mongolia.jpg',
      '몽골',
      '울란바토르+알타이',
      '2.17(월) ~ 2.23(일)',
      '20%',
    ),
    EventDto(
      'assets/images/main_nepal.jpg',
      '네팔',
      '카트만두+ABC',
      '2.21(금) ~ 3.8(일)',
      '15%',
    ),
  ];

  List<EventCard> makePagerWidget() {
    return datas.map((vo) {
      return EventCard(vo);
    }).toList();
  }

  // PageView에 의해 순차적으로 화면이 나오게 된다.
  // PageView 설정, 하단에 indicator를 제공한다면 indicator에게 pageview에서 선택한 화면 정보가
  // 전달되어야한다
  // 이곳에 설정된 대로 pageView가 나오게 되며
  // 동일 controller를 pageview와 indicator가 가지고 있으면 pageview 조정내용이 자동으로 indicator에 전달
  PageController controller = PageController(
    initialPage: 0,
    viewportFraction: 1, //현재의 화면을 기준으로 왼쪽,오른쪽에 있는 화면을 얼마나 보여줄까?

    // 0~ 1 : 1은 100%
  );

  @override
  Widget build(BuildContext context) {
    //스크린전체를 위한거면 Scaffold
    return Scaffold(
      body: Container(
          color: Color(0xFF3899DD),
          child: Column(
            children: [
              Expanded(
              child: PageView(
              controller: controller,
                children: makePagerWidget(),
              ),
            ),
            SmoothPageIndicator(
              controller: controller,
              count: 5,
              effect: WormEffect(
                dotColor: Colors.white,
                activeDotColor: Colors.yellow
              ),
            ),
              SizedBox(height: 32,),
          ],

      ),
    ),);
  }
}
