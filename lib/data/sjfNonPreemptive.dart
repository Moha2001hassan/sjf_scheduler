import '../process_model.dart';

List<Process> sjfNonPreemptive(List<Process> processes) {
  List<Process> completedProcesses = [];
  int currentTime = 0;
  List<Process> availableProcesses = [];

  while (completedProcesses.length < processes.length) {
    availableProcesses.addAll(processes.where((p) =>
    p.arrivalTime <= currentTime && !completedProcesses.contains(p)));

    if (availableProcesses.isEmpty) {
      currentTime++;
      continue;
    }

    Process currentProcess = availableProcesses.reduce((a, b) => a.burstTime < b.burstTime ? a : b);

    currentProcess.waitingTime = currentTime - currentProcess.arrivalTime;
    currentTime += currentProcess.burstTime;
    currentProcess.completionTime = currentTime;
    currentProcess.turnaroundTime = currentProcess.completionTime - currentProcess.arrivalTime;

    completedProcesses.add(currentProcess);
    availableProcesses.remove(currentProcess);
  }

  return processes;
}

