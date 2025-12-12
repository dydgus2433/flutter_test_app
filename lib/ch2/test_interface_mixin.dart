class MyClass {
  int no;
  String name;

  MyClass(this.no,this.name);

  void myFunc(){}
}

// 클래스를 상속으로..
class SubClass extends MyClass {
  SubClass(no,name): super(no,name);

}

//클래스를 인터페이스로
//클래스에 선언한 모든 멤버를 오버라이드 해야한다..
class InterfaceClass implements MyClass {
  int no = 0;
  String name = "kim";

  void myFunc(){
    print(name);
  }

}
// 어떤 클래스 설계와 관련이 없다..
// 단지 여러 클래스의 코드 중복을 피하기 위해서 사용한다.
mixin MyMixin {
  int mixinData = 10;
  void mixinFun(){}
}

class MixinText with MyMixin {
  void someFun(){
    mixinData++;
    mixinFun();
  }
}