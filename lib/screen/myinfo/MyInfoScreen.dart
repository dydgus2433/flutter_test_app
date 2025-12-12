import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_lab1/provider/MyInfoModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MyInfoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyInfoScreenState();
  }
}

class MyInfoScreenState extends State<MyInfoScreen> {
  // 유저 입력 데이터
  // String? email = '';
  // String? phone = '';
  // String userImage = 'assets/images/user_basic.jpg';

  //form 위젯에 설정할 키 필요한 순간 이 키를 사용해 Form의 State를 획득하기 위함
  final formKey = GlobalKey<FormState>();

  // Form을 이용하므로 유저입력데이터를 Form을 이용해 획득하고 있지만
  // 이 위젯이 출력될때 기존에 입력된 데이터가 유지되게 하려면 TextEditingController 사용해야
  late TextEditingController emailController;
  late TextEditingController phoneController;

  // gallery button callback
  Future<void> openGallery() async {
    //image_picker package 이용
    ImagePicker picker = ImagePicker();

    // gallery 목록화면 뜨고 유저가 선택한 이미지의 파일정보가 리턴
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // provider 등록.. 앱 전역에서 이용하게
      Provider.of<MyInfoModel>(
        context,
        listen: false,
      ).saveMyInfo(userImage: image.path);
    }
  }

  Future<void> openCamera() async {
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      // provider 등록.. 앱 전역에서 이용하게
      Provider.of<MyInfoModel>(
        context,
        listen: false,
      ).saveMyInfo(userImage: image.path);
    }
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    // 이 위젯의 화면이 렌더링이 완료된 후에 한번 실행시킬 코드가 있다면???
    // 출력이 완료된다음 네트워킹 시도한다던지
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _는 매개변수가 있는데 안쓰겠다는 뜻
      // 이 함수가 렌더링 완료후 자동호출된다.
      final model = Provider.of<MyInfoModel>(context, listen: false);
      emailController.text = model.email;
      phoneController.text = model.phone;
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    phoneController.dispose();
  }

  //입력 요소 저장을 위해 호출
  Future<void> saveData() async {
    //앱 전역에 데이터 유지되게
    final model = Provider.of<MyInfoModel>(context, listen: false);
    model.saveMyInfo(email: emailController.text, phone: phoneController.text);
    model.insertDB();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 정보'),
        actions: [
          TextButton(
            onPressed: () {
              // 키를 이용해서.. State 객체 획득
              final form = formKey.currentState;
              // validate() 호출하는 순간 Form 하위의 모든 위젯의 validator에 등록된 함수가 호출
              // 모두 null 을 리턴 -> 전체 valid
              // 하나라도 문자열을 리턴 -> 전체 invalid -> false
              if (form?.validate() ?? false) {
                form?.save(); // 모든 하위의 onSaved() 함수 호출.. 적절하게 입력데이터 저장하게 하고..
                saveData();
              }
            },
            child: Text(
              '저장',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Consumer<MyInfoModel>(
            builder: (context, model, child) {
              return Column(
                children: [
                  SizedBox(height: 30),
                  //프사
                  Card(
                    elevation: 0,
                    shape: CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      width: 150,
                      height: 150,
                      child: model.userImage.startsWith('assets/')
                          ? Image.asset(model.userImage, fit: BoxFit.cover)
                          : Image.file(
                              File(model.userImage),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: openGallery,
                    child: Text('Gallery App'),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: openCamera,
                    child: Text('Camera App'),
                  ),
                  SizedBox(height: 30),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        //Form과 상호작용이 준비된 위젯을 사용해야한다.. TextField는 안된다.
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(labelText: 'Email'),
                          //Form state 의 validate 함수 호출하는 순간 자동호출. 매개변수는 유저입력데이터
                          validator: (value) {
                            if (value?.isEmpty ?? false) {
                              return '이메일을 입력하세요'; // invalid 상황 리턴문자열이 errorText로 출력
                            }
                            return null; // 오류문자 반환할게 없다 = valid
                          },
                        ),
                        TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(labelText: 'Phone'),
                          keyboardType: TextInputType.phone,
                          //Form state 의 validate 함수 호출하는 순간 자동호출. 매개변수는 유저입력데이터
                          validator: (value) {
                            if (value?.isEmpty ?? false) {
                              return '핸드폰 번호를 입력하세요'; // invalid 상황 리턴문자열이 errorText로 출력
                            }
                            return null; // 오류문자 반환할게 없다 = valid
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
