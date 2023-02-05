import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo/app/core/utils/extensions.dart';
import 'package:todo/app/data/models/tasks.dart';
import 'package:todo/app/modules/detail/view.dart';
import 'package:todo/app/modules/home/controller.dart';

class TaskCard extends StatelessWidget {
  final _homeController = Get.find<HomeController>();
  final Task task;
  TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final color = HexColor.fromHex(task.color);
    final squareWith = Get.width - 12.0.wp;

    return InkWell(
      onTap: (){
        _homeController.editController.clear();
        _homeController.changeTask(select: task);
        _homeController.changeTodos(task.todos ?? []);
        Get.to(()=> DetailPage(),transition: Transition.rightToLeft);
      },
      child: Container(
        width: squareWith / 2,
        height: squareWith / 2,
        margin: EdgeInsets.all(3.0.wp),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 7, offset: Offset(0, 7)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepProgressIndicator(
              totalSteps: _homeController.isTodosEmpty(task) ? 1 : task.todos!.length,
              currentStep: _homeController.isTodosEmpty(task) ? 0 : _homeController.getDoneTodo(task),
              size: 5,
              padding: 0,
              selectedGradientColor: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color.withOpacity(.5),color],
              ),
              unselectedColor: color.withOpacity(.1),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Icon(
                IconData(
                  task.icon,
                  fontFamily: 'MaterialIcons',
                ),
                color: color,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 10.0.sp,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text('${task.todos?.length ?? 0} Task',
                      style: TextStyle(
                        color: Colors.grey[700],
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
