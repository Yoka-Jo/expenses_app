import 'package:flutter/material.dart';
import './addProduct_screen.dart';
import '../data/product.dart';
import '../dbHelper/DBHelper.dart';
import 'package:sqflite/sqflite.dart';
import '../screenSize.dart';

class WeekProductsScreen extends StatefulWidget {
  static const routeName = '/WeekProductsScreen';
  final String week;

  WeekProductsScreen(this.week);

  @override
  _WeekProductsScreenState createState() => _WeekProductsScreenState();
}

class _WeekProductsScreenState extends State<WeekProductsScreen> {
  DbHelper dbHelper = DbHelper();

  List<Product> productsList;

  int count = 0;

  void deleteProduct(BuildContext context, Product data) async {
    int result = await dbHelper.deleteProduct(data.id);
    if (result != 0) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: Text(
          "Product deleted Successfully",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
      ));
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = dbHelper.createDatabase();
    dbFuture.then((database) {
      Future<List<Product>> productListFuture = dbHelper.getProductList();
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
    final height = SizeConfig2.safeBlockVerticalWithOutAppBar;
    final width = SizeConfig2.safeBlockHorizontal;

    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xffF28080), Color(0xff7D1DFA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop(true);
                }),
            backgroundColor: Colors.indigoAccent,
            title: Text(widget.week),
          ),
          body: ListView.builder(
            itemCount: count,
            itemBuilder: (context, index) {
              if (productsList[index].week == widget.week) {
                return Container(
                  padding: EdgeInsets.symmetric(
                      vertical: height * 1, horizontal: width * 2),
                  margin: EdgeInsets.symmetric(
                      horizontal: width * 2, vertical: height * .5),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(height * 2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SingleChildScrollView(
                            child: Container(
                              height: height * 8,
                              width: width * 80,
                              child: Text(
                                'Product : ${productsList[index].productName}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: height * 2.5),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Price : ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: height * 2.5),
                                  ),
                                  Text(
                                    '${productsList[index].price}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: height * 2.5),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Number : ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: height * 2.5),
                                  ),
                                  Text(
                                    '${productsList[index].number}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: height * 2.5),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Total : ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: height * 2.5),
                                  ),
                                  Text(
                                    '${productsList[index].number * productsList[index].price}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: height * 2.5),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Date : ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: height * 2.5),
                                  ),
                                  Text(
                                    '${productsList[index].date}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: height * 2.5),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: width * 15,
                          ),
                          GestureDetector(
                            child: Icon(
                              Icons.delete,
                              size: height * 10,
                              color: Colors.red.shade900,
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  backgroundColor: Color(0xff7D1DFA),
                                  title: Text('Are You Sure?',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  content: Text(
                                    'You are about to delete this product.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('No',
                                            style: TextStyle(
                                                color: Color(0xffF28080),
                                                fontWeight: FontWeight.bold))),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          deleteProduct(
                                              context, productsList[index]);
                                        },
                                        child: Text('Yes',
                                            style: TextStyle(
                                                color: Color(0xffF28080),
                                                fontWeight: FontWeight.bold)))
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
          floatingActionButton: Container(
            height: height * 8.2,
            padding: EdgeInsets.all(1.5),
            width: width * 16.7,
            decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: FloatingActionButton(
              child: Container(
                height: height * 8.2,
                width: width * 16.7,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xffF28080), Color(0xff7D1DFA)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )),
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
              onPressed: () async {
                final reload = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AddProductScreen(Product(), widget.week);
                    })) ??
                    true;
                if (reload) {
                  updateListView();
                }
              },
            ),
          ),
        ));
  }
}
