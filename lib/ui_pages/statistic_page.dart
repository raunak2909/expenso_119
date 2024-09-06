import 'package:expense_app/utils/app_styling.dart';
import 'package:flutter/material.dart';

class StatiSticPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor(),
      appBar: AppBar(
        backgroundColor: backColor(),
        title: Text("Statistic"),
        actions: [
          DropdownMenu(dropdownMenuEntries: [
            DropdownMenuEntry(value: 1, label: "Jan"),
            DropdownMenuEntry(value: 1, label: "Feb"),
            DropdownMenuEntry(value: 1, label: "Mar"),
            DropdownMenuEntry(value: 1, label: "Apr"),
          ],
          hintText: "months",
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              SizedBox(height: 10,),
              ///Total expense Details per Months..
              Container(
                width:double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: posterColor(),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    ///Total expense per Months..
                    Positioned(
                      top:20,
                      left: 20,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Total expense",style: myFonts18(myColor: Colors.white),),
                          Text("\$3,734",style: TextStyle(fontSize: 25,color: Colors.white),),
                        ],
                      ),
                    ),
                    ///Progressbar..
                    Positioned(
                      bottom: 10,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        width: 350,
                        height: 10,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                          borderRadius: BorderRadius.circular(20)
                        ),
                      ),
                    ),
                    ///Setting..
                    Positioned(
                      right: 15,
                      top: 12,
                      child: CircleAvatar(
                          maxRadius: 15,
                          child: Text("...")),
                    )

                  ],
                ),
              ),
              SizedBox(height: 15,),
              ///Expense Title Text and  Week DropdownMenu ..
              Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Expense Breakdown",style: myFonts18(myFontWeight: FontWeight.w600),),
                      SizedBox(height: 5,),
                      Text("Limit \$900 / week",style: myFonts11(myColor: Colors.grey,myFontWeight: FontWeight.w800),)
                    ],
                  ),
                  DropdownMenu(
                      hintText: "Week",
                      dropdownMenuEntries: [
                    DropdownMenuEntry(value: 1, label: "Mon"),
                    DropdownMenuEntry(value: 1, label: "Mon"),
                    DropdownMenuEntry(value: 1, label: "Mon"),
                    DropdownMenuEntry(value: 1, label: "Mon"),
                  ]

                  ),

                ],

              ),
              ),
              SizedBox(height: 10,),
              ///Bar Chart...
              Container(
                width: double.infinity,
                height: 250,
                color: Colors.pink,
              ),
              SizedBox(height: 15,),
              ///Spending Title Text..
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Spending Details",style: myFonts18(myFontWeight: FontWeight.w600),),
                        SizedBox(height: 5,),
                        Text("Your expenses are divided into 6 categories",style: myFonts11(myColor: Colors.grey,myFontWeight: FontWeight.w600),)
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(height: 10,),
              ///Progressbar..
              Container(
                width: double.infinity,
                height: 15,
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
              SizedBox(height: 10,),
              ///GridView...
              SizedBox(
                height: 300,
                child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 7/3.5,crossAxisSpacing: 15,mainAxisSpacing: 12),
                    itemBuilder: (_,index){
                    return Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey)
                        ),
                        child: ListTile(
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.indigo.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Icon(Icons.shopping_cart_outlined,color: Colors.indigo,),

                          ),
                          title: Text("Shop",style: myFonts18(),),
                          subtitle: Text("\$1,1990",style: myFonts16(myColor: pinkColor(),myFontWeight: FontWeight.w600),),

                        ),
                      ),
                    );
                    }, itemCount: 4,),
              )
            ],
          ),
        ),
      ),

    );
  }

}