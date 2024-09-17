import 'package:flutter/material.dart';
import '../data/sjfNonPreemptive.dart';
import '../data/sjfPreemptive.dart';
import '../process_model.dart';
import 'add_process_screen.dart';

class SchedulerScreen extends StatefulWidget {
  const SchedulerScreen({super.key});

  @override
  _SchedulerScreenState createState() => _SchedulerScreenState();
}

class _SchedulerScreenState extends State<SchedulerScreen> {
  List<Process> processes = [];
  List<Process> scheduledProcesses = [];
  bool isPreemptive = false;

  @override
  Widget build(BuildContext context) {
    final hasResults = scheduledProcesses.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        title: const Text('SJF Scheduler'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (processes.isEmpty)
              const Center(child: Text('لا توجد عمليات. الرجاء إضافة عمليات.')),
            if (processes.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: processes.length,
                  itemBuilder: (context, index) {
                    final process = processes[index];
                    return ListTile(
                      title: Text('Process ${process.id}'),
                      subtitle: Text('زمن الوصول: ${process.arrivalTime}, وقت التنفيذ: ${process.burstTime}'),
                    );
                  },
                ),
              ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: isPreemptive,
                  onChanged: _togglePreemption,
                ),
                const Text('Preemptive (SRTF)'),
              ],
            ),
            ElevatedButton(
              onPressed: _runSimulation,
              child: const Text('تشغيل المحاكاة'),
            ),
            ElevatedButton(
              onPressed: _navigateToAddProcess,
              child: const Text('إضافة عملية جديدة'),
            ),
            ElevatedButton(
              onPressed: _resetSimulation,
              child: const Text('إعادة التعيين'),
            ),
            const SizedBox(height: 20),
            if (hasResults)
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: _buildProcessTable(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _addProcess(Process process) {
    setState(() => processes.add(process));
  }

  void _runSimulation() {
    if (isPreemptive) {
      scheduledProcesses = sjfPreemptive([...processes]);
    } else {
      scheduledProcesses = sjfNonPreemptive([...processes]);
    }
    setState(() {});
  }

  void _resetSimulation() {
    setState(() {
      scheduledProcesses.clear();
      processes.clear();
    });
  }

  void _navigateToAddProcess() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddProcessScreen(onProcessAdded: _addProcess),
      ),
    );
  }

  void _togglePreemption(bool? value) {
    setState(() => isPreemptive = value ?? false);
  }

  Widget _buildProcessTable() {
    return DataTable(
      columns: const [
        DataColumn(label: Text('ID')),
        DataColumn(label: Text('زمن الوصول')),
        DataColumn(label: Text('وقت التنفيذ')),
        DataColumn(label: Text('وقت الانتظار')),
        DataColumn(label: Text('وقت الانتهاء')),
        DataColumn(label: Text('الزمن المستغرق')),
      ],
      rows: scheduledProcesses
          .map(
            (process) => DataRow(
              cells: [
                DataCell(Text(process.id)),
                DataCell(Text('${process.arrivalTime}')),
                DataCell(Text('${process.burstTime}')),
                DataCell(Text('${process.waitingTime}')),
                DataCell(Text('${process.completionTime}')),
                DataCell(Text('${process.turnaroundTime}')),
              ],
            ),
          ).toList(),
    );
  }
}
