import 'package:finance_app/colors/colors.dart';
import 'package:finance_app/cubit/fetch_cubit/fetch_data_cubit.dart';
import 'package:finance_app/models/finance_model.dart';
import 'package:finance_app/pages/add.dart';
import 'package:finance_app/pages/see_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<FetchDataCubit>(context).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome Ahmed"),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_5_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<FetchDataCubit, FetchDataState>(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.all(16),
          child: state is FetchDataLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    SizedBox(
                      height: 150,

                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,

                            child: Container(
                              decoration: BoxDecoration(
                                color: blackcColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "My Balance",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      '452',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: secondrypurbleColor,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),
                    SizedBox(
                      height: 150,

                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                color: blackcColor,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "My Balance",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      '452',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: secondryRedColor,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),

                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AddPage(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              height: 50,
                              decoration: BoxDecoration(
                                color: secondryGreenColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.add),
                                  SizedBox(width: 8),
                                  Text(
                                    'Plus',
                                    style: TextStyle(
                                      color: blackcColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddPage(isMinus: true),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              height: 50,
                              decoration: BoxDecoration(
                                color: secondryRedColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.remove),
                                  SizedBox(width: 8),
                                  Text(
                                    'Minus',
                                    style: TextStyle(
                                      color: blackcColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Activity',
                          style: TextStyle(
                            color: blackcColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SeeAll(),
                              ),
                            );
                          },
                          child: Text(
                            'See All',
                            style: TextStyle(
                              color: blackcColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        itemCount: BlocProvider.of<FetchDataCubit>(
                          context,
                        ).financeDataList.length,
                        itemBuilder: (context, index) {
                          List<FinanceModel> mylist =
                              BlocProvider.of<FetchDataCubit>(
                                context,
                              ).financeDataList.reversed.toList();

                          return ListTileOfElement(financeModel: mylist[index]);
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class ListTileOfElement extends StatelessWidget {
  FinanceModel financeModel;
  ListTileOfElement({super.key, required this.financeModel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: secondryBlueColor),
      title: Text(
        financeModel.details,
        style: TextStyle(
          color: blackcColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        DateFormat.MMMMEEEEd().format(financeModel.dateTime),

        style: TextStyle(color: blackcColor, fontSize: 14),
      ),
      trailing: Text(
        financeModel.financeValue > 0
            ? "\$ +${financeModel.financeValue.toString()}"
            : "\$ ${financeModel.financeValue.toString()}",
        style: TextStyle(color: blackcColor, fontSize: 14),
      ),
    );
  }
}
