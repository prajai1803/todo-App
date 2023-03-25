import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/app/modules/home/controller.dart';
import 'package:todo/app/core/utils/extensions.dart';

class DoingList extends StatelessWidget {
  final _homecontroller = Get.find<HomeController>();
  DoingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        _homecontroller.doingTodos.isEmpty && _homecontroller.doneTodos.isEmpty
            ? Column(
                children: [
                  Image.asset(
                    "assets/images/addTask.png",
                    fit: BoxFit.cover,
                    width: 65.0.wp,
                  ),
                  Text('Add Task',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0.wp,
                  ),)
                ],
              )
            : ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                ..._homecontroller.doingTodos.map((element) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.0.hp,horizontal: 3.0.wp),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          fillColor: MaterialStateProperty.resolveWith((states) => Colors.grey),
                          value: element['done'],
                          onChanged: (value){
                            _homecontroller.doneTodo(element['title']);
                          },
                        ),
                        
                      ),
                      Text(element['title'],overflow: TextOverflow.ellipsis,)
                    ],
                  ),
                )).toList(),
                if (_homecontroller.doingTodos.isNotEmpty) Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0.wp,),
                  child: const Divider(),
                ),
              ],
            ));
  }
}
