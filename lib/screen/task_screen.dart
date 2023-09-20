
import 'package:concurrency_demo/utils/functions.dart';
import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({ Key? key }) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 16,),
            const Text('Simple Task'),
            const SizedBox(height: 16,),
            FilledButton(
              onPressed: () {
                debugPrint('Task Started');
                var a = simpleTask1();
                var b = simpleTask2();

                debugPrint('Task 1 nad 2 completed with value: ${a+b}');
                debugPrint('Task Ended');

              }, 
              child: const Text('Task 1'),
            ),

            const SizedBox(height: 16,),
            FilledButton(
              onPressed: () {
                debugPrint('Task Started');
                simpleTask1Future().then((value) {
                  debugPrint('Task 1 Ended with a value: $value');
                });

                simpleTask2Future().then((value) {
                  debugPrint('Task 2 Ended with a value: $value');
                });
                debugPrint('Task 1 nad 2 completed');
                debugPrint('Task Ended');

              }, 
              child: const Text('Task 2'),
            ),

            const SizedBox(height: 16,),
            FilledButton(
              onPressed: () async {
                debugPrint('Task Started');
                final a = await simpleTask1Future();

                final b = await simpleTask2Future();

                debugPrint('Task 1 and 2 completed : ${a+b}');
                debugPrint('Task Ended');

              }, 
              child: const Text('Task 3'),
            ),

            const SizedBox(height: 16,),
            FilledButton(
              onPressed: () async {
                debugPrint('Task Started');
                
                var result = await Future.wait([
                  simpleTask1FutureConcurrent(),
                  simpleTask2FutureConcurrent(),
                ]);

                debugPrint('Task 1 value: ${result[0]}');
                debugPrint('Task 2 value: ${result[1]}');
                debugPrint('Task 1 and 2 completed : ${result[0]+result[1]}');
                debugPrint('Task Ended');

              }, 
              child: const Text('Task 4'),
            )

          ],
        ),
      ),
    );
  }
}