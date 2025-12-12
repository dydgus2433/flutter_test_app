import 'package:flutter/material.dart';

class Todo {
  String title;
  bool completed;
  
  Todo({required this.title, this.completed = false});
  
  void toggleCompleted(){
    completed = !completed;  
  }
}

// provider로 관리 등록, 이용하기 위한 데이터 
class TodosModel extends ChangeNotifier {
  List<Todo> todos = [];


  void addTodo(Todo todo){
    todos.add(todo);
    notifyListeners(); // 변경사항이 발생했다. 하위 위젯에 전파
  }

  void toggleTodo(Todo todo){
    final index = todos.indexOf(todo);
    todos[index].toggleCompleted();
    notifyListeners();
  }

  void deleteTodo(Todo todo){
    todos.remove(todo);
    notifyListeners();
  }
  
}