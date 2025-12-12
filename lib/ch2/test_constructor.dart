class User {
  String? name;
  int? age;
  //case 1. 생성자 매개변수로 멤버 초기화..
  // User(String name, int age){
  //   this.name = name;
  //   this.age = age;
  // }

  //case 2
  //User(String this.name, int this.age);

  //case 3 : 매개변수를 참조해서 약간의 로직을 실행 후 멤버 초기화 하고 싶은 경우
  User(String name, int age):this.name = name.toUpperCase(),this.age = age*2;

  //생성자 오버로딩 지원하지 않는다.
  //여러 생성자를 선언하겠다면 .. 이름을 추가해서 named Constructor로
  User.one(){}
  //생성자에서 다른 생성자를 호출하는 구문은 initialize 영역에
  User.two(String name): this.one();

}

// 이 클래스의 객체는 단 하나의 생성되어 이용되게 강제하고 싶다.
class Singleton {
  Singleton._privateConstructor();

  static final Singleton _instance = Singleton._privateConstructor();

  // factory 생성자는 외부에서는 생성자
  // 자동으로 객체가 생성되지 않는다. 개발자 코드에서 객체를 준비해서 리턴시켜야한다.
  factory Singleton(){
    return _instance;
  }
}

void main(){
  User('kim',20);
  User.one();
  User.two('lee');


  Singleton obj1 = Singleton();
  Singleton obj2 = Singleton();
  print(obj2 == obj1);
}