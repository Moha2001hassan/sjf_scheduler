import 'package:flutter/material.dart';
import 'ui/scheduler_screen.dart';

void main() {
  runApp(const SchedulerApp());
}

class SchedulerApp extends StatelessWidget {
  const SchedulerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SJF Scheduler Simulation',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SchedulerScreen(),
    );
  }
}
