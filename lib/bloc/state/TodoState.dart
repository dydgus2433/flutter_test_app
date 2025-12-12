class Todo {
  String title;
  bool completed;

  Todo({ required this.title, this.completed = false});

  void toggleCompleted(){
    completed = !completed;
  }
}

// bloc 에 의해 관리 발행되는 상태
class TodosState {
  List<Todo> todos = [];
  TodosState(this.todos); // bloc은 이벤트 감지하기 위해서 이거는 그냥 데이터만..
}