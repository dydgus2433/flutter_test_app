
void main(){
  //named parameter
  //optional 로 매개변수를 선언하면 호출시에 값이 대입되지 않을 수 있다.
  void myFunc1(bool data1, {String? data2, int? data3}){

  }
  myFunc1(true); //ok
  //myFunc1(true,'hello',100); // 이름을 명시하지 않아서 나는 에러
  myFunc1(true,data2:'hello',data3:100); //ok
  //이름이 명시됨으로 매개변수의 순서는 의미가 없다.
  myFunc1(false, data3:200, data2:'world'); //ok

  //positional parameter
  void myFunc2(bool data1, [String? data2, int data3 = 0]){

  }
  myFunc2(true); //ok

  // 이름 명시할 수 없음
  //myFunc2(true,data2:'hello',data3:100); //error
  // 순서 지켜야함
  //myFunc2(true,100,'hello'); //error
  myFunc2(true,'hello',100); //ok
  myFunc2(true,'hello');//ok
  //myFunc2(true,100);//error

  //hof
  int some(int no){
    return no * 10;
  }

  Function myFunc3(int Function(int a) argFun){
    print(argFun(10));
    return some;
  }

  var result = myFunc3((int arg) => arg + 10);
  print(result(20));
}