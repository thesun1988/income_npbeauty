import 'package:flutter/material.dart';

class dropButtonWidget extends StatefulWidget {
  const dropButtonWidget({Key? key}) : super(key: key);

  @override
  State<dropButtonWidget> createState() => _dropButtonWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _dropButtonWidgetState extends State<dropButtonWidget> {
  String dropdownValue = 'Nối Mi';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Nối Mi', 'Uốn Mi', 'Nail', 'Phun Thêu Thẩm Mỹ ']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}