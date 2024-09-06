class AppConstData{

 static Set<String> months={
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  };

  List<Map<String,dynamic>> expenseData =[
    {
      'day':'Tuesday,14',
      'shopingList':{
        "myshoping":{
          'cate':'Shop',
          'shop':'-90',
          'subtitle':'buy new clothes',

        },
        "myE-items":{
          'cate':'Electronics',
          'shop':'-1290',
          'subtitle':'buy new iphone16',
        }
      },
      'total':'-1380'
    },
    {
      'day':'Monday,13',
      'shopingList':{
        "mytrns":{
          'cate':'Transportation',
          'shop':'-90',
          'subtitle':'train ticket',

        },
        "myfood":{
          'cate':'Eat Food',
          'shop':'-150',
          'subtitle':'Eat Food',
        }
      },
      'total':'-240'
    }
  ];
}