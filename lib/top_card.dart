import 'package:flutter/material.dart';

class TopNeuCard extends StatelessWidget {
  final String balance;
  final String thisMonth;
  final String lastMonth;

  TopNeuCard({
    required this.balance,
    required this.thisMonth,
    required this.lastMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('DOANH THU',
                  style: TextStyle(color: Colors.grey[500], fontSize: 16)),
              Text(
                '\$' + balance,
                style: TextStyle(color: Colors.grey[800], fontSize: 40),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Container(
                        //   padding: EdgeInsets.all(10),
                        //   decoration: BoxDecoration(
                        //     shape: BoxShape.circle,
                        //     color: Colors.grey[200],
                        //   ),
                        //   // // child: Center(
                        //   //   child: Icon(
                        //   //     Icons.arrow_upward,
                        //   //     color: Colors.green,
                        //   //   ),
                        //   // ),
                        // ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Tháng Này',
                                style: TextStyle(color: Colors.grey[500])),
                            SizedBox(
                              height: 5,
                            ),
                            Text('\$' + thisMonth,
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        // Container(
                        //   padding: EdgeInsets.all(10),
                        //   decoration: BoxDecoration(
                        //     shape: BoxShape.circle,
                        //     color: Colors.grey[200],
                        //   ),
                        //   // child: Center(
                        //   //   child: Icon(
                        //   //     Icons.arrow_downward,
                        //   //     color: Colors.red,
                        //   //   ),
                        //   // ),
                        // ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Tháng Trước',
                                style: TextStyle(color: Colors.grey[500])),
                            SizedBox(
                              height: 5,
                            ),
                            Text('\$' + lastMonth,
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(15),
        //     color: Colors.grey[300],
        //     boxShadow: [
        //       BoxShadow(
        //           color: Colors.grey.shade500,
        //           offset: Offset(4.0, 4.0),
        //           blurRadius: 15.0,
        //           spreadRadius: 1.0),
        //       BoxShadow(
        //           color: Colors.white,
        //           offset: Offset(-4.0, -4.0),
        //           blurRadius: 15.0,
        //           spreadRadius: 1.0),
        //     ]),
      ),
    );
  }
}
