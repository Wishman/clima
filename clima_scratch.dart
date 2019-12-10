// sync vs async sample

import 'dart:io';

void main() {
  performTasks();
}

void performTasks() async {
  task1();
  String task2Result = await task2();
  task3(task2Result);
}

void task1() {
  String result = 'task 1 data';
  print('Task 1 complete');
}

Future<String> task2() async {
  // simulate time consuming task
  Duration threeSecs = Duration(seconds: 3);
  //sleep(threeSecs); // sleep is a synchronous func = pause for 3 secs

  String result;

  // async method because it returns a Future
  await Future.delayed(threeSecs, () {
    result = 'task 2 data';
    print('Task 2 complete');
  });

  return result;
}

// if task three needs input fron task 2, Futures are no longer enough
void task3(String task2Data) {
  String result = 'task 3 data';
  print('Task 3 complete with $task2Data');
}
