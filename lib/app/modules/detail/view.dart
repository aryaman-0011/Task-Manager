import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:task_manager/app/core/utils/extensions.dart';
import 'package:task_manager/app/modules/detail/widgets/doing_list.dart';
import 'package:task_manager/app/modules/detail/widgets/done_list.dart';
import 'package:task_manager/app/modules/home/controller.dart';

class DetailPage extends StatelessWidget {
  final homectrl = Get.find<HomeController>();
  DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    var task = homectrl.task.value!;
    var color = HexColor.fromHex(task.color);
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Form(
          key: homectrl.formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(3.0.wp),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                        homectrl.updateTodos();
                        homectrl.changeTask(null);
                        homectrl.editCtrl.clear();
                      },
                      icon: const Icon(Icons.arrow_back),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0.wp,
                ),
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
                        fontSize: 12.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              Obx(() {
                var totalTodos =
                    homectrl.doingTodos.length + homectrl.doneTodos.length;
                return Padding(
                  padding: EdgeInsets.only(
                    left: 16.0.wp,
                    top: 3.0.wp,
                    right: 16.0.wp,
                  ),
                  child: Row(
                    children: [
                      Text(
                        '$totalTodos Tasks',
                        style: TextStyle(
                          fontSize: 12.0.sp,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 3.0.wp,
                      ),
                      Expanded(
                          child: StepProgressIndicator(
                        totalSteps: totalTodos == 0 ? 1 : totalTodos,
                        currentStep: homectrl.doneTodos.length,
                        size: 5,
                        padding: 0,
                        selectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [color.withOpacity(0.5), color],
                        ),
                        unselectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.grey[300]!, Colors.grey[300]!],
                        ),
                      ))
                    ],
                  ),
                );
              }),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 2.0.wp,
                  horizontal: 5.0.wp,
                ),
                child: TextFormField(
                  controller: homectrl.editCtrl,
                  autofocus: true,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green[300]!),
                      ),
                      prefixIcon: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.grey[400],
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (homectrl.formKey.currentState!.validate()) {
                            var success =
                                homectrl.addTodo(homectrl.editCtrl.text);
                            if (success) {
                              EasyLoading.showSuccess('Item added successfully');
                            } else {
                              EasyLoading.showError('Item already exist');
                            }
                            homectrl.editCtrl.clear();
                          }
                        },
                        icon: const Icon(Icons.done),
                      )),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your todo item';
                    }
                    return null;
                  },
                ),
              ),
              DoingList(),
              DoneList(),
            ],
          ),
        ),
      ),
    );
  }
}
