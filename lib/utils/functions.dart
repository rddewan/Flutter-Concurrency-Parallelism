

import 'package:flutter/widgets.dart';

int simpleTask1() {
  debugPrint('Tsak 1 started');
  var sum  = 0;
  for (var i = 0; i < 100; i++) {
    sum += i;
  }
  debugPrint('Tsak 1 ended');
  return sum;
}

int simpleTask2() {
  debugPrint('Tsak 2 started');
  var sum  = 0;
  for (var i = 0; i < 200; i++) {
    sum += i;
  }
  debugPrint('Tsak 2 ended');
  return sum;
}

Future<int> simpleTask1Future() async {
  debugPrint('Task 1 started');
  var sum  = 0;
  for (var i = 0; i < 100; i++) {
    sum += i;
  }
  debugPrint('Task 1 ended');
  return sum;
}

Future<int>  simpleTask2Future() async{
  debugPrint('Task 2 started');
  var sum  = 0;
  for (var i = 0; i < 200; i++) {
    sum += i;
  }
  debugPrint('Task 2 ended');
  return sum;
}