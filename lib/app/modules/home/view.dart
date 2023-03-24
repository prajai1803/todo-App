import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo/app/data/models/tasks.dart';
import 'package:todo/app/modules/home/controller.dart';
import 'package:todo/app/core/utils/extensions.dart';
import 'package:todo/app/modules/home/widgets/add_card.dart';
import 'package:todo/app/modules/home/widgets/add_dialog.dart';
import 'package:todo/app/modules/home/widgets/task_card.dart';
import 'package:todo/app/modules/report/view.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SafeArea(
          child: IndexedStack(index: controller.tabIndex.value, children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0.wp),
                    child: Text(
                      'My List',
                      style: TextStyle(
                        fontSize: 24.0.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Obx(
                    () => GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      children: [
                        ...controller.tasks
                            .map((element) => LongPressDraggable(
                                data: element,
                                onDragStarted: () =>
                                    controller.changeDeleting(true),
                                onDraggableCanceled: (velocity, offset) =>
                                    controller.changeDeleting(false),
                                onDragEnd: (details) =>
                                    controller.changeDeleting(false),
                                feedback: Opacity(
                                  opacity: .5,
                                  child: TaskCard(
                                    task: element,
                                  ),
                                ),
                                child: TaskCard(task: element)))
                            .toList(),
                        AddCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ReportPage()
          ]),
        ),
      ),
      floatingActionButton: DragTarget(
        builder: (context, candidateData, rejectedData) {
          return Obx(
            () => FloatingActionButton(
                onPressed: () {
                  if (controller.tasks.isNotEmpty) {
                    controller.editController.clear();
                    Get.to(
                      () => AddDialog(),
                      transition: Transition.downToUp,
                    );
                  } else {
                    EasyLoading.showInfo("Please create task type");
                  }
                },
                backgroundColor:
                    controller.deleting.value ? Colors.red : Colors.blue,
                child:
                    Icon(controller.deleting.value ? Icons.delete : Icons.add)),
          );
        },
        onAccept: (Task task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess("Task Deleted");
        },
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (value) {
            controller.changeTabIndex(value);
          },
          currentIndex: controller.tabIndex.value,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.data_usage), label: 'Report')
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
