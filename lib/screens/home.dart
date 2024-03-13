import 'package:flutter/material.dart';
import 'package:todo/constants/colors.dart';
import 'package:flutter/services.dart';
import 'package:todo/screens/userprofileavatar.dart';
import 'package:todo/widgets/todo_item.dart';

class Home extends StatelessWidget {
  static String? title;

  const Home({super.key});

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
          child: Column(
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
                        color: tdBlack
                      ),
                    ),
                    // decoration: const BoxDecoration(color: Colors.deepOrange),
                  ),
                  const Todo(

                  )
                ],
              ))
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
      child: const TextField(
        // textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(Icons.search, color: tdBlue, size: 20),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, maxWidth: 25),
            hintText: "Search",
            border: InputBorder.none,
            hintStyle: TextStyle(fontSize: 20, color: tdBlue)),
      ),
    );
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
