import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo/app/core/utils/extensions.dart';
import 'package:todo/app/modules/detail/widgets/doing_list.dart';
import 'package:todo/app/modules/detail/widgets/done_list.dart';
import 'package:todo/app/modules/home/controller.dart';

class DetailPage extends StatelessWidget {
  final _homeController = Get.find<HomeController>();
  DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    var task = _homeController.task.value;
    var color = HexColor.fromHex(task!.color);
    return Scaffold(
      body: Form(
        key: _homeController.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                        _homeController.updateTodo();
                        _homeController.editController.clear();
                        _homeController.changeTask(select: null);
                      },
                      icon: const Icon(Icons.arrow_back)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
              child: Row(
                children: [
                  Icon(
                    IconData(
                      task.icon,
                      fontFamily: 'MaterialIcons',
                    ),
                    color: color,
                  ),
                  SizedBox(
                    width: 3.0.wp,
                  ),
                  Text(
                    task.title,
                    style: TextStyle(
                        fontSize: 12.0.sp, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Obx(() {
              int total = _homeController.doneTodos.length +
                  _homeController.doingTodos.length;
              return Padding(
                padding:
                    EdgeInsets.only(left: 16.0.wp, right: 16.0.wp, top: 1.0.hp),
                child: Row(
                  children: [
                    Text("$total Task"),
                    SizedBox(
                      width: 3.0.wp,
                    ),
                    Expanded(
                        child: StepProgressIndicator(
                      totalSteps: total == 0 ? 1 : total,
                      currentStep: _homeController.doneTodos.length,
                      size: 5,
                      padding: 0,
                      selectedGradientColor: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          color.withOpacity(.5),
                          color,
                        ],
                      ),
                      unselectedColor: Colors.grey[300]!,
                    ))
                  ],
                ),
              );
            }),
            TextFormField(
              autofocus: true,
              controller: _homeController.editController,
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!)),
                  prefixIcon: Icon(
                    Icons.check_box_outline_blank_outlined,
                    color: Colors.grey[400]!,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (_homeController.formKey.currentState!.validate()){
                       var success = _homeController.addTodo(_homeController.editController.text);
                       if (success) {
                        EasyLoading.showSuccess('Todo Item added successfully');
                       }
                       else{
                        EasyLoading.showError('Todo item is already exist');
                       }
                       _homeController.editController.clear();
                      }
                    },
                    icon: Icon(
                      Icons.done,
                      color: Colors.grey[400],
                    ),
                  )),
            ),
            DoingList(),
            DoneList(),
            
          ],
        ),
      ),
    );
  }
}
