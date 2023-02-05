import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:todo/app/core/utils/extensions.dart';
import 'package:todo/app/modules/home/controller.dart';

class DoneList extends StatelessWidget {
  final _homecontroller = Get.find<HomeController>();
  DoneList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        _homecontroller.doneTodos.isNotEmpty ? ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 1.0.hp,
                horizontal: 5.0.wp,
              ),
              child: Text('Completed(${_homecontroller.doneTodos.length})',
              style: TextStyle(
                fontSize: 14.0.sp,
                color: Colors.grey[400],
              ),),
            ),
            ..._homecontroller.doneTodos.map((element) => Dismissible(
              key: ObjectKey(element),
              direction: DismissDirection.endToStart,
              background:  Container(
                color: Colors.red.withOpacity(0.8),
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 5.0.wp),
                  child: Icon(Icons.delete,color: Colors.white,),
                ),

              ),
              onDismissed: (_) => _homecontroller.deleteDoneTodo(element['title']),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 1.0.hp,horizontal: 5.0.wp),
                child: Row(
                  children: [
                    const SizedBox(
                      height: 20,
                      width: 20,
                      child: Icon(Icons.done,color: Colors.blue,),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                      child: Text(element['title'],style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                      ),),
                    )
            
                  ],
                ),
              ),
            ))
          ],
        ) : Container());
  }
}
