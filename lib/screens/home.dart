import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/constants/colors.dart';
import 'package:flutter/services.dart';
import 'package:todo/screens/userprofileavatar.dart';
import 'package:todo/widgets/todo_item.dart';
import 'package:todo/models/todos.dart';

class Home extends StatefulWidget {
  static String? title;

  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final todoList = Todos.todos();
  final _todoController = TextEditingController();
  List<Todos> _foundTodo = [];

  @override
  void initState() {
    // TODO: implement initState
    _foundTodo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Status bar color
    ));
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20.0, top: 20),
          child: Stack(
            children: [
              Column(
                children: [
                  searchBox(),
                  Expanded(
                      child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                        child: const Text(
                          'Todo List',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: tdBlack),
                        ),
                      ),
                      for (Todos todos in _foundTodo.reversed) Todo(
                          todos: todos,
                          onTodoDelete: _handleDeleteTodo,
                          onTodoStatusChange: _handleTodoChange
                      ),
                    ],
                  )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              margin: const EdgeInsets.only(bottom: 10, top: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: TextField(
                                controller: _todoController,
                                style: const TextStyle(
                                  color: tdBlack,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18
                                ),
                                decoration: const InputDecoration(
                                  hintText: "Add New Todo",
                                  border: InputBorder.none,
                                ),
                              ),
                            )
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          margin: const EdgeInsets.only(bottom: 10, top: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 10,
                              backgroundColor: tdBlue
                            ),
                            onPressed: () {
                              // print(_todoController.text);
                              _addTodo(_todoController.text);
                            },
                            child: const Text(
                                '+',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                                color: Colors.white
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }

  Container searchBox() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 20.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20), right: Radius.circular(20)),
      ),
      child: TextField(
        // textAlignVertical: TextAlignVertical.top,
        onChanged: (value) { findSearchItem(value.toString());},
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(Icons.search, color: tdBlue, size: 20),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, maxWidth: 25),
            hintText: "Search",
            border: InputBorder.none,
            hintStyle: TextStyle(fontSize: 20, color: tdBlue)),
      ),
    );
  }

  void _handleTodoChange(Todos todos) {
    setState(() {
      todos.completed = todos.completed == true ? false : true;
    });
  }

  void _handleDeleteTodo(String id) {
    setState(() {
      todoList.removeWhere((element) => element.id == id);
    });
  }

  void _addTodo(String todo) {
    setState(() {
      todoList.add(
          Todos(
              id: DateTime.timestamp().millisecondsSinceEpoch.toString(),
              task: todo
          ));
      _todoController.clear();
    });
  }

  void findSearchItem(String searchWord){
    List<Todos> foundItems = [];
    if(searchWord.isEmpty){
      foundItems = todoList;
    } else {
      foundItems = todoList
          .where((element) => element.task.toLowerCase().contains(searchWord.toLowerCase())
      ).toList();
    }
    setState(() {
      _foundTodo = foundItems;
    });
  }
  
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          UserProfileAvatar(
            imagePath: 'assets/images/man.jpg',
          )
        ],
      ),
    );
  }
}
