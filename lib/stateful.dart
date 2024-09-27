import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/services/hardware_keyboard.dart';

class MyStateFulPage extends StatefulWidget {
  //const MyStateFulPage({super.key});

  @override
  State<MyStateFulPage> createState() => _MyStateFulPageState();
}

class _MyStateFulPageState extends State<MyStateFulPage> {
  String name = "Hello World";
  int counter = 0;
  String info = "";
  final TextEditingController _name = TextEditingController();
  final TextEditingController _age = TextEditingController();

  final List<bool> _checkedList = [false, false, false, false];
  final List<String> _hobbies = ["Reading", "Sleeping", "Eating", "Learning"];
  String selectedHobby = "Reading";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _name,
              decoration: const InputDecoration(
                  hintText: 'Enter name',
                  labelText: 'Name',
                  suffixIcon: Icon(Icons.person),
                  prefixIcon: Icon(Icons.contact_phone)),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _age,
              decoration: const InputDecoration(
                  hintText: 'Enter age',
                  labelText: 'Age',
                  suffixIcon: Icon(Icons.lock)),
            ),
            const SizedBox(
              height: 20,
            ),
            const TextField(
              maxLines: 2,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Phone no',
                  labelText: 'Phone',
                  suffixIcon: Icon(Icons.lock),
                  helperText: 'Please enter phone no',
                  helperStyle: TextStyle(color: Colors.red)),
            ),
            for (int i = 0; i < _checkedList.length; i++)
              //myRadio(, _checkedList[i]),
              myCheckBox(_checkedList[i], _hobbies[i], i),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    info =
                        "Your information is Name : ${_name.text} and Age is ${_age.text}";
                    print(info);
                  });
                },
                child: Text('Save'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            counter++;
            name = "Hello Myo! $counter";
          });
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Widget myRadio(bool selected, String name) {
    return Row(
      children: [
        Radio<String>(
            value: _hobbies[0],
            groupValue: selectedHobby,
            onChanged: (bool) {
              setState(() {
                selectedHobby = bool!;
              });
            }),
        Text(name)
      ],
    );
  }

  Widget myCheckBox(bool checked, String name, int index) {
    return Row(
      children: [
        Checkbox(
            value: checked,
            onChanged: (bool) {
              setState(() {
                _checkedList[index] = bool!;
              });
              print('Checked : $name and $bool');
            }),
        Text(name)
      ],
    );
  }
}
