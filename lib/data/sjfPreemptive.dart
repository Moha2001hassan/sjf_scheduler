import '../process_model.dart';

List<Process> sjfPreemptive(List<Process> processes) {
  int time = 0;
  List<Process> completedProcesses = [];
  List<Process> arrivedProcesses = [];

  while (completedProcesses.length < processes.length) {
    arrivedProcesses.addAll(
        processes.where((p) => p.arrivalTime == time && !arrivedProcesses.contains(p)));

    var availableProcesses = arrivedProcesses.where((p) => p.remainingTime > 0).toList();

    if (availableProcesses.isNotEmpty) {
      Process currentProcess = availableProcesses.reduce((a, b) => a.remainingTime < b.remainingTime ? a : b);

      currentProcess.remainingTime--;
      time++;

      if (currentProcess.remainingTime == 0) {
        currentProcess.completionTime = time;
        currentProcess.turnaroundTime = currentProcess.completionTime - currentProcess.arrivalTime;
        currentProcess.waitingTime = currentProcess.turnaroundTime - currentProcess.burstTime;
        completedProcesses.add(currentProcess);
        arrivedProcesses.remove(currentProcess);
      }
    } else {
      time++;
    }
  }
  return processes;
}

