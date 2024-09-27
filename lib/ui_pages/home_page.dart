import 'dart:math';

import 'package:expense_app/ui_pages/bloc/expense_bloc.dart';
import 'package:expense_app/utils/app_const_data.dart';
import 'package:expense_app/utils/app_styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../data/models/cat_model.dart';
import '../data/models/expense_model.dart';
import '../data/models/filtered_expense_model.dart';


class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<StatefulWidget> {
  List<FilteredExpenseModel> allData = [];
  bool isDark = false;

  @override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(GetInitialExpenseEvent());
  }

  @override
  Widget build(BuildContext context) {

    isDark = Theme.of(context).brightness==Brightness.dark;

    return Scaffold(
      backgroundColor:  isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        title: Text("App Name"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                size: 30,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: MediaQuery.of(context).orientation==Orientation.landscape ? Row(
          children: [
            ///Profile Details and Select Months..
            Expanded(child: userInfoUI()),
            SizedBox(
              width: 13,
            ),
            Expanded(child: expenseDataUI()),
          ],
        ) : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ///Profile Details and Select Months..
            userInfoUI(),
            Expanded(child: expenseDataUI()),

          ],
        ),
      ),
    );
  }
  
  Widget userInfoUI(){
    return  Container(
      width: double.infinity,
      // color: Colors.pinkAccent,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              ///User Images..
              CircleAvatar(
                maxRadius: 27,
                backgroundImage: AssetImage("assets/images/p7.jpeg"),
                backgroundColor: Colors.cyan,
              ),

              ///User name day status is like morning afternon evening..
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  // color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Morning",
                        style: myFonts11(
                            myColor: Colors.grey,
                            myFontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Saurav Kumar",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color:  isDark ? Colors.white : Colors.black),
                      ),

                    ],
                  ),
                ),
              ),

              ///Month Dropdown menu...
              DropdownMenu(
                dropdownMenuEntries: [
                  DropdownMenuEntry(value: 1, label: "Jan"),
                  DropdownMenuEntry(value: 1, label: "Feb"),
                  DropdownMenuEntry(value: 1, label: "Mar"),
                  DropdownMenuEntry(value: 1, label: "Apr"),
                ],
                hintText: "Month",
              )
            ],
          ),
          SizedBox(
            height: 13,
          ),
          Container(
            width: double.infinity,
            height: 190,
            decoration: BoxDecoration(
              color: posterColor(),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 35,
                  child: Container(
                    width: 200,
                    // height: 110,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Expenses total",
                          style: myFonts18(myColor: Colors.white),
                        ),

                        ///Expenses total Amount..
                        Text(
                            "\$${AppConstData.balance}",
                            style: Theme.of(context).textTheme.displayLarge!.copyWith(color: Colors.white)
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: 30,
                    right: -60,
                    child: SizedBox(
                        height: 150,
                        child: Image.asset(
                          'assets/images/poster.png',
                          fit: BoxFit.cover,
                        ))),
              ],
            ),
          ),
          SizedBox(
            height: 13,
          ),
        ],
      ),
    );
  }
  
  Widget expenseDataUI(){
    return BlocBuilder<ExpenseBloc, ExpenseState>(builder: (_, state) {
      if (state is ExpenseLoadingState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    
      if (state is ExpenseErrorState) {
        return Center(
          child: Text(state.errorMsg),
        );
      }
    
      if (state is ExpenseLoadedState) {
        allData = filterExpense(state.mExp);
        if(state.mExp.isNotEmpty){
          filterExpenseCatWise(state.mExp);
          AppConstData.balance = state.mExp.last.bal;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Poster(Card)..

    
              ///Expense List...
              Text(
                "Expense List",
                style: myFonts18(myFontWeight: FontWeight.w800, myColor: isDark ? Colors.white : Colors.black),
              ),
              SizedBox(
                height: 13,
              ),
              Expanded(
                // color: Colors.deepPurple,
                child: ListView.builder(
                  itemBuilder: (_, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    // color: Colors.grey,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Colors.grey)
                    ),
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
    
                            ///Day and Total Expense...
                            Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Text("${allData[index].title}",
                                  style: myFonts16(
                                      myFontWeight: FontWeight.w600, myColor: isDark ? Colors.white : Colors.black),),
                                Text("\$${allData[index].totalAmt}",
                                  style: myFonts16(
                                      myFontWeight: FontWeight.w600, myColor: isDark ? Colors.white : Colors.black),),
                              ],
                            ),
                            Divider(
                              height: 30,
                              thickness: 1,
                            ),
    
                            ///Your Expenses List and Amounts..
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (_, childIndex) {
                                var filteredList = AppConstData.mCat.where(
                                        (element) => element.catId ==
                                        allData[index].allExp[childIndex].cat_id)
                                    .toList();
    
                                return ListTile(
                                  leading: Container(
                                    width: 50,
                                    height: 50,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.primaries[Random().nextInt(Colors.primaries.length-1)]
                                            .withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(
                                            10)
                                    ),
                                    child: Image.asset(filteredList[0].catImgPath,),
                                  ),
                                  title: Text(
                                    "${allData[index].allExp[childIndex]
                                        .title}", style: myFonts16(
                                      myFontWeight: FontWeight.w500, myColor: isDark ? Colors.white : Colors.black),),
                                  subtitle: Text(
                                      allData[index].allExp[childIndex]
                                          .desc),
                                  trailing: Text(
                                      "\$${allData[index].allExp[childIndex]
                                          .amt}", style: myFonts16(
                                    myColor: allData[index].allExp[childIndex].type=="Debit" ? pinkColor() : Colors.green,
                                    myFontWeight: FontWeight.w700,)),
                                );
                              },
                              itemCount: allData[index].allExp.length,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }, itemCount: allData.length,),
              ),
            ],
          );
        } else {
          return Center(
            child: Text('No Expense yet!!'),
          );
        }
      }
      return Container();
    });
  }

  static List<FilteredExpenseModel> filterExpense(List<ExpenseModel> mExpenses) {
    List<FilteredExpenseModel> allData = [];

    ///unique Dates
    List<String> uniqueDates = [];
    DateFormat mFormat = DateFormat.yMMMd();

    for (ExpenseModel eachExp in mExpenses) {
      var eachDate = mFormat.format(
          DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.created_at)));

      if (!uniqueDates.contains(eachDate)) {
        uniqueDates.add(eachDate);
      }
    }
    print(uniqueDates);

    for (String eachDate in uniqueDates) {
      num amt = 0.0;
      List<ExpenseModel> eachDateExpense = [];

      for (ExpenseModel eachExp in mExpenses) {
        var dateFromExp = mFormat.format(
            DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.created_at)));
        if (eachDate == dateFromExp) {
          eachDateExpense.add(eachExp);
          if (eachExp.type == "Debit") {
            amt -= eachExp.amt;
          } else {
            amt += eachExp.amt;
          }
        }
      }

      allData.add(FilteredExpenseModel(
          title: eachDate, totalAmt: amt, allExp: eachDateExpense));
    }

    print(allData.length);
    return allData;
  }
  void filterExpenseCatWise(List<ExpenseModel> mExpenses){

    allData.clear();
    var uniqueCat = AppConstData.mCat;

    for(CatModel eachCat in uniqueCat){
      num eachCatBal = 0.0;
      List<ExpenseModel> eachCatExp = [];

      for(ExpenseModel eachExp in mExpenses){

        if(eachExp.cat_id==eachCat.catId){
          eachCatExp.add(eachExp);

          if(eachExp.type=="Debit"){
            eachCatBal -= eachExp.amt;
          } else {
            eachCatBal += eachExp.amt;
          }
        }

      }

      if(eachCatExp.isNotEmpty){
        allData.add(FilteredExpenseModel(title: eachCat.catName, totalAmt: eachCatBal, allExp: eachCatExp));
      }

    }

  }
}
