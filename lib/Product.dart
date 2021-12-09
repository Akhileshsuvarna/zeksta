import 'dart:async' show Future;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'Checkout.dart';


class Product extends StatefulWidget {
  const Product({Key key}) : super(key: key);

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  int selectedRadio;
  int _value = 1;
  List<TextEditingController> _controllers = new List();
  List  data1,data2;
  bool isLoading = false;
  List<DropdownMenuItem<int>> _menuItems;
  Future<String> loadJsonData() async {
    var jsonText1 = await rootBundle.loadString('assets/Products.json');
    setState(() => data1 = json.decode(jsonText1));
    return 'success';
  }

  @override
  void initState() {
    super.initState();
    this.loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Center(
            child: new Text(
          'Product List',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.blueGrey))),
        backgroundColor: Colors.white,
        elevation: 3.0,),
      body: Container(
        child: new ListView.builder(
            itemCount: data1 == null ? 0 : data1.length,
            itemBuilder: (BuildContext context, int index) {
              _controllers.add(new TextEditingController());
              var name = data1[index]['productName'];
              var email = data1[index]['price'];
              var img = data1[index]['picture'];
              List dataList = data1[index]['brands'];
              _menuItems = List.generate(
                dataList.length,
                (i) => DropdownMenuItem(
                  value: dataList[i]["id"],
                  child: Text("${dataList[i]["name"]}"),
                ),
              );
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
                          Text('Price : $email'),
                          Row(
                            children: [
                              Radio(
                                value: 1,
                                groupValue: selectedRadio,
                              ),
                              Text('Red'),
                              Radio(
                                value: 1,
                                groupValue: selectedRadio,
                              ),
                              Text('Blue'),
                              Radio(
                                value: 1,
                                groupValue: selectedRadio,
                              ),
                              Text('Greend'),
                            ],
                          ),
                          Center(
                            child: DropdownButton<int>(
                              items: _menuItems,
                              value: _value,
                              onChanged: (value) =>
                                  setState(() => _value = value),
                            ),
                          ),
                          Center(
                            child: TextFormField(
                              style: TextStyle(
                                  color: Color(0xFF050A30), fontSize: 16),
                              controller: _controllers[index],
                              decoration: InputDecoration(
                                hintText: 'Enter Qty',
                                hintStyle: TextStyle(
                                    color: Color(0xFF989EAA),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300),
                                filled: true,
                                fillColor: Colors.white,
                                focusColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xFFD6D8DD), width: 2.0),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                isDense: true,
                                prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: Color(0xFFD6D8DD),
                                    )),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  new Divider(),
                ],
              );
            }),
      ),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical:5),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.grey.shade100,elevation: 2.0),
          onPressed: () async {
            setState(() {
              isLoading = true;
            });
            await Future.delayed(const Duration(seconds: 3));
            setState(() {
              print(data1[0].toString());
              print(_controllers[0].text);
                  for (var j = 0; j < _controllers.length; j++) {
                  var  text1 = _controllers[j].text ;
                    if (text1=='')
                      {
                        _controllers[j].text ='1';
                      }
                  }
                     isLoading = false;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Checkout(cartdetail: data1,quantity:_controllers),
                  ));
            });
          },
          child: (isLoading)
              ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                color: Colors.green,
                strokeWidth: 2.0,
              ))
              : const Text('Submit',style: TextStyle(color: Colors.black),),
        ),
      ),
    );
  }
}