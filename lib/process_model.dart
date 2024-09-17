import 'package:flutter/material.dart';

class Process {
  final String id;
  final int arrivalTime;
  final int burstTime;
  int remainingTime;
  int completionTime = 0;
  int waitingTime = 0;
  int turnaroundTime = 0;

  Process({
    String? id,
    required this.arrivalTime,
    required this.burstTime,
  })  : remainingTime = burstTime, id = id ?? UniqueKey().toString();
}
