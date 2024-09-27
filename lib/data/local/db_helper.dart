import 'package:expense_app/data/models/expense_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static DBHelper getInstance() => DBHelper._();

  static final String TABLE_USER_NAME = "user";
  static final String COLUMN_USER_ID = "user_id"; //pk -> fk
  static final String COLUMN_USER_NAME = "user_name";
  static final String COLUMN_USER_EMAIL = "user_email";
  static final String COLUMN_USER_MOBNO = "user_mob_no";
  static final String COLUMN_USER_GENDER = "user_gender";
  static final String COLUMN_USER_PASS = "user_pass";

  static final String TABLE_EXPENSE_NAME = "expense";
  static final String COLUMN_EXPENSE_ID = "e_id";
  static final String COLUMN_EXPENSE_TITLE = "e_title";
  static final String COLUMN_EXPENSE_DESC = "e_desc";
  static final String COLUMN_EXPENSE_AMT = "e_amt";
  static final String COLUMN_EXPENSE_BAL = "e_bal";
  static final String COLUMN_EXPENSE_TYPE = "e_type";
  static final String COLUMN_EXPENSE_CAT_ID = "e_cat_id";
  static final String COLUMN_EXPENSE_CREATED_AT = "e_created_at";

  Database? mDB;

  Future<Database> getDB() async {
    mDB ??= await createDB();
    return mDB!;
  }

  Future<Database> createDB() async {
    var appDir = await getApplicationDocumentsDirectory();
    var dbPath = join(appDir.path, "expenso.db");

    return await openDatabase(dbPath, onCreate: (db, version) {
      /// create all the tables here

      db.execute(
          "create table $TABLE_USER_NAME ( $COLUMN_USER_ID integer primary key autoincrement, $COLUMN_USER_NAME text, $COLUMN_USER_EMAIL text, $COLUMN_USER_MOBNO text, $COLUMN_USER_GENDER text, $COLUMN_USER_PASS text)");
      db.execute(
          "create table $TABLE_EXPENSE_NAME ( $COLUMN_EXPENSE_ID integer primary key autoincrement, $COLUMN_USER_ID integer, $COLUMN_EXPENSE_TITLE text, $COLUMN_EXPENSE_DESC text, $COLUMN_EXPENSE_TYPE text, $COLUMN_EXPENSE_AMT real, $COLUMN_EXPENSE_BAL real, $COLUMN_EXPENSE_CAT_ID integer, $COLUMN_EXPENSE_CREATED_AT text)");
    }, version: 1);
  }

  ///queries
  /// 1 email already exit
  /// 2 create user
  /// 3 authenticate user

  /// 6 updateExpense
  /// 7 deleteExpense

  /// 4 fetchAllExpenses
  Future<List<ExpenseModel>> getAllExpenses() async {
    var db = await getDB();

    /// get uid from shared pref
    var prefs = await SharedPreferences.getInstance();
    var uid = prefs.getInt("UID");
    uid = 0;

    var data = await db.query(TABLE_EXPENSE_NAME,
        where: "$COLUMN_USER_ID = ?", whereArgs: ['$uid']);

    List<ExpenseModel> allExp = [];

    for(Map<String, dynamic> eachData in data){
      allExp.add(ExpenseModel.fromMap(eachData));
    }

    return allExp;

  }

  /// 5 addExpense
  Future<bool> addExpense(ExpenseModel newExpense) async{
    var db = await getDB();
    /// get uid from sharedPref
    int uid = 0;
    newExpense.uid = uid;

    var rowsEffected = await db.insert(TABLE_EXPENSE_NAME, newExpense.toMap());
    return rowsEffected>0;
  }


}
