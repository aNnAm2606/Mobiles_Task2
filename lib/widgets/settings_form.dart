import 'package:deliverabl1task_2/services/database.dart';
import 'package:deliverabl1task_2/services/info.dart';
import 'package:deliverabl1task_2/services/user.dart';
import 'package:deliverabl1task_2/services/users.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> gender = [
    'a...',
    'a Female',
    'a Male',
    'a Non-binary',
    'an IKEA Box',
    'an Other',
  ];

  //form values
  String _currentName = '';
  String _currentGender = 'a...';
  int _currentHeight = 0;
  int _currentWeight = 70;

  @override
  Widget build(BuildContext context) {
    AuthUser? user = Provider.of<AuthUser?>(context);

    return StreamBuilder<UserData?>(
      stream: DatabaseService(uid: user!.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data!;

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
                    initialValue: userData.name,
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
                        val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  //height
                  TextFormField(
                    initialValue: userData.height.toString(),
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
                    onChanged: (value) => setState(
                        () => _currentHeight = int.tryParse(value) ?? 0),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  //dropdown for age
                  DropdownButtonFormField<String>(
                    value: _currentGender ?? userData.gender,
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
                    value: (_currentWeight ?? userData.weight)!.toDouble(),
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
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentName ?? userData.name!,
                              _currentGender ?? userData.gender!,
                              _currentHeight ?? userData.height,
                              _currentWeight ?? userData.weight);
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
              color: Colors.red,
              size: 50.0,
            ),
          );
        }
      },
    );
  }
}
