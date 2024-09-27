import 'package:expense_app/ui_pages/add_exp_page.dart';
import 'package:expense_app/ui_pages/bottom_nav_page_provider.dart';
import 'package:expense_app/ui_pages/home_page.dart';
import 'package:expense_app/ui_pages/statistic_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return BottomNavPageState();
  }
}

class BottomNavPageState extends State<StatefulWidget>{
  List<Widget> navTo=[
    HomePage(),
    StatiSticPage(),
    AddExpPage(),
    Center(child: Text("Notification")),
    Center(child: Text("Reward")),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navTo[context.watch<BottomNavPageProvider>().getBottomPageIndex()],
      bottomNavigationBar:BottomNavigationBar(items:[
        BottomNavigationBarItem(icon: Icon(Icons.home_filled ),label: " "),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded),label: " "),
        BottomNavigationBarItem(icon: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.pinkAccent,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Icon(Icons.add,color: Colors.white,),
        ),label: " "),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_outlined),label: " "),
        BottomNavigationBarItem(icon: Icon(Icons.grid_goldenratio),label: " "),

      ],
        iconSize: 30,
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: context.watch<BottomNavPageProvider>().getBottomPageIndex(),
        onTap: (value){
        print(value);
          context.read<BottomNavPageProvider>().updateBottomNavPage(value);
        },
      ) ,
    );
  }

}