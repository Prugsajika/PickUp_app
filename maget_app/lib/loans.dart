import 'package:flutter/material.dart';

const List<String> list = <String>[
  '1000000001',
  '1000000002',
  '1000000003',
  '1000000004'
];

class LoansPage extends StatefulWidget {
  static const routeName = '/';

  const LoansPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoansPageState();
  }
}

class _LoansPageState extends State<LoansPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loans '),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'บัญชี   ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                DropdownButtonExample(),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Text('ยอดเงินต้นคงเหลือ  ',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF00B686))),
        ],
      )),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 36,
      dropdownColor: Color(0XFF00B686),
      elevation: 16,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        //color: Color(0XFF00B686),
      ),
      underline: Container(
        height: 1,
        color: Colors.white,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
