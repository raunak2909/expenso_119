import 'package:expense_app/data/models/expense_model.dart';
import 'package:expense_app/ui_pages/bloc/expense_bloc.dart';
import 'package:expense_app/ui_pages/bottom_nav_page_provider.dart';
import 'package:expense_app/ui_pages/theme_provider.dart';
import 'package:expense_app/utils/app_const_data.dart';
import 'package:expense_app/utils/decoration_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddExpPage extends StatefulWidget {
  @override
  State<AddExpPage> createState() => _AddExpPageState();
}

class _AddExpPageState extends State<AddExpPage> {
  var titleController = TextEditingController();

  var descController = TextEditingController();

  var amtController = TextEditingController();

  int selectedIndex = -1;

  List<String> mTypes = ['Debit', 'Credit', 'Loan', 'Lend', 'Borrow'];
  String selectedType = 'Debit';
  DateTime? selectedDate;
  DateFormat mFormat = DateFormat.yMMMd();
  num bal = 0;
  bool isDark = false;

  @override
  Widget build(BuildContext context) {

    isDark = Theme.of(context).brightness==Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
        actions: [
          Switch.adaptive(value: context.watch<ThemeProvider>().getThemeValue(), onChanged: (value){
            context.read<ThemeProvider>().changeThemeValue(value);
          }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
              decoration: DecorationUtils.textFieldDecor(
                borderColor: isDark ? Colors.white : Colors.black,
                hintText: "Enter your Title here..",
                title: 'Title',
              ),
            ),
            DecorationUtils.mSpacer(),
            TextField(
              controller: descController,
              decoration: DecorationUtils.textFieldDecor(
                  borderColor: isDark ? Colors.white : Colors.black,
                  hintText: "Enter your Desc here..", title: 'Desc'),
            ),
            DecorationUtils.mSpacer(),
            TextField(
              controller: amtController,
              decoration: DecorationUtils.textFieldDecor(
                  borderColor: isDark ? Colors.white : Colors.black,
                  hintText: "Enter your Amount(in Rupees) here..",
                  title: 'Amount'),
            ),
            DecorationUtils.mSpacer(),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 1, color: isDark ? Colors.white : Colors.black,),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11)),
                    minimumSize: Size(double.infinity, 60),
                    maximumSize: Size(double.infinity, 60)),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return Container(
                          child: GridView.builder(
                              itemCount: AppConstData.mCat.length,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4),
                              itemBuilder: (_, index) {
                                return InkWell(
                                  onTap: () {
                                    selectedIndex = index;
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          AppConstData.mCat[index].catImgPath,
                                          width: 50,
                                          height: 50,
                                        ),
                                        Text(AppConstData.mCat[index].catName)
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        );
                      });
                },
                child: selectedIndex >= 0
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppConstData.mCat[selectedIndex].catImgPath,
                      width: 30,
                      height: 30,
                    ),
                    Text(" - ${AppConstData.mCat[selectedIndex].catName}")
                  ],
                )
                    : Text('Choose a Category'),
              ),
            ),
            DecorationUtils.mSpacer(),
            DropdownMenu(
                inputDecorationTheme: InputDecorationTheme(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: isDark ? Colors.white : Colors.black,
                      ),
                        borderRadius: BorderRadius.circular(11)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(11)
                    )
                ),
                initialSelection: selectedType,
                label: Text('Expense Type'),
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 32,
                dropdownMenuEntries: mTypes
                    .map((e) => DropdownMenuEntry(value: e, label: e))
                    .toList(),
                onSelected: (value) {
                  selectedType = value!;
                }),

            /* StatefulBuilder(builder: (_, ss) {
              return DropdownButton(
                  value: selectedType,
                  items: mTypes
                      .map((eachType) => DropdownMenuItem(
                          value: eachType, child: Text(eachType)))
                      .toList(),
                  onChanged: (value) {
                    selectedType = value!;
                    ss(() {});
                  });
            })*/
            DecorationUtils.mSpacer(),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 1, color: isDark ? Colors.white : Colors.black),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11)),
                    minimumSize: Size(double.infinity, 60),
                    maximumSize: Size(double.infinity, 60)),
                onPressed: () async {
                  selectedDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime(DateTime
                          .now()
                          .year - 2, DateTime
                          .now()
                          .month, DateTime
                          .now()
                          .day),
                      lastDate: DateTime.now());
                  setState(() {

                  });
                },
                child: Text(mFormat.format(selectedDate ?? DateTime.now())),
              ),
            ),
            DecorationUtils.mSpacer(),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      side: BorderSide(width: 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11)),
                      minimumSize: Size(double.infinity, 60),
                      maximumSize: Size(double.infinity, 60)
                  ),
                  onPressed: () async {


                    if(titleController.text.isNotEmpty && descController.text.isNotEmpty && amtController.text.isNotEmpty && selectedIndex!=-1){

                      bal = AppConstData.balance;

                      if(selectedType=="Debit"){
                        bal -= double.parse(amtController.text);
                      } else {
                        bal += double.parse(amtController.text);
                      }
                      print(bal);

                      context.read<ExpenseBloc>().add(
                          AddExpenseEvent(newExpense: ExpenseModel(
                              cat_id: AppConstData.mCat[selectedIndex].catId,
                              title: titleController.text,
                              desc: descController.text,
                              type: selectedType,
                              amt: double.parse(amtController.text),
                              bal: bal,
                              created_at: (selectedDate ?? DateTime.now()).millisecondsSinceEpoch.toString())));
                      context.read<BottomNavPageProvider>().updateBottomNavPage(0);
                    }
                  },
                  child: Text("Add Expense"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
