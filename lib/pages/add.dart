import 'package:finance_app/colors/colors.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String number = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Plus')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              // height: 70,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: primaryPurbleColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hint: Text(
                    'Details here ... ',
                    style: TextStyle(fontSize: 20, color: whiteColor),
                  ),
                  // contentPadding: const EdgeInsets.all(12.0),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),

            SizedBox(height: 20),
            Container(
              // height: 70,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: secondryGreenColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  number == '' ? '+ 0.00' : '+ $number',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),

            SizedBox(height: 20),
            Row(
              children: [
                NumberBotton(
                  number: '1',
                  onTap: () {
                    setState(() {
                      number += "1";
                    });
                  },
                ),

                NumberBotton(
                  number: '2',
                  onTap: () {
                    setState(() {
                      number += "2";
                    });
                  },
                ),

                NumberBotton(
                  number: '3',
                  onTap: () {
                    setState(() {
                      number += "3";
                    });
                  },
                ),
              ],
            ),

            Row(
              children: [
                NumberBotton(
                  number: '4',
                  onTap: () {
                    setState(() {
                      number += "4";
                    });
                  },
                ),

                NumberBotton(
                  number: '5',
                  onTap: () {
                    setState(() {
                      number += "5";
                    });
                  },
                ),

                NumberBotton(
                  number: '6',
                  onTap: () {
                    setState(() {
                      number += "6";
                    });
                  },
                ),
              ],
            ),

            Row(
              children: [
                NumberBotton(
                  number: '7',
                  onTap: () {
                    setState(() {
                      number += "7";
                    });
                  },
                ),
                NumberBotton(
                  number: '8',
                  onTap: () {
                    setState(() {
                      number += "8";
                    });
                  },
                ),
                NumberBotton(
                  number: '9',
                  onTap: () {
                    setState(() {
                      number += "9";
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                NumberBotton(
                  number: '.',
                  onTap: () {
                    setState(() {
                      if (!number.contains('.')) {
                        number += ".";
                      }
                    });
                  },
                ),
                NumberBotton(
                  number: '0',
                  onTap: () {
                    setState(() {
                      number += "0";
                    });
                  },
                ),
                NumberBotton(
                  number: '<<',
                  onTap: () {
                    setState(() {
                      if (number.isNotEmpty) {
                        number = number.substring(0, number.length - 1);
                      }
                    });
                  },
                ),
              ],
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},

                    style: ElevatedButton.styleFrom(
                      foregroundColor: primaryBlueColor,
                      backgroundColor: secondryBlueColor,
                      padding: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'DONE',
                      style: TextStyle(fontSize: 16, color: blackcColor),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},

                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondryRedColor,
                      padding: EdgeInsets.all(16),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'CANCEL',
                      style: TextStyle(fontSize: 16, color: blackcColor),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NumberBotton extends StatelessWidget {
  String number = '';
  Function() onTap;
  NumberBotton({super.key, required this.number, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            // height: 75,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: blackcColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(fontSize: 24, color: whiteColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
