import 'package:finance_app/colors/colors.dart';
import 'package:finance_app/cubit/add_cubit/add_data_cubit_cubit.dart';
import 'package:finance_app/cubit/fetch_cubit/fetch_data_cubit.dart';
import 'package:finance_app/models/finance_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPage extends StatefulWidget {
  FinanceModel? financeModel;
  final bool isMinus; // New parameter to determine if it's for minus operations

  AddPage({super.key, this.financeModel, this.isMinus = false});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  late TextEditingController detailsController;
  String number = '';

  @override
  void initState() {
    BlocProvider.of<FetchDataCubit>(context).fetchData();
    super.initState();
    detailsController = TextEditingController();
    if (widget.financeModel != null) {
      detailsController.text = widget.financeModel!.details;
      number = widget.financeModel!.financeValue.abs().toString();
    }
  }

  @override
  void dispose() {
    detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(widget.isMinus ? 'Minus' : 'Plus'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => AddDataCubit(),
        child: BlocBuilder<AddDataCubit, AddDataState>(
          builder: (context, state) => SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: primaryPurbleColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: detailsController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Details here ... ',
                      hintStyle: TextStyle(fontSize: 18, color: whiteColor),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                    ),
                    style: TextStyle(fontSize: 18, color: whiteColor),
                  ),
                ),

                SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: widget.isMinus
                        ? secondryRedColor
                        : secondryGreenColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      number == ''
                          ? (widget.isMinus ? '- 0.00' : '+ 0.00')
                          : (widget.isMinus ? '- $number' : '+ $number'),
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                Container(
                  height: 460,
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            _buildNumberButton('1', () {
                              setState(() {
                                number += "1";
                              });
                            }),
                            _buildNumberButton('2', () {
                              setState(() {
                                number += "2";
                              });
                            }),
                            _buildNumberButton('3', () {
                              setState(() {
                                number += "3";
                              });
                            }),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Expanded(
                        child: Row(
                          children: [
                            _buildNumberButton('4', () {
                              setState(() {
                                number += "4";
                              });
                            }),
                            _buildNumberButton('5', () {
                              setState(() {
                                number += "5";
                              });
                            }),
                            _buildNumberButton('6', () {
                              setState(() {
                                number += "6";
                              });
                            }),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Expanded(
                        child: Row(
                          children: [
                            _buildNumberButton('7', () {
                              setState(() {
                                number += "7";
                              });
                            }),
                            _buildNumberButton('8', () {
                              setState(() {
                                number += "8";
                              });
                            }),
                            _buildNumberButton('9', () {
                              setState(() {
                                number += "9";
                              });
                            }),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Expanded(
                        child: Row(
                          children: [
                            _buildNumberButton('.', () {
                              setState(() {
                                if (!number.contains('.')) {
                                  number += ".";
                                }
                              });
                            }),
                            _buildNumberButton('0', () {
                              setState(() {
                                number += "0";
                              });
                            }),
                            _buildNumberButton('<<', () {
                              setState(() {
                                if (number.isNotEmpty) {
                                  number = number.substring(
                                    0,
                                    number.length - 1,
                                  );
                                }
                              });
                            }),
                          ],
                        ),
                      ),
                      Spacer(flex: 2),
                    ],
                  ),
                ),

                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          try {
                            if (widget.financeModel == null) {
                              //add new finance model
                              BlocProvider.of<AddDataCubit>(context).addData(
                                FinanceModel(
                                  details: detailsController.text,
                                  financeValue: widget.isMinus
                                      ? double.parse(number) * -1
                                      : double.parse(number),
                                  dateTime: DateTime.now(),
                                ),
                              );
                              BlocProvider.of<FetchDataCubit>(
                                context,
                              ).fetchData();

                              Navigator.pop(context);
                            } else {
                              // Update existing finance model
                              widget.financeModel!.details =
                                  detailsController.text;
                              widget.financeModel!.financeValue = widget.isMinus
                                  ? double.parse(number) * -1
                                  : double.parse(number);
                              widget.financeModel!.dateTime = DateTime.now();
                              widget.financeModel!.save();

                              BlocProvider.of<FetchDataCubit>(
                                context,
                              ).fetchData();

                              Navigator.pop(context);
                            }
                          } on Exception catch (e) {
                            // TODO: Show error message
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: primaryBlueColor,
                          backgroundColor: secondryBlueColor,
                          padding: EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 4,
                        ),
                        child: Text(
                          widget.financeModel == null ? 'ADD' : 'UPDATE',

                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: blackcColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<FetchDataCubit>(context).fetchData();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: secondryRedColor,
                          padding: EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 4,
                        ),
                        child: Text(
                          'CANCEL',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: blackcColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNumberButton(String numberText, VoidCallback onTap) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: blackcColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                numberText,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: whiteColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
