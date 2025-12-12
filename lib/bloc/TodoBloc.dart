import 'package:bloc/bloc.dart';
import './event/TodoEvent.dart';
import './state/TodoState.dart';

// 상태 및 이벤트를 미리 설계하는게 좋음

// 공통의 조상역할의 위젯에서 등록할 bloc클래스
// 제네릭타입 : 이벤트 input - 상태 output
class TodosBloc extends Bloc<TodosEvent, TodosState> {
  // 생성자 선언 필수!!!!
  // 상위 생성자 호출.. 매개변수에 상태 초기값 지정해야..
  TodosBloc() : super(TodosState([])) {
    // 이벤트 발생시 어떻게 동작할 것인지 명시
    //event - 발생한 이벤트
    // emit - 함수 - 상태발행함수
    on<AddTodoEvent>((event, emit) {
      //Bloc 클래스 내에서 state 자동으로 유지되는 변수 bloc이 관리하는 상태를 지칭
      //remove 메소드의 반환 값은 리스트가 아니라 true 또는 false이기 때문에, 한 줄로 합치기가 까다로움.
      // 삭제된 상태의 List를 반환하는것(true,false무시)
      //.. 연산자는 "이 메소드를 실행하고, 그 결과 대신 나 자신을 돌려줘"
      List<Todo> newTodos = List.from(state.todos)
      ..add(event.todo);
      // 중요사상
      // 상태는 변경되는 것이 아니라.. 기존 상태를 참조해서 새로 만드는 것이다.
      emit(TodosState(newTodos));
    });

    on<DeleteTodoEvent>((event, emit) {
      List<Todo> newTodos = List.from(state.todos)
      ..remove(event.todo);
    });

    on<ToggleCompletedEvent>((event, emit){
      List<Todo> newTodos = List.from(state.todos);
      int index = newTodos.indexOf(event.todo);
      newTodos[index].toggleCompleted();
      emit(TodosState(newTodos));
    });

  }

  @override
  void onTransition(Transition<TodosEvent, TodosState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}
