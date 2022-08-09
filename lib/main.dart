import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:online_shop/model/modelclass.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  void _incrementCounter() {


  }
  var _Style =
  TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold);

  @override
  void initState() {
    getDataFormaApi();
  }

  List<category> dataList = [];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("json get")),
      ),
      body:ListView.builder(
        itemCount: dataList.length,
          itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            color: Colors.red,
            height: MediaQuery.of(context).size.height *.2,
            width: MediaQuery.of(context).size.width,
            child: Stack(
                children: [
            Image.network(dataList[index].banner,

            ),
            Container(
              alignment: Alignment.bottomCenter,
              // decoration: BoxDecoration(
              //     color: Colors.black.withOpacity(.4)),
            child:   Text(dataList[index].name,
              style: _Style
            ),
            )
          ]
          ),
          )
        );
      }
      )
    );
  }

  getDataFormaApi() async {
    String apiurl =
        "http://192.168.93.16:81/appdev/api/v1/categories";

    var rasult = await http.get(Uri.parse(apiurl));

    print(rasult.body);
    var jesonData = jsonDecode(rasult.body);
    print(jesonData);

    jesonData['articles'].forEach((item) {
      category articles = category(
        item['banner'] ?? "osman",
        item['name'] ?? "md",
      );
      dataList.add(articles);
    });
    setState(() {

    });
  }
}