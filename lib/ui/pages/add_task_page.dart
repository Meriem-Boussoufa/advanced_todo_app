import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/ui/theme.dart';
import 'package:todo_app/ui/widgets/button.dart';

import '../../models/task.dart';
import '../widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  @override
  Widget build(BuildContext context) {
    List<int> remindList = [5, 10, 15, 20];

    List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Add Task', style: headingStyle),
              const SizedBox(height: 15),
              InputField(
                title: 'Title',
                hint: 'Enter title here',
                controller: titleController,
              ),
              const SizedBox(height: 15),
              InputField(
                title: 'Note',
                hint: 'Enter note here',
                controller: noteController,
              ),
              const SizedBox(height: 15),
              InputField(
                title: 'Date',
                hint: DateFormat.yMd().format(selectedDate),
                widget: IconButton(
                    onPressed: () => _getDateFromUser(),
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                    )),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: 'Start Time',
                      hint: startTime,
                      widget: IconButton(
                          onPressed: () => _getTimeFromUser(isStartTime: true),
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          )),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: InputField(
                      title: 'End Time',
                      hint: endTime,
                      widget: IconButton(
                          onPressed: () => _getTimeFromUser(isStartTime: false),
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          )),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              InputField(
                title: 'Remind',
                hint: '$selectedRemind minutes early',
                widget: Row(
                  children: [
                    DropdownButton(
                      dropdownColor: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(10),
                      items: remindList
                          .map<DropdownMenuItem<String>>(
                            (int value) => DropdownMenuItem<String>(
                              value: value.toString(),
                              child: Text(
                                '$value',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                      iconSize: 32,
                      elevation: 4,
                      underline: Container(height: 0),
                      style: subTitleStyle,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedRemind = int.parse(newValue!);
                        });
                      },
                    ),
                    const SizedBox(width: 6),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              InputField(
                  title: 'Repeat',
                  hint: selectedRepeat,
                  widget: Row(
                    children: [
                      DropdownButton(
                        dropdownColor: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10),
                        items: repeatList
                            .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        iconSize: 32,
                        elevation: 4,
                        underline: Container(height: 0),
                        style: subTitleStyle,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedRepeat = newValue!;
                          });
                        },
                      ),
                      const SizedBox(width: 6),
                    ],
                  )),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPalette(),
                  MyButton(
                      label: 'Create Task',
                      onTap: () {
                        _validateDate();
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 24,
          color: primaryClr,
        ),
        onPressed: () => Get.back(),
      ),
      elevation: 0,
      backgroundColor: context.theme.colorScheme.background,
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('images/person.jpeg'),
          radius: 18,
        ),
        SizedBox(width: 20),
      ],
    );
  }

  final TaskController taskController = Get.put(TaskController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(
        minutes: 15,
      )))
      .toString();
  String selectedRepeat = 'None';

  int selectedRemind = 5;

  _validateDate() {
    if (titleController.text.isNotEmpty && noteController.text.isNotEmpty) {
      _addTasksToDb();
      Get.back();
    } else if (titleController.text.isEmpty || noteController.text.isEmpty) {
      Get.snackbar(
        'required',
        'All fields are required!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: pinkClr,
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
        ),
      );
    } else {
      print('###### SOMETHING BAD HAPPENED ######');
    }
  }

  _addTasksToDb() async {
    try {
      await taskController.addTask(
        task: Task(
          title: titleController.text,
          note: noteController.text,
          isCompleted: 0,
          date: DateFormat.yMd().format(selectedDate),
          startTime: startTime,
          endTime: endTime,
          color: selectedColor,
          repeat: selectedRepeat,
          remind: selectedRemind,
        ),
      );
    } catch (e) {
      print('Error');
    }
  }

  int selectedColor = 0;

  Column _colorPalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Color', style: titleStyle),
        const SizedBox(height: 8),
        Wrap(
          children: List<Widget>.generate(3, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  backgroundColor: index == 0
                      ? primaryClr
                      : index == 1
                          ? pinkClr
                          : orangeClr,
                  radius: 14,
                  child: selectedColor == index
                      ? const Icon(
                          Icons.done,
                          size: 16,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
            );
          }),
        )
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null)
      setState(() => selectedDate = pickedDate);
    else
      print('It\'s null or someting is wrong');
  }

  _getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(const Duration(minutes: 15))),
    );
    // ignore: use_build_context_synchronously
    String formattedTime = pickedTime!.format(context);

    if (isStartTime)
      setState(() => startTime = formattedTime);
    else if (!isStartTime)
      setState(() => endTime = formattedTime);
    else
      print('It\'s null or someting is wrong');
  }
}
