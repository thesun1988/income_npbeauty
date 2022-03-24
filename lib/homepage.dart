import 'dart:async';
import 'package:flutter/material.dart';
import 'google_sheets_api.dart';
import 'loading_circle.dart';
import 'plus_button.dart';
import 'top_card.dart';
import 'transaction.dart';
import 'drop_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // collect user input
  final _textcontrollerAMOUNT = TextEditingController();
  var _textcontrollerITEM = 'Nối Mi';
  final _formKey = GlobalKey<FormState>();
  late var _textcontrollerDATE;
  late var _textcontrollerDATECOPY;

  // enter the new transaction into the spreadsheet
  void _enterTransaction() {
    GoogleSheetsApi.insert(
      _textcontrollerITEM,
      _textcontrollerAMOUNT.text,
      _textcontrollerDATE = DateTime.now().toString().substring(0, 16),
      _textcontrollerDATECOPY = DateTime.now().toString().substring(0, 10),
    );
    // GoogleSheetsApi.updateThisMonth();
    // GoogleSheetsApi.updateIncome();
    setState(() {
      
    });
    //
  }

  // new transaction
  void _newTransaction() {
    String dropdownValue = 'Nối Mi';
    _textcontrollerITEM = dropdownValue;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
                title: Center(child: Text('L Ú A  V Ô')),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     Text('Expense'),
                      //     Switch(
                      //       value: _isIncome,
                      //       onChanged: (newValue) {
                      //         setState(() {
                      //           _isIncome = newValue;
                      //         });
                      //       },
                      //     ),
                      //     Text('Income'),
                      //   ],
                      // ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Bao Nhiêu?',
                                ),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Nhập Số Tiền';
                                  }
                                  return null;
                                },
                                controller: _textcontrollerAMOUNT,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      DropdownButton<String>(
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
                            _textcontrollerITEM = dropdownValue;
                            print(dropdownValue);
                          });
                        },
                        items: <String>[
                          'Nối Mi',
                          'Uốn Mi',
                          'Nail',
                          'Phun Thêu Thẩm Mỹ '
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: TextField(
                      //         decoration: InputDecoration(
                      //           border: OutlineInputBorder(),
                      //           hintText: 'For what?',
                      //         ),
                      //         controller: _textcontrollerITEM,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                          color: Colors.grey[600],
                          child: Text('Nhầm',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        MaterialButton(
                          color: Colors.grey[600],
                          child: Text('OK!',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _enterTransaction();
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          );
        });
  }

  // wait for the data to be fetched from google sheets
  bool timerHasStarted = false;
  void startLoading() {
    timerHasStarted = true;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (GoogleSheetsApi.loading == false) {
        setState(() {});
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // start loading until the data arrives
    if (GoogleSheetsApi.loading == true && timerHasStarted == false) {
      startLoading();
    }

    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                TopNeuCard(
                  balance: GoogleSheetsApi.calculateIncome().toString(),
                  thisMonth: GoogleSheetsApi.calculateThisMonth().toString(),
                  lastMonth: GoogleSheetsApi.lastMonth,
                ),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: GoogleSheetsApi.loading == true
                                ? LoadingCircle()
                                : ListView.builder(
                                    //reverse: true,
                                    itemCount: GoogleSheetsApi
                                        .currentTransactions.length,
                                    itemBuilder: (context, index) {
                                      return MyTransaction(
                                        transactionName: GoogleSheetsApi
                                            .currentTransactions[index][0],
                                        money: GoogleSheetsApi
                                            .currentTransactions[index][1],
                                        date: GoogleSheetsApi
                                            .currentTransactions[index][2],
                                      );
                                    }),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // PlusButton(
                //   function: _newTransaction,
                // ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            _newTransaction();
          },
        ));
  }
}
