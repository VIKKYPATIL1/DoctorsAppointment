import 'package:doctor_appoinment/data_model/record.dart';
import 'package:flutter/material.dart';

class NewPatientRecord extends StatefulWidget {
  const NewPatientRecord({super.key, required this.addPatientRecord});
  final void Function(RecordOfPatient recordofpatient) addPatientRecord;
  @override
  State<NewPatientRecord> createState() {
    return NewPatientRecordState();
  }
}

class NewPatientRecordState extends State<NewPatientRecord> {
  Category _selectedanswer = Category.general;
  final _nameController = TextEditingController();
  final _feescontroller = TextEditingController();
  final _problemcontroller = TextEditingController();
  DateTime? selectedDate;
  void selectedInputDate() async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate =
        DateTime(initialDate.year - 1, initialDate.month, initialDate.day);
    DateTime? inputDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: initialDate);

    setState(() {
      selectedDate = inputDate;
    });
  }

  void validateInputData() {
    double? fees = double.tryParse(_feescontroller.text);
    if (fees == null ||
        fees == 0 ||
        _nameController.text.isEmpty ||
        selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Please Fill Out All Fields'),
            content: const Text('One of the field is empty'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text('Okay'))
            ],
          );
        },
      );
      return;
    }
    widget.addPatientRecord(
      RecordOfPatient(
          name: _nameController.text,
          fees: fees,
          date: selectedDate!,
          category: _selectedanswer,
          problem: _problemcontroller.text),
    );
    Navigator.pop(context);
    return;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _feescontroller.dispose();
    _problemcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardspace = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + keyboardspace),
          child: Column(
            children: [
              TextField(
                autocorrect: true,
                maxLength: 45,
                decoration: const InputDecoration(
                  label: Text('Enter Name'),
                ),
                controller: _nameController,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DropdownButton(
                    value: _selectedanswer,
                    items: Category.values
                        .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toString())))
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        _selectedanswer = value;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    child: TextField(
                      autocorrect: true,
                      maxLength: 5,
                      controller: _feescontroller,
                      decoration: const InputDecoration(
                        label: Text('Enter Amount'),
                        prefixIcon: Icon(Icons.currency_rupee_sharp),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      autocorrect: true,
                      controller: _problemcontroller,
                      decoration: const InputDecoration(
                        label: Text('Enter Issue'),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        selectedDate == null
                            ? 'No date selected'
                            : formatter.format(selectedDate!),
                      ),
                      IconButton(
                          onPressed: selectedInputDate,
                          icon: const Icon(Icons.calendar_month))
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton.icon(
                      onPressed: validateInputData,
                      icon: const Icon(Icons.add_box_rounded),
                      label: const Text('Submit')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
