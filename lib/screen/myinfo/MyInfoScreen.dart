import 'package:flutter/material.dart';

class MyInfoScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyInfoScreenState();

  }

}

class MyInfoScreenState extends State<MyInfoScreen>{
  // 유저 입력 데이터
  String? email = '';
  String? phone = '';
  String userImage = 'assets/images/user_basic.jpg';

  //form 위젯에 설정할 키 필요한 순간 이 키를 사용해 Form의 State를 획득하기 위함
  final formKey = GlobalKey<FormState>();

  //입력 요소 저장을 위해 호출
  Future<void> saveData() async {
    print('email : ${email}' );
    print('phone : ${phone}' );
    print('photo : ${userImage}' );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 정보'),
        actions: [
          TextButton(onPressed: (){
            // 키를 이용해서.. State 객체 획득
            final form = formKey.currentState;
            // validate() 호출하는 순간 Form 하위의 모든 위젯의 validator에 등록된 함수가 호출
            // 모두 null 을 리턴 -> 전체 valid
            // 하나라도 문자열을 리턴 -> 전체 invalid -> false
            if(form?.validate() ?? false){
              form?.save(); // 모든 하위의 onSaved() 함수 호출.. 적절하게 입력데이터 저장하게 하고..
              saveData();
            }
          }, child: Text('저장', style: TextStyle(color: Colors.black, fontSize: 16),),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding : EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 30,),
              //프사
              Card(
                elevation: 0,
                shape: CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  width: 150,
                  height: 150,
                  child: Image.asset(userImage, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 24,),
              ElevatedButton(onPressed: (){}, child: Text('Gallery App')),
              SizedBox(height: 24,),
              ElevatedButton(onPressed: (){}, child: Text('Camera App')),
              SizedBox(height: 30,),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //Form과 상호작용이 준비된 위젯을 사용해야한다.. TextField는 안된다.
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Email'),
                      //Form state 의 validate 함수 호출하는 순간 자동호출. 매개변수는 유저입력데이터
                      validator: (value){
                        if(value?.isEmpty ?? false){
                          return '이메일을 입력하세요';// invalid 상황 리턴문자열이 errorText로 출력
                        }
                        return null; // 오류문자 반환할게 없다 = valid
                      },
                      //Form state의 save() 호출하는 순간 자동호출
                      onSaved: (value){
                        email = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Phone'),
                      keyboardType: TextInputType.phone,
                      //Form state 의 validate 함수 호출하는 순간 자동호출. 매개변수는 유저입력데이터
                      validator: (value){
                        if(value?.isEmpty ?? false){
                          return '핸드폰 번호를 입력하세요';// invalid 상황 리턴문자열이 errorText로 출력
                        }
                        return null; // 오류문자 반환할게 없다 = valid
                      },
                      //Form state의 save() 호출하는 순간 자동호출
                      onSaved: (value){
                        phone = value;
                      },
                    ),
                  ],
                ),
              ),
              ]
          ),
        ),
      ),
    );
  }
}