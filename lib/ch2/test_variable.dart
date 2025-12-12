main(){
  // 다트의 모든 변수는 객체다
  int data1 = 10;
  print(data1.isEven);

  //객체이므로 기초타입 캐스팅 안된다.
  //double data2 = data1 // error ->  data1.toDouble();
  //int data3 = 10.0; // error

  // 기초타입 변형 하려면 함수를 이용해야한다

  double data2 = data1.toDouble();
  int data3 = 10.3.toInt();

  //String <-> int
  String data4 = '10';
  int data5 = int.parse(data4);
  String data6 = data5.toString();

  //var ... dynamic
  int a = 10;
  // a = "hello"; // error...

  //var ... 타입이 없는 것이 아니라... 대입되는 값에 의해 타입이 자동 고정된다.. 타입 유추 기법이다.
  var b = 10;
  //b = 'hello'; //error..

  // 모든 타입 데이터 가능 .. 타입자체가 유추가 안되는 경우 - 프로그램의 안정성이 떨어짐
  dynamic c = 10;
  c = 'hello';
  c = true;

  //선언된 라인의 대입되는 값으로 타입이 유추되는데...
  //var 로 선언하고.. 값을 대입하지 않으면.. dynamic 타입으로 유추된다...
  var d;
  d = 10;
  d = 'hello';
  d = true;

  //List....
  List<int> list1 = [10,20,30];
  list1.add(40);
  print(list1); //[10, 20, 30, 40]
  print(list1[0]); //10

  // 사이즈 지정 후 사용
  List<int> list2 = List.filled(3, 0);
  //list2.add(40); // error Cannot add to a fixed-length list
  print(list2[0]); //10

  //Map
  Map<String, String> map  = {'one':'hello','two':'world'};
  print(map['one']);//hello
  print(map['two']);











}