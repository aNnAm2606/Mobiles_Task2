import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2.0),
  ),
);

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> age = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
    '32',
    '33',
    '34',
    '35',
    '36',
    '37',
    '38',
    '39',
    '40',
    '41',
    '42',
    '43',
    '44',
    '45',
    '46',
    '47',
    '48',
    '49',
    '50'
  ];

  //form values
  String _currentName = '';
  String _currentAge = '';
  int _currentHeight = 0;
  int _currentWeight = 70;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Text(
              'Update your data',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              decoration: const InputDecoration(
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                ),
                icon: Icon(Icons.person),
                hintText: 'What do people call you?',
                labelText: 'Name *',
              ),
              validator: (val) =>
                  val!.isNotEmpty ? null : 'Please enter a name',
              onChanged: (val) => setState(() => _currentName = val),
            ),
            const SizedBox(
              height: 20.0,
            ),
            //height
            TextFormField(
              decoration: const InputDecoration(
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                ),
                icon: Icon(Icons.height),
                hintText: 'In cm bc we are in Europe',
                labelText: 'Height *',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value) =>
                  setState(() => _currentHeight = int.parse(value)),
            ),
            const SizedBox(
              height: 20.0,
            ),
            //dropdown for age
            DropdownButtonFormField<String>(
              hint: const Text('How young are you?'),
              items: age.map((age) {
                return DropdownMenuItem(
                  value: age,
                  child: Text("$age years old"),
                );
              }).toList(),
              onChanged: (val) => setState(() => _currentAge = val!),
            ),
            const SizedBox(
              height: 20.0,
            ),
            //slider for weight
            const SizedBox(
              height: 20.0,
              width: 800.0,
              child: Text(
                'Your weight?',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16.0, color: Colors.black87),
              ),
            ),
            Slider(
              value: (_currentWeight.toDouble()),
              onChanged: (val) => setState(
                () => _currentWeight = val.round(),
              ),
              label: _currentWeight.round().toString(),
              min: 20,
              max: 220,
              divisions: 200,
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
                onPressed: () {
                  print(_currentName);
                  print(_currentAge);
                  print(_currentHeight);
                  print(_currentWeight);
                },
                child: const Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
