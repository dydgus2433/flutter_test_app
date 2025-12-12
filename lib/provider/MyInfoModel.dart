import 'package:flutter/material.dart';
import 'package:flutter_lab1/db/DatabaseHelper.dart';

// 앱 선택에서 유지 이용되는 앱사용자 정보
class MyInfoModel extends ChangeNotifier {
  String email = '';
  String phone = '';
  String userImage = 'assets/images/user_basic.jpg';

  // 각 위젯에서 직접 DBMS 해도 되기는 하지만 DBMS의 데이터가 앱 전역에 provider에 의해 관리되기 때문에
  // 여기서 dbms 하겠다.
  DatabaseHelper dbHelper = DatabaseHelper();

  // 상태값 변경을 위해서 호출
  void saveMyInfo({String? email, String? phone, String? userImage}){
    bool hasChanged = false;

    if(email != null){
      this.email = email;
      hasChanged = true;
    }

    if(phone != null){
      this.phone = phone;
      hasChanged = true;
    }

    if(userImage != null){
      this.userImage = userImage;
      hasChanged = true;
    }

    //변경사항있다면 하위위젯에 다 전파시켜
    if(hasChanged){
      notifyListeners();
    }
  }

  void insertDB() async {
    try {
      await dbHelper.insertMyInfo({
        'email': email,
        'phone': phone,
        'photo': userImage,
      });
      print('저장 성공');
    }catch(e){
      print('저장 실패 : $e');
    }
  }

  // 앱 실행되자 마자 db데이터 획득해서 앱의 상태로 유지하기 위해서 호출
void loadUserInfo() async {
    try{
      final data = await dbHelper.getMyInfo();
      if(data.isNotEmpty){
        email = data.first['email'];
        phone = data.first['phone'];
        userImage = data.first['photo'];
        notifyListeners();
      }
      print('로드 성공');
    }catch(e){
      print('로드 실패 : $e');
    }
}
}