import 'package:flutter/material.dart';
import '../widget/addButton.dart';
import '../screenSize.dart';
import '../data/data.dart';
import '../dbHelper/DBHelper.dart';
import 'package:intl/intl.dart';

class AddProductScreen extends StatefulWidget {
  static const routeName = '/AddProductScreen';
  final ProductData productData;
  final String week;

  AddProductScreen(this.productData, this.week);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController productNameController;

  TextEditingController productPriceController;

  TextEditingController productNumberController;
  DbHelper dbHelper = DbHelper();

  @override
  void initState() {
    productNameController = TextEditingController();
    productPriceController = TextEditingController();
    productNumberController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    productNameController.dispose();
    productPriceController.dispose();
    productNumberController.dispose();
    super.dispose();
  }



  void _save() async {
    if(productNameController.text.isNotEmpty && productPriceController.text.isNotEmpty && productNumberController.text.isNotEmpty){
    widget.productData.productName = productNameController.text;
    widget.productData.price = double.parse(productPriceController.text);
    widget.productData.number = int.parse(productNumberController.text);

    Navigator.of(context).pop(true);
    widget.productData.date =
        DateFormat.yMMMd().format(DateTime.now()).toString();
    widget.productData.week = widget.week;
    int result = await dbHelper.createProduct(widget.productData);

    if (result == 0) {
      showAlertDialog('Status', 'Problem svaing Product');
    }
  }
  else{
    return;
  }
  }

  void showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  @override
  Widget build(BuildContext context) {
//    productNameController.text = widget.productData.productName;
//    productPriceController.text = widget.productData.price.toString();
//    productNumberController.text = widget.productData.number.toString();
    final height = SizeConfig2.safeBlockVerticalWithOutAppBar;
    final width = SizeConfig2.safeBlockHorizontal;
    final radiusOfTextField = SizeConfig2.safeBlockHorizontal * 3;
    final _isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xffF28080), Color(0xff7D1DFA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: !_isLandScape
              ? AppBar(
                  title: Text('Add Product'),
                  backgroundColor: Colors.indigoAccent,
                )
              : null,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (_isLandScape)
                  SizedBox(
                    height: height * 15,
                  ),
                Container(
                  margin: EdgeInsets.only(left: _isLandScape ? width * 4 : 0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: _isLandScape ? height * 1 : height * 15,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: height * 2),
                        child: Container(
                          width: width * 90,
                          child: TextField(
                             controller: productNameController,
                            style: TextStyle(
                                height: .9, color: Colors.white, fontSize: 20),
                            decoration: InputDecoration(
                              hintText: 'Product Name',
                              hintStyle: TextStyle(fontSize: 15),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(radiusOfTextField))),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.blue),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(radiusOfTextField))),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: _isLandScape ? height * 1 : height * 4,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: height * 2),
                        child: Container(
                          width: width * 90,
                          child: TextField( 
                            controller: productPriceController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                height: .9, color: Colors.white, fontSize: 20),
                            decoration: InputDecoration(
                              hintText: 'Price',
                              hintStyle: TextStyle(fontSize: 15),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(radiusOfTextField))),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.blue),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(radiusOfTextField))),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: _isLandScape ? height * 1 : height * 4,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: height * 2),
                        child: Container(
                          width: width * 90,
                          child: TextField( 
                            controller: productNumberController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                height: .9, color: Colors.white, fontSize: 20),
                            decoration: InputDecoration(
                              hintText: 'How Many ?',
                              hintStyle: TextStyle(fontSize: 15),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(radiusOfTextField))),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.blue),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(radiusOfTextField))),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: _isLandScape ? height * 1.5 : height * 10,
                ),
                Container(
                    margin: EdgeInsets.only(left: _isLandScape ? width * 5 : 0),
                    child: AddButton(_save)),
                      SizedBox(height: 20.0,)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
