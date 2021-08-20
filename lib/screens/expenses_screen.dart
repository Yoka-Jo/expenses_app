import 'package:flutter/material.dart';
import '../screenSize.dart';
import './weeksProducts_screen.dart';
import '../data/data.dart';
import '../dbHelper/DBHelper.dart';
import 'package:sqflite/sqflite.dart';

class ExpensesScreen extends StatefulWidget {

  @override
  _ExpensesScreenState createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  DbHelper dbHelper = DbHelper();

  List<ProductData> productsList;

  int count = 0;

  String moneyCollection(String week) {
    int i = 0;
    double allMoney = 0;

    while (i < count) {
      if (productsList[i].week == week) {
        allMoney += productsList[i].price * productsList[i].number;
      }
      i++;
    }
    return allMoney.toString();
  }

  String allMoneyCollection() {
    int i = 0;
    double allMoney = 0;

    while (i < count) {
      allMoney += productsList[i].price * productsList[i].number;
      i++;
    }
    return allMoney.toString();
  }

  void updateListView() {
    final Future<Database> dbFuture = dbHelper.createDatabase();
    dbFuture.then((database) {
      Future<List<ProductData>> productListFuture = dbHelper.getProductList();
      productListFuture.then((productList) {
        setState(() {
          productsList = productList;
          count = productList.length;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (productsList == null) {
      productsList = [];
      updateListView();
    }

    SizeConfig2().init(context);
    final _isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [Color(0xffF28080), Color(0xff7D1DFA)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Month Expenses',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(height: 30.0,),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 10 , horizontal: 40),
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                    child: Column(
                      children: [
                        Text('Your Expenses till now' , style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold , fontSize: 20),),
                            SizedBox(height: 10.0,),
                 Container(
                    height: 90,
                   width: 90,
                   padding: EdgeInsets.all(1.5),
                   decoration: BoxDecoration(
                     color: Colors.white,
                     shape: BoxShape.circle
                   ),
                   child: CircleAvatar(
                     backgroundColor: Colors.black,
                     maxRadius: 45,
                            child: Text(
                    '${allMoneyCollection() ?? '...'} \$',
                    style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold , fontSize: 20),
                ),
                          ),
                 ),
                      ],
                    )),
              ),
              SizedBox(
                height: _isLandScape ? 10 : 10,
              ),
              Expanded(
                child: GridView(
                  padding: EdgeInsets.only(bottom: _isLandScape ? 40 : 0),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    childAspectRatio: 1,
                    maxCrossAxisExtent: _isLandScape
                        ? SizeConfig2.safeBlockVerticalWithOutAppBar * 60
                        : SizeConfig2.safeBlockVerticalWithOutAppBar * 40,
                    mainAxisSpacing: 15,
                  ),
                  children: [
                    ExtensesDetail('First Week', moneyCollection('First Week'),
                        updateListView),
                    ExtensesDetail('Second Week',
                        moneyCollection('Second Week'), updateListView),
                    ExtensesDetail('Third Week', moneyCollection('Third Week'),
                        updateListView),
                    ExtensesDetail('Forth Week', moneyCollection('Forth Week'),
                        updateListView),
                  ],
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(Colors.red.shade900), ),
                child: Text('Delete All Products' , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),
                onPressed:() {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      backgroundColor: Color(0xff7D1DFA),
                      title: Center(
                        child: Text('Are You Sure?',
                            style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold)),
                      ),
                      content: Text(
                        'You are about to delete all products.',
                        style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('No' ,style: TextStyle(color: Color(0xffF28080) , fontWeight: FontWeight.bold),)),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              dbHelper
                                 .cleanDatabase();
                              updateListView();
                            },
                            child: Text('Yes' , style: TextStyle(color: Color(0xffF28080) , fontWeight: FontWeight.bold)))
                      ],
                    )
                  );
                }
              ),
              SizedBox(height: SizeConfig2.safeBlockVerticalWithOutAppBar * 5,)
            ],
          ),
        ),
      ),
    );
  }
}

class ExtensesDetail extends StatelessWidget {
  final String weekName;
  final String muchMoney;
  final Function reload;

  const ExtensesDetail(this.weekName, this.muchMoney, this.reload);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bool result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WeekProductsScreen(weekName))) ??
            true;
//        of(context).pushNamed(WeekProductsScreen.routeName , arguments:weekName);
        if (result) {
          reload();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              weekName,
              style: TextStyle(color: Colors.white38),
            ),
            SizedBox(height: 10),
            Text(
              muchMoney == '0.0' ? 'No Products Yet' : '$muchMoney \$',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold , fontSize: muchMoney == '0.0' ? 14: 20),
            ),
            SizedBox(height: 10),
            Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.deepOrange),
                child: Icon(
                  Icons.arrow_forward,
                  size: 23,
                ))
          ],
        ),
      ),
    );
  }
}
