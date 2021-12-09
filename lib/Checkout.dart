import 'package:flutter/material.dart';

class Checkout extends StatefulWidget {
  final List cartdetail;
   List<TextEditingController> quantity = new List();

   Checkout({Key key,@required this.cartdetail, @required this.quantity}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState(cartdetail: this.cartdetail ,quantity: this.quantity);
}

class _CheckoutState extends State<Checkout> {
  _CheckoutState({this.cartdetail,this.quantity});
  List cartdetail;
   List<TextEditingController> quantity = new List();
  int selectedRadio;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(
          color: Colors.blueGrey,
        ),
        title: new Center(
            child: new Text(
          'Order Summary',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.blueGrey),
        )),
        backgroundColor: Colors.white,
        elevation: 3.0,
      ),
      body: Container(
        child: new ListView.builder(
            itemCount: cartdetail == null ? 0 : cartdetail.length,
            itemBuilder: (BuildContext context, int index) {
              var name = cartdetail[index]['productName'];
              String price = cartdetail[index]['price'];
              var img = cartdetail[index]['picture'];
              var peodQuant =quantity[index].text;
              var brand = 'Brand Name';
              var modified=price.replaceRange(0, 1, '');
              var total =double.parse(modified.replaceAll(RegExp(','), '')) *double.parse(peodQuant);
              return new Column(
                children: <Widget>[
                  new ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: new Image.network(img)),
                    ),
                    title: Text(name),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2.0),
                                child: Text('Qty : $peodQuant'),
                              ),
                              Spacer(),
                              Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                                  child: Text('Price : $price')),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Text('Selected Color : RGB'),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Text('Selected Brand : $brand'),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Text('Total Price : $total'),
                          ),
                        ]),
                  ),
                  new Divider(),
                ],
              );
            }),
      ),
    );
  }
}
