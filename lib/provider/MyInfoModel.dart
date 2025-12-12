import 'package:flutter/material.dart';

// 앱 선택에서 유지 이용되는 앱사용자 정보
class MyInfoModel extends ChangeNotifier {
  String email = '';
  String phone = '';
  String userImage = 'assets/images/user_basic.jpg';

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
}