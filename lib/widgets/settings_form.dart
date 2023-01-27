import 'package:deliverabl1task_2/services/database.dart';
import 'package:deliverabl1task_2/services/info.dart';
import 'package:deliverabl1task_2/services/user.dart';
import 'package:deliverabl1task_2/services/users.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

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
  final List<String> gender = [
    'a Female',
    'a Male',
    'a Non-binary',
    'an IKEA Box',
    'an Other',
  ];

  //form values
  String _currentName = '';
  String _currentGender = '';
  int _currentHeight = 0;
  int _currentWeight = 70;
  

  @override
  Widget build(BuildContext context) {
    AuthUser? user = Provider.of<AuthUser?>(context);

    return StreamBuilder<UserData?>(
      stream: DatabaseService(uid: user?.uid).userData,
      builder: (context, snapshot) {
        UserData? userData = snapshot.data;

        //form values
        String initialName = userData!.name;
        String initialGender = userData.gender;
        int initialHeight = userData.height;
        int initialWeight = userData.weight;

        if (snapshot.hasData) {
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
                    initialValue: initialName,
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
                    initialValue: initialHeight.toString(),
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
                    value: initialGender,
                    hint: const Text('Who are you?'),
                    items: gender.map((gender) {
                      return DropdownMenuItem(
                        value: gender,
                        child: Text("You are $gender"),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentGender = val!),
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
                    activeColor: Colors.red,
                    value: (_currentWeight.toDouble()),
                    onChanged: (val) => setState(
                      () => _currentWeight = val.round(),
                    ),
                    label: _currentWeight.round().toString(),
                    min: 0,
                    max: 200,
                    divisions: 200,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: user!.uid).updateUserData(
                              _currentName ?? initialName,
                              _currentGender ?? initialGender,
                              _currentHeight ?? initialHeight,
                              _currentWeight ?? initialWeight);
                        }

                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          );
        } else {
          return Container(
            child: SpinKitChasingDots(
              size: 50.0,
            ),
          );
        }
      },
    );
  }
}
