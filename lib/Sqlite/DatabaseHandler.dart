import 'dart:convert';

import 'package:cashvanmobile/Models/ItemModel.dart';
import 'package:cashvanmobile/Models/ItemsCategModel.dart';
import 'package:cashvanmobile/Models/UnitItemModel.dart';
import 'package:cashvanmobile/Models/UnitesModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../Models/CustomersModel.dart';
import '../Models/ManLogTransModel.dart';
import '../Models/ManVisitsModel.dart';
import '../Models/PriceModel.dart';
import '../Models/SalesInvoiceDModel.dart';
import '../Models/SalesInvoiceHModel.dart';
import '../Models/UsersModel.dart';
import '../Providers/LoginProvider.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(join(path, 'GalaxyCashVanDataBase.db'), version: 12,
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
    customerid TEXT ,
    branchname TEXT,
    branchtel TEXT,
    branchrepno TEXT,
    locx TEXT,
    locy TEXT,
    sat TEXT,
    sun TEXT,
    mon TEXT,
    tues TEXT,
    wens TEXT,
    thurs TEXT,
    frid TEXT,
    everyweek TEXT,
    visitweek TEXT,
    acc TEXT,
    catno TEXT,
    pay_how TEXT,
    discount_percent TEXT,
    allow_period TEXT,
    taxsts TEXT,
    paytype TEXT,
    acc_check TEXT,
    pament_period_no TEXT,
    expireperiod TEXT,
    id_facility TEXT,
    allowinvicewithflag TEXT,
    closevisitwithoutimg TEXT
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
              Trans_Date TEXT,
              TabletId TEXT,
              BattryCharge TEXT,
              Notes TEXT,
                posted INTEGER
          )''');

      await database.execute('''
      CREATE TABLE ManVisits (
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        CusNo INTEGER,
        CusName TEXT,
        DayNum INTEGER,
        Start_Time TEXT,
        End_Time TEXT,
        ManNo INTEGER,
        Tr_Data TEXT,
        no INTEGER,
        OrderNo INTEGER,
        Note TEXT,
        X_Lat TEXT,
        Y_Long TEXT,
        Loct TEXT,
        IsException INTEGER,
        COMPUTERNAME TEXT,
        orderinvisit INTEGER,
        Duration INTEGER,
        posted INTEGER
      )
    ''');



          await database.execute('''
      CREATE TABLE invf (
        Item_No TEXT PRIMARY KEY,
        Item_Name TEXT,
        Ename TEXT,
        Unit TEXT,
        Price REAL,
        OL REAL,
        OQ1 REAL,
        Type_No TEXT,
        Pack INTEGER,
        QOH REAL,
        OQ2 REAL,
        Place TEXT,
        Wcost REAL,
        Ecost REAL,
        Hcost REAL,
        Lcost REAL,
        dno TEXT,
        enqty REAL,
        inqty REAL,
        resqty REAL,
        offerqty REAL,
        Country TEXT,
        Original INTEGER,
        tax REAL,
        UnitIn INTEGER,
        UnitOut INTEGER,
        Convert INTEGER,
        barcode TEXT,
        TaxCheck INTEGER,
        Expired INTEGER,
        AllowExp INTEGER,
        Packitem TEXT,
        P_local TEXT,
        P_export TEXT,
        S_cash TEXT,
        S_debt TEXT,
        Flavor_No REAL,
        Composition REAL,
        Packing TEXT,
        Carton TEXT,
        Lable TEXT,
        Bottle TEXT,
        Shrink TEXT,
        Binding TEXT,
        Active REAL,
        NotActive REAL,
        density REAL,
        ORdQty REAL,
        ExpiryPeriod TEXT,
        ItemSpec TEXT,
        originno INTEGER,
        pack40 REAL,
        pack20 REAL,
        brandno INTEGER,
        PrPer REAL ,
        Type INTEGER,
        ITEM_DESC TEXT,
        TaxNo INTEGER,
        smallPrice REAL,
        accf_no INTEGER,
        Status INTEGER,
        FamilieNo INTEGER,
        accinvf INTEGER,
        storinvf INTEGER,
        ItemWeight REAL,
        IsActive INTEGER,
        QRCODE TEXT,
        UseSerial INTEGER,
        Unitsale INTEGER,
        Cus_Price INTEGER,
        IsServiceItem INTEGER,
        Is_Kit INTEGER,
        Item_Type INTEGER,
        Serial_no INTEGER,
        Shortcut_Name TEXT,
        CurrNo INTEGER,
        StartSerial TEXT
      )
    ''');


          await database.execute('''
           CREATE TABLE Items_Categ (
              ItemCode TEXT ,
              CategNo INTEGER,
              Price TEXT,
              MinPrice TEXT,
              dis TEXT,
              bounce TEXT,
              UnitNo TEXT
          )''');

          await database.execute(
            "CREATE TABLE Unites(id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "Unitno TEXT,"
                "UnitName TEXT,"
                "UnitEname TEXT)",
          );


          await database.execute(
            "CREATE TABLE UnitItem(id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "item_no TEXT,"
                "barcode TEXT,"
                "unitno TEXT,"
                "Operand TEXT,"
                "price TEXT,"
                "Max TEXT,"
                "Min TEXT)",
          );


          await database.execute(
            "CREATE TABLE SalesInvoiceD(id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "Bounce TEXT,"
                "Dis_Amt TEXT,"
                "Discount TEXT,"
                "ItemOrgPrice TEXT,"
                "Operand TEXT,"
                "ProID TEXT,"
                "Pro_amt TEXT,"
                "Pro_bounce TEXT,"
                "Pro_dis_Per TEXT,"
                "Unite TEXT,"
                "no TEXT ,"
                "price TEXT,"
                "pro_Total TEXT,"
                "qty TEXT,"
                "tax TEXT,"
                "tax_Amt TEXT,"
                "total TEXT,"
                "name TEXT,"
                "unitname TEXT,"
                "orderno TEXT)",
          );

          await database.execute(
              "CREATE TABLE SalesInvoiceH(id INTEGER PRIMARY KEY AUTOINCREMENT, "
                  "Cust_No TEXT,"
                  "Date TEXT,"
                  "UserID TEXT,"
                  "OrderNo TEXT UNIQUE not null,"
                  "hdr_dis_per TEXT,"
                  "hdr_dis_value TEXT,"
                  "Total TEXT,"
                  "Net_Total TEXT,"
                  "Tax_Total TEXT,"
                  "include_Tax TEXT,"
                  "inovice_type TEXT,"
                  "V_OrderNo TEXT,"
                  "posted TEXT )"

          );


        });
  }
  Future<List<SalesInvoiceHModel>> retrieveIDS() async {
    final Database database = await initializeDB();
    final List<Map<String, Object?>> queryResult =
    await database.rawQuery('select * from  SalesInvoiceH');
    return queryResult.map((e) => SalesInvoiceHModel.fromMap(e)).toList();
  }


  Future<void> addSalesInvoiceD(List<SalesInvoiceDModel> items) async {
    final Database database = await initializeDB();
    for (int i = 0; i < items.length; i++) {
      var res = await database.insert('SalesInvoiceD', items[i].toMap());
      print("Result " + i.toString() + " :" + res.toString());
    }
  }

  Future<void> addSalesInvoiceH(List<SalesInvoiceHModel> items) async {
    final Database database = await initializeDB();
    for (int i = 0; i < items.length; i++) {
      var res = await database.insert('SalesInvoiceH', items[i].toMap());
      print("Result " + i.toString() + " :" + res.toString());
    }
  }

  Future<int> getMaxInvoice(BuildContext context) async {
    int maxId=0;
    final Database database = await initializeDB();
    final List<Map<String, dynamic>> result = await database.rawQuery(
      'SELECT MAX(OrderNo) as max_id FROM SalesInvoiceH',
    );
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

    if (result.isNotEmpty && result[0]['max_id']!=null) {
       maxId = int.parse((result[0]['max_id']).toString())+ 1;
      print("MAXID : "+maxId.toString());

    } else {
       maxId = int.parse(Loginprovider.id.toString()+'000')+1;
      print("MAXfromdatabaselocal"+maxId.toString());
    }
    return maxId; // Return 0 if there are no records in the table

  }

  Future<void> addUnitItem(List<UnitItemModel> items) async{
    final Database database = await initializeDB();
    for (int i = 0; i < items.length; i++) {
      var res = await database.insert('UnitItem', items[i].toMap());
      print("Result " + i.toString() + " :" + res.toString());
    }

  }

  Future<void> addUnites(List<UnitesModel> items) async {
    final Database database = await initializeDB();
    for (int i = 0; i < items.length; i++) {
      var res =
      await database.insert('Unites', items[i].toMap());
      print("Result " + i.toString() + " :" + res.toString());
    }
  }

  Future<void> addItemsCateg(List<ItemsCategModel> items) async {
    final Database database = await initializeDB();
    for (int i = 0; i < items.length; i++) {
      var res =
      await database.insert('Items_Categ', items[i].toMap());
      print("Result " + i.toString() + " :" + res.toString());
    }
  }
  Future<void> addinvfe(List<ItemModel> items) async {
    final Database database = await initializeDB();
    for (int i = 0; i < items.length; i++) {
      var res =
      await database.insert('invf', items[i].toMap());
      print("Result " + i.toString() + " :" + res.toString());
    }
  }


  Future<int> getMaxIdFromTable(String tableName) async {
    final Database database = await initializeDB();
    final List<Map<String, dynamic>> result = await database.rawQuery(
      'SELECT MAX(ID) as max_id FROM $tableName',
    );

    if (result.isNotEmpty && result[0]['max_id']!=null) {
      int? maxId = int.parse((result[0]['max_id']).toString())+ 1;
      print("MAXID : "+maxId.toString());
      return maxId ?? 0; // Return 0 if maxId is null

    } else {
      print("MAXID : return 9");

      return 0; // Return 0 if there are no records in the table
    }
  }

  Future<int> getMaxIdFromTableNo(BuildContext context,String tableName) async {
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

    final Database database = await initializeDB();
    final List<Map<String, dynamic>> result = await database.rawQuery(
      'SELECT MAX(TransNo) as max_TransNo FROM $tableName',
    );

    if (result.isNotEmpty && result[0]['max_TransNo']!=null) {
      int? maxId = int.parse(result[0]['max_TransNo']) + 1;
      print("max_TransNo : "+maxId.toString());
      return maxId ?? int.parse(Loginprovider.id.toString()+"000")+1; // Return 0 if maxId is null
      } else {
      print("max_TransNo : return 9");
      print(int.parse(Loginprovider.id.toString()+"0000")+1);
      return int.parse(Loginprovider.id.toString()+"0000")+1; // Return 0 if there are no records in the table
      }
  }

  Future<void> addManLogTrans(List<ManLogTransModel> Manlogtrans) async {
    //Dropbranches();
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


    print("branches.length " + branches.length.toString() );


    for (int i = 0; i < branches.length; i++) {
      var res = await database.insert('branches', branches[i].toMap());
      print("Result " + i.toString() + " :" + res.toString());
    }
  }


  Future<void> addbManVisits(List<ManVisitsModel> manvisits) async {
  //  Dropbranches();
    final Database database = await initializeDB();
    for (int i = 0; i < manvisits.length; i++) {
      var res = await database.insert('ManVisits', manvisits[i].toMap());
      print("Result " + i.toString() + " :" + res.toString());
    }
  }


  Future<void> updateManVisits(List<ManVisitsModel> manvisits) async {
  //  Dropbranches();
    final Database database = await initializeDB();


    // Calculate the maximum ID value from the ManVisits table.
    final maxIdResult = await database.rawQuery('SELECT max(ID) as maxId FROM ManVisits');
    final maxId = maxIdResult.first['maxId'] as int;

print("maxIdmaxId  : "+maxId.toString());

    await database.rawQuery(
      'UPDATE ManVisits SET End_Time = ? , note= ? , X_Lat= ? ,Y_Long = ? , loct = ?  , posted = ? WHERE ID = $maxId ',
      [ manvisits.first.End_Time, manvisits.first.note,manvisits.first.X_Lat,
        manvisits.first.Y_Long, manvisits.first.loct,0],

    );


    
  }





  Future<List<CustomersModel>> retrievebranches() async {

    final Database database = await initializeDB();

     List<Map<String, Object?>> queryResult =
        await database.rawQuery('select * from  branches');

    return queryResult.map((e) => CustomersModel.fromMap(e)).toList();
  }


  Future<List<ItemModel>> reterveInvf() async {

    final Database database = await initializeDB();

    List<Map<String, Object?>> queryResult =
    await database.rawQuery('select * from  invf');

    return queryResult.map((e) => ItemModel.fromMap(e)).toList();
  }


   retrievebrancheswithID(String id) async {

    final Database database = await initializeDB();

    List<Map<String, Object?>> queryResult =
    await database.rawQuery('select * from  branches where customerid = $id');

    return queryResult.map((e) => CustomersModel.fromMap(e)).toList().first;
  }




  Future<void> Dropbranches() async {
    final Database db = await initializeDB();
    db.delete('branches');
  }

  Future<void> DropRepresentatives() async {
    final Database db = await initializeDB();
    db.delete('Representatives');
  }




  Future<ManLogTransModel> retrieveSingelManLogTrans() async {
    final Database database = await initializeDB();
    final List<Map<String, Object?>> queryResult =
    await database.rawQuery('select * from  ManLogTrans');
    return queryResult.map((e) => ManLogTransModel.fromMap(e)).toList().last;
  }



  Future<List<CustomersModel>> retrieveSpecificbranches(int id) async {
    final Database database = await initializeDB();
    final List<Map<String, Object?>> queryResult =
    await database.rawQuery('select * from  branches where customerid=$id');


    return queryResult.map((e) => CustomersModel.fromMap(e)).toList();
  }


  Future<ManVisitsModel> retrieveOpenManVisitss() async {
    final Database database = await initializeDB();
    final List<Map<String, Object?>> queryResult =
    await database.rawQuery('select * from  ManVisits where posted=-1');


    return queryResult.map((e) => ManVisitsModel.fromMap(e)).toList().last;
  }



 retrieveAllOpenManVisitssASjson() async {
    final Database database = await initializeDB();
    final List<Map<String, Object?>> queryResult =
    await database.rawQuery('select  CusNo ,CusName ,DayNum ,Start_Time ,End_Time , ManNo,   Tr_Data,       no,   OrderNo,       Note,   X_Lat,       Y_Long,   Loct,       IsException,   COMPUTERNAME,       orderinvisit,   Duration,       posted from  ManVisits where posted=0');


    String jsonStr = jsonEncode(queryResult);


    return  jsonStr;

  }


  retrieveAllManLongTransnotposted() async {
    final Database database = await initializeDB();
    final List<Map<String, Object?>> queryResult =
    await database.rawQuery('select  ManNo ,CustNo ,ScreenCode ,ActionNo ,TransNo , Trans_Date,   TabletId,       BattryCharge,   Notes,       Notes from  ManLogTrans where posted!=1');

    String jsonStr = jsonEncode(queryResult);
    return  jsonStr;
  }


  Future<void> updateManVisitsAfterpost() async {
    //  Dropbranches();
    final Database database = await initializeDB();
var id=0;
    await database.rawQuery(
      'UPDATE ManVisits set posted = ? WHERE posted = $id ',
      [1],

    );



  }

  Future<void> updateManManLogTrans() async {
    //  Dropbranches();
    final Database database = await initializeDB();
    var id=0;
    await database.rawQuery(
      'UPDATE ManLogTrans set posted = ? WHERE posted = $id ',
      [1],

    );



  }

  Future<List<PriceModel>> getUnitOfItem(String itemId ,String cat) async {
    final Database database = await initializeDB();
    final List<Map<String, Object?>> queryResult =
    await database.rawQuery(
        '''select U.UnitName,U.Unitno ,IC.Price AS price ,IC.dis ,IC.bounce ,UI.Operand  from Unites as U inner join UnitItem as UI on U.Unitno=UI.unitno
          inner join Items_Categ as IC on UI.item_no=IC.ItemCode
        where UI.item_no= $itemId and IC.CategNo=$cat'''
    );

    if(queryResult.map((e) => PriceModel.fromMap(e)).toList().length<1)
      await database.rawQuery(
          '''     select U.UnitName,U.Unitno ,UI.Price AS price ,0.0 AS dis ,0.0 as bounce ,UI.Operand  from Unites as U inner join UnitItem as UI on U.Unitno=UI.unitno
                where UI.item_no=$itemId '''
      );


    return queryResult.map((e) => PriceModel.fromMap(e)).toList();

  }

}
