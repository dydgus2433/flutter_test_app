import 'package:flutter/material.dart';
import 'package:flutter_lab1/screen/detail/widgets/DetailMainWidget.dart';
import 'package:flutter_lab1/screen/detail/widgets/DetailNewsWidget.dart';
import 'package:flutter_lab1/screen/main/dto/DestinationDto.dart';

class DetailScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DetailScreenState();
  }
}

// SingleTickerProviderStateMixin - bottom navigation bar이 item 클릭시 애니메이션 효과를 위해서
class DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0; // bottom navigation bar의 선택된 item 상태가 변경시 화면 갱신

  // 탭버튼 화면 위젯
  List<Widget> widgets = [DetailMainWidget(), DetailNewsWidget()];

  //bottom navigation bar의 item 선택 이벤트
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    //화면전환시 전달된 데이터 추출
    Map<String, Object> args = ModalRoute.of(context)?.settings.arguments as Map<String, Object>;

    DestinationDto dto = args['destination'] as DestinationDto;

    return Scaffold(
      // 화면에 같이 나오는 두 위젯이 접히게 하기 위해서
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            //Scaffold의 Appbar는 NestedScrollView와 연동해서 접히는 기능이 없다.
            SliverAppBar(
               expandedHeight: 250.0,
                //접혔다가 거꾸로 스크롤할때 가장 처음부터 펼쳐져야하는가? 맨 마지막에 끌려 나와야하는가?
                floating: false,
                // 접히다가 완전히 사라질 것인가? 한줄은 남길 것인가?
                pinned: true,
                backgroundColor: Color(0xFF3899DD),
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    dto.destination,
                    style: TextStyle(
                      color: Colors.white,
                    ),

                  ),
                  titlePadding: EdgeInsets.only(left: 56, bottom: 16),
                  //접혔다가 펼쳐질때 타이틀 문자열의 크기 배율
                  expandedTitleScale: 1.0,
                  background: Image.asset(
                    dto.image,
                    fit: BoxFit.cover,
                  ),

                ),
            )];
        },
        body: widgets.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting, //Item클릭시 애니메이션 효과 적용할 것인가(shifting) , 고정(fixed)
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Main',
            backgroundColor: Color(0xFF3899DD) // 이 item이 선택 되었을때 bar의 전체색상
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'News',
              backgroundColor: Colors.redAccent // 이 item이 선택 되었을때 bar의 전체색상
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber,
        onTap: onItemTapped,
      ),
    );
  }
}
