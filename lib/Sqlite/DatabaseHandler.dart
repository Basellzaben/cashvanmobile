import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../Models/CustomersModel.dart';
import '../Models/ManLogTransModel.dart';
import '../Models/UsersModel.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(join(path, 'GalaxyCashVanDataBase.db'), version: 10,
        onCreate: (database, version) async {
      //companyinfo
      await database.execute(
        "CREATE TABLE CompanyInfo(id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "Address TEXT,"
        "CID INTEGER,"
        "CName TEXT,"
        "SuperVisor TEXT,"
        "TaxNo1 TEXT,"
        "TaxNo2 TEXT,"
        "AllowDay INTEGER,"
        "Lat TEXT,"
        "Long TEXT,"
        "StartDate TEXT,"
        "CMobile TEXT)",
      );

      //Representatives -- users
      await database.execute('''
            CREATE TABLE Representatives(
            Id INTEGER PRIMARY KEY,
            ArabicName TEXT NOT NULL,
            EnglishName TEXT NOT NULL,
            ManType INTEGER,
            ManSupervisor INTEGER,
            AlternativeMan INTEGER,
            BranchNo INTEGER,
            ManStatus INTEGER,
            Email TEXT,
            MobileNo TEXT,
            LoginName TEXT,
            BasicSalary REAL,
            CarId INTEGER,
            Password TEXT,
    CashComm NUMERIC(16, 6),
    CreditComm NUMERIC(16, 6),
    quta NUMERIC(16, 3),
    sales2 NUMERIC(16, 3),
    state INTEGER,
    year INTEGER,
    country INTEGER,
    city INTEGER,
    Area TEXT,
    Type INTEGER,
    Note TEXT,
    dis NUMERIC(18, 5),
    StoreNo INTEGER,
    MobileNo2 TEXT,
    ManImage BLOB,
    ImagePath TEXT,
    MaxDiscount NUMERIC(18, 0),
    MaxBouns NUMERIC(18, 0),
    FullName TEXT,
    ManMaterial NUMERIC(18, 0),
    ManRegion NUMERIC(18, 0),
    OpiningBalanceVacation NUMERIC(18, 0),
    BalanceVacation NUMERIC(18, 0),
    EquationId INTEGER,
    SubAgent NUMERIC(16, 3),
    CustomerName TEXT,
    Items TEXT,
    SalesAccNo NUMERIC(18, 0),
    ReceiptVType INTEGER,
    SalesVType INTEGER,
    RetSalesVType INTEGER,
    CashAccNo NUMERIC(18, 0),
    VType NUMERIC(18, 0),
    Supervisor INTEGER,
    AllowLoginOutside INTEGER,
    RangeLogin INTEGER,
    Acc_Num NUMERIC(18, 0)
    )''');

//branches -- customers
      await database.execute('''
    CREATE TABLE IF NOT EXISTS branches (
      Id INTEGER PRIMARY KEY,
    CustomerId INTEGER,
    BranchName TEXT,
    BranchTel TEXT,
    BranchRepNo INTEGER,
    LocX REAL,
    LocY REAL,
    Sat INTEGER,
    Sun INTEGER,
    Mon INTEGER,
    Tues INTEGER,
    Wens INTEGER,
    Thurs INTEGER,
    Frid INTEGER,
    EveryWeek INTEGER,
    VisitWeek INTEGER,
    Acc TEXT,
    CatNo INTEGER,
    Pay_How TEXT,
    Discount_Percent REAL,
    Allow_Period INTEGER,
    TaxSts TEXT,
    PAYTYPE TEXT,
    ACC_CHECK INTEGER,
    PAMENT_PERIOD_NO INTEGER,
    ExpirePeriod INTEGER,
    ID_facility INTEGER,
    AllowInviceWithFlag INTEGER,
    CloseVisitWithoutimg INTEGER
)
    ''');

      await database.execute('''
           CREATE TABLE ManLogTrans (
              ID INTEGER ,
              ManNo INTEGER,
              CustNo INTEGER,
              ScreenCode INTEGER,
              ActionNo INTEGER,
              TransNo TEXT,
              Trans_Date DATETIME,
              TabletId TEXT,
              BattryCharge TEXT,
              Notes TEXT,
                posted INTEGER
          )''');

          await database.execute('''
      CREATE TABLE ManVisits (
        ID INTEGER PRIMARY KEY,
        CusNo INTEGER,
        DayNum INTEGER,
        Start_Time TEXT,
        End_Time TEXT,
        ManNo INTEGER,
        Tr_Data TEXT,
        no INTEGER,
        OrderNo INTEGER,
        Note TEXT,
        X_Lat REAL,
        Y_Long REAL,
        Loct TEXT,
        IsException INTEGER,
        COMPUTERNAME TEXT,
        orderinvisit INTEGER,
        Duration INTEGER,
        posted INTEGER
      )
    ''');


    });
  }

  Future<int> getMaxIdFromTable(String tableName) async {
    final Database database = await initializeDB();
    final List<Map<String, dynamic>> result = await database.rawQuery(
      'SELECT MAX(ID) as max_id FROM $tableName',
    );

    if (result.isNotEmpty) {
      int? maxId = result[0]['max_id'] + 1;
      print("MAXID : "+maxId.toString());
      return maxId ?? 0; // Return 0 if maxId is null

    } else {
      print("MAXID : return 9");

      return 0; // Return 0 if there are no records in the table
    }
  }

  Future<void> addManLogTrans(List<ManLogTransModel> Manlogtrans) async {
    Dropbranches();
    final Database database = await initializeDB();
    for (int i = 0; i < Manlogtrans.length; i++) {
      var res = await database.insert('ManLogTrans', Manlogtrans[i].toMap());
      print("Result " + i.toString() + " :" + res.toString());
    }
  }

  Future<List<ManLogTransModel>> retrieveManLogTrans() async {
    final Database database = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await database.rawQuery('select * from  ManLogTrans');
    return queryResult.map((e) => ManLogTransModel.fromMap(e)).toList();
  }

  initDatabase() async {
    await initializeDB();
  }

  Future<void> addRepresentative(List<UsersModel> representative) async {
    DropRepresentatives();
    final Database database = await initializeDB();
    for (int i = 0; i < representative.length; i++) {
      var res =
          await database.insert('Representatives', representative[i].toMap());
      print("Result " + i.toString() + " :" + res.toString());
    }
  }

  Future<void> updateRepresentative(UsersModel representative) async {
    final Database database = await initializeDB();
    await database.update(
      'Representatives',
      representative.toMap(),
      where: 'Id = ?',
      whereArgs: [representative.id],
    );
  }

  Future<void> deleteRepresentative(int id) async {
    final Database database = await initializeDB();
    await database.delete(
      'Representatives',
      where: 'Id = ?',
      whereArgs: [id],
    );
  }

  Future<List<UsersModel>> retrieveRepresentative() async {
    final Database database = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await database.rawQuery('select * from  Representatives');

    return queryResult.map((e) => UsersModel.fromMap(e)).toList();
  }

  Future<void> addbranches(List<CustomersModel> branches) async {
    Dropbranches();
    final Database database = await initializeDB();
    for (int i = 0; i < branches.length; i++) {
      var res = await database.insert('branches', branches[i].toMap());
      print("Result " + i.toString() + " :" + res.toString());
    }
  }

  Future<List<CustomersModel>> retrievebranches() async {
    final Database database = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await database.rawQuery('select * from  branches');

    print(queryResult
            .map((e) => CustomersModel.fromMap(e))
            .toList()
            .first
            .branchName
            .toString() +
        "BBHBDNB");

    return queryResult.map((e) => CustomersModel.fromMap(e)).toList();
  }

  Future<void> Dropbranches() async {
    final Database db = await initializeDB();
    db.delete('branches');
  }

  Future<void> DropRepresentatives() async {
    final Database db = await initializeDB();
    db.delete('Representatives');
  }
}
