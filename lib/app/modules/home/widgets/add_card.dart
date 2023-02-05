import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo/app/core/utils/extensions.dart';
import 'package:todo/app/core/values/colors.dart';
import 'package:todo/app/modules/home/controller.dart';
import 'package:todo/app/modules/widgets/icons.dart';

import '../../../data/models/tasks.dart';

class AddCard extends StatelessWidget {
  AddCard({super.key});

  final _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var sqareWith = Get.width - 12.0.wp;
    return Container(
      width: sqareWith / 2,
      height: sqareWith / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
          onTap: () {
            Get.defaultDialog(
                titlePadding: EdgeInsets.symmetric(vertical: 5.0.hp),
                radius: 5,
                title: 'Task Type',
                content: Form(
                  key: _homeController.formKey,
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                      child: TextFormField(
                        controller: _homeController.editController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'title',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your task title';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.0.hp),
                      child: Wrap(
                        spacing: 2.0.wp,
                        children: icons
                            .map((e) => Obx(() {
                                  final index = icons.indexOf(e);
                                  return ChoiceChip(
                                    backgroundColor: Colors.white,
                                    selectedColor: Colors.grey[200],
                                    label: e,
                                    selected: _homeController.chipIndex.value ==
                                        index,
                                    onSelected: (bool value) {
                                      _homeController.chipIndex.value =
                                          value ? index : 0;
                                    },
                                  );
                                }))
                            .toList(),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minimumSize: const Size(150, 40)),
                        onPressed: () {
                          if (_homeController.formKey.currentState!
                              .validate()) {
                            int icon = icons[_homeController.chipIndex.value]
                                .icon!
                                .codePoint;
                            String color =
                                icons[_homeController.chipIndex.value]
                                    .color!
                                    .toHex();
                            var task = Task(
                              title: _homeController.editController.value.text,
                              icon: icon,
                              color: color,
                            );
                            Get.back();
                            _homeController.addTask(task)
                                ? EasyLoading.showSuccess(
                                    "Created Successfully.")
                                : EasyLoading.showError("Duplicate Task");
                          }
                        },
                        child: Text(
                          'Confirm',
                          style: TextStyle(fontSize: 10.0.sp),
                        ))
                  ]),
                ));
                _homeController.editController.clear();
                _homeController.changeChipIndex(0);
          },
          child: DottedBorder(
            color: Colors.grey[400]!,
            dashPattern: [9, 4],
            child: Center(
              child: Icon(
                Icons.add,
                size: 10.0.wp,
                color: Colors.grey,
              ),
            ),
          )),
    );
  }
}
