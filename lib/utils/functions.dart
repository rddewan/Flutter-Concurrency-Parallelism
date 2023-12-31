

import 'dart:async';

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

Future<int> simpleTask1FutureConcurrent() async {
  debugPrint('Task 1 started');
  var sum  = 0;

  for (var i = 0; i < 30; i++) {
    await Future.delayed(const Duration(seconds: 1), () {
      sum += i;
      debugPrint('Task 1 sum: $sum');
    });
    
  }
  debugPrint('Task 1 ended');

  return sum;
}

Future<int>  simpleTask2FutureConcurrent() async{
  debugPrint('Task 2 started');
  var sum  = 0;

  for (var i = 0; i < 10; i++) {
    await Future.delayed(const Duration(seconds: 1), () {
      sum += i;
      debugPrint('Task 2 sum: $sum');
    });
  }

  debugPrint('Task 2 ended');

  return sum;
}

Future<String>  simpleTask3FutureConcurrent() async{
  debugPrint('Task 3 started');
  var completer = Completer<String>();
  

  Future.delayed(const Duration(seconds: 5), () {    
    debugPrint('Task 3 value: Richard');
    completer.complete('Richard');

  });

  debugPrint('Task 3 ended');

  return completer.future;
}

Future<int>  simpleTask4FutureConcurrent(int count) async{
  debugPrint('Task 4 started');
  var sum  = 0;

  for (var i = 0; i < count; i++) {
    await Future.delayed(const Duration(seconds: 1), () {
      sum += i;
      debugPrint('Task 2 sum: $sum');
    });
  }

  debugPrint('Task 4 ended');

  return sum;
}