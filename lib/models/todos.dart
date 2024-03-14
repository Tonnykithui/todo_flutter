class Todos {
  String id;
  String task;
  bool? completed;

  Todos({
    required this.id,
    required this.task,
    this.completed
  });

  static List<Todos> todos() {
    return [
      Todos(id: "1", task: "Visit library", completed: false),
      Todos(id: "2", task: "Wash dishes", completed: false),
      Todos(id: "3", task: 'Clean the house', completed: true),
      Todos(id: "4", task: "Check out the todo is completed", completed: false),
      Todos(id: "5", task: "Walk the dog", completed: false),
      Todos(id: "6", task: "Visit the park", completed: true),
      Todos(id: "23", task: 'Clean the house', completed: true),
      Todos(id: "34", task: "Check out the todo is completed", completed: false),
      Todos(id: "45", task: "Walk the dog", completed: false),
      Todos(id: "15", task: "Visit library", completed: false),
      Todos(id: "62", task: "Wash dishes", completed: false),
      Todos(id: "37", task: 'Clean the house', completed: true),
      Todos(id: "94", task: "Check out the todo is completed", completed: false),
      Todos(id: "50", task: "Walk the dog", completed: false),
      Todos(id: "60", task: "Visit the park", completed: true),
    ];
  }

}