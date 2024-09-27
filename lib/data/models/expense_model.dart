import 'package:expense_app/data/local/db_helper.dart';

class ExpenseModel {
  int? eid;
  int? uid;
  int cat_id;
  String title;
  String desc;
  String type;
  num amt;
  num bal;
  String created_at;

  ExpenseModel({this.eid,
    this.uid,
    required this.cat_id,
    required this.title,
    required this.desc,
    required this.type,
    required this.amt,
    required this.bal,
    required this.created_at});

  ///fromMap
  factory ExpenseModel.fromMap(Map<String, dynamic> map) =>
      ExpenseModel(
        eid: map[DBHelper.COLUMN_EXPENSE_ID],
          uid: map[DBHelper.COLUMN_USER_ID],
          cat_id: map[DBHelper.COLUMN_EXPENSE_CAT_ID],
          title: map[DBHelper.COLUMN_EXPENSE_TITLE],
          desc: map[DBHelper.COLUMN_EXPENSE_DESC],
          type: map[DBHelper.COLUMN_EXPENSE_TYPE],
          amt: map[DBHelper.COLUMN_EXPENSE_AMT],
          bal: map[DBHelper.COLUMN_EXPENSE_BAL],
          created_at: map[DBHelper.COLUMN_EXPENSE_CREATED_AT]);

  /// toMap
  Map<String, dynamic> toMap() => {
    DBHelper.COLUMN_USER_ID : uid,
    DBHelper.COLUMN_EXPENSE_CAT_ID : cat_id,
    DBHelper.COLUMN_EXPENSE_TITLE : title,
    DBHelper.COLUMN_EXPENSE_DESC : desc,
    DBHelper.COLUMN_EXPENSE_AMT : amt,
    DBHelper.COLUMN_EXPENSE_BAL : bal,
    DBHelper.COLUMN_EXPENSE_TYPE : type,
    DBHelper.COLUMN_EXPENSE_CREATED_AT : created_at,
  };



}
