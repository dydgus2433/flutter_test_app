import '../state/TodoState.dart';

// bloc에 발생시키기 위한 이벤트
// 이벤트 발생하면서 .. 데이터를 bloc에 전달해야해서, 클래스로..
// 여러 이벤트를 동일 타입으로 식별하기 위해서 상위 클래스  설계
abstract class TodosEvent {
  // abstract 왜 쓰는거냐? 이벤트를 하위에 공통타입으로 쓸 수 있으니까 의미있음
}

class AddTodoEvent extends TodosEvent {
  Todo todo;
  AddTodoEvent(this.todo);
}

class DeleteTodoEvent extends TodosEvent {
  Todo todo;
  DeleteTodoEvent(this.todo);
}

class ToggleCompletedEvent extends TodosEvent {
  Todo todo;
  ToggleCompletedEvent(this.todo);
}






