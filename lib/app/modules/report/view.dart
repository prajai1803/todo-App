import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo/app/core/values/colors.dart';
import 'package:todo/app/modules/home/controller.dart';
import 'package:todo/app/core/utils/extensions.dart';

class ReportPage extends StatelessWidget {
  final _controller = Get.find<HomeController>();
  ReportPage({super.key});

  Widget _buildStatus(Color color, int number, String label) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 3.0.hp,
          width: 3.0.wp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 0.5.wp,
              color: color,
            ),
          ),
        ),
        SizedBox(
          width: 3.0.wp,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$number',
              style: TextStyle(
                fontSize: 12.0.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12.0.sp,
              ),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          var createdTask = _controller.getTotalTask();
          var completedTask = _controller.getTotalDoneTask();
          var liveTask = createdTask - completedTask;
          var percentage = (completedTask / createdTask * 100).toString();
          return ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(3.0.wp),
                child: Text(
                  'My Report',
                  style: TextStyle(
                    fontSize: 24.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                child: Text(
                  DateFormat.yMMMd().format(DateTime.now()),
                  style: TextStyle(fontSize: 12.0.sp, color: Colors.grey[400]),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                child: const Divider(
                  thickness: 2,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 3.0.hp, horizontal: 5.0.wp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatus(Colors.green, liveTask, 'Live Task'),
                    _buildStatus(Colors.orange, completedTask, 'Completed'),
                    _buildStatus(Colors.blue, createdTask, 'Created'),
                  ],
                ),
              ),
              SizedBox(
                height: 8.0.hp,
              ),
              UnconstrainedBox(
                child: SizedBox(
                  height: 70.0.wp,
                  width: 70.0.wp,
                  child: CircularStepProgressIndicator(
                    totalSteps: createdTask == 0 ? 1 : createdTask,
                    currentStep: completedTask,
                    stepSize: 20,
                    selectedColor: green,
                    unselectedColor: Colors.grey[400],
                    padding: 0,
                    width: 100,
                    height: 100,
                    selectedStepSize: 22,
                    roundedCap: (_, __) => true,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        
                        children: [
                        
                          Text(
                            '${createdTask == 0 ? 0 : percentage}%',
                            style: TextStyle(
                                fontSize: 14.0.sp, fontWeight: FontWeight.bold),
                          ),
                          Text("Efficiency",style: TextStyle(
                                fontSize: 12.0.sp, fontWeight: FontWeight.bold,color: Colors.grey[400]))
                        ]),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
