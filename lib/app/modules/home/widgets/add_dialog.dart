import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo/app/modules/home/controller.dart';
import 'package:todo/app/core/utils/extensions.dart';

class AddDialog extends StatelessWidget {
  AddDialog({super.key});

  final _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _homeController.formKey,
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                    _homeController.editController.clear();
                    _homeController.changeTask(select: null);
                  },
                  icon: const Icon(Icons.close),
                ),
                TextButton(
                    onPressed: () {
                      if (_homeController.formKey.currentState!.validate()) {
                        if (_homeController.task.value == null) {
                          EasyLoading.showInfo("Please select task type");
                        } else {
                          var success = _homeController.updateTask(
                            _homeController.task.value!,
                            _homeController.editController.text,
                          );
                          if (success) {
                            EasyLoading.showSuccess(
                                "Todo item successfully added.");
                            Get.back();
                            _homeController.editController.clear();
                            _homeController.changeTask(select: null);
                          } else {
                            EasyLoading.showError("Todo item is already exist");
                          }
                        }
                      }
                    },
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14.0.sp,
                      ),
                    ))
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: Text(
                "New Task",
                style: TextStyle(
                  fontSize: 18.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: TextFormField(
                controller: _homeController.editController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.grey[400]!,
                  )),
                ),
                autofocus: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please Enter Your Todo Item";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 5.0.wp,
                right: 5.0.wp,
                top: 1.0.hp,
                bottom: 1.0.hp,
              ),
              child: Text(
                'Add to',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 10.0.sp,
                ),
              ),
            ),
            ..._homeController.tasks.map((element) => Obx(
                  () => InkWell(
                    onTap: () {
                      _homeController.changeTask(select: element);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 1.0.hp, horizontal: 5.0.wp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                IconData(element.icon,
                                    fontFamily: 'MaterialIcons'),
                                color: HexColor.fromHex(element.color),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                element.title,
                                style: TextStyle(
                                    fontSize: 12.0.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          if (_homeController.task.value == element)
                            const Icon(
                              Icons.check,
                              color: Colors.blue,
                            ),
                        ],
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
