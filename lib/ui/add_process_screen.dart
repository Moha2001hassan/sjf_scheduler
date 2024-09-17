import 'package:flutter/material.dart';
import '../process_model.dart';

class AddProcessScreen extends StatefulWidget {
  final Function(Process) onProcessAdded;

  const AddProcessScreen({super.key, required this.onProcessAdded});

  @override
  _AddProcessScreenState createState() => _AddProcessScreenState();
}

class _AddProcessScreenState extends State<AddProcessScreen> {
  final _formKey = GlobalKey<FormState>();
  final _arrivalTimeController = TextEditingController();
  final _burstTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة عملية جديدة'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _arrivalTimeController,
                decoration: const InputDecoration(labelText: 'زمن الوصول'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال زمن الوصول';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _burstTimeController,
                decoration: const InputDecoration(labelText: 'وقت التنفيذ'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال وقت التنفيذ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addProcess,
                child: const Text('إضافة العملية'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addProcess() {
    if (_formKey.currentState!.validate()) {
      final arrivalTime = int.parse(_arrivalTimeController.text);
      final burstTime = int.parse(_burstTimeController.text);

      final process = Process(arrivalTime: arrivalTime, burstTime: burstTime);

      widget.onProcessAdded(process);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _arrivalTimeController.dispose();
    _burstTimeController.dispose();
    super.dispose();
  }
}
