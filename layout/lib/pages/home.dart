import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:layout/main.dart';
import 'package:layout/pages/detail.dart';

import 'package:http/http.dart' as http;
import 'dart:async';

class HomePage extends StatefulWidget {
  //const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Image.asset(
                'assets/logogsnu.png',
                scale: 3,
              ),
              Container(
                  //padding: EdgeInsets.all(20),
                  alignment: FractionalOffset.topCenter,
                  child: Text(
                    "บัณฑิตวิทยาลัย มหาวิทยาลัยนเรศวร",
                    style: TextStyle(
                        fontFamily: 'Prompt-BlackItalic',
                        fontSize: 12,
                        color: Colors.white),
                  )),
            ],
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder(
              builder: (context, AsyncSnapshot snapshot) {
                // var data = json.decode(snapshot.data.toString());
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return MyBox(
                        snapshot.data[index]['title'],
                        snapshot.data[index]['subtitle'],
                        snapshot.data[index]['image_url'],
                        snapshot.data[index]['detail']);
                  },
                  itemCount: snapshot.data.length,
                );
              },
              future: getData(),
              //future:DefaultAssetBundle.of(context).loadString('assets/data.json'),
            )));
  }

  Widget MyBox(String title, String subtitle, String image_url, String detail) {
    var v1, v2, v3, v4;
    v1 = title;
    v2 = subtitle;
    v3 = image_url;
    v4 = detail;
    return Container(
      margin: (EdgeInsets.only(top: 20)),
      padding: EdgeInsets.all(20),
      //color: Colors.blue.shade50,
      height: 200,
      decoration: BoxDecoration(
          //color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: NetworkImage(image_url),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.60), BlendMode.darken))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          SizedBox(
            height: 15,
          ),
          TextButton(
              onPressed: () {
                print("Next Page >>>");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPage(v1, v2, v3, v4)));
              },
              child: Text("รายละเอียด",
                  style: TextStyle(
                      fontFamily: ('Prompt-BlackItalic'),
                      fontSize: 18,
                      color: Colors.yellow.shade600)))
        ],
      ),
    );
  }

  Future getData() async {
    //https://raw.githubusercontent.com/Komgri/BasicAPI/main/data.json
    var url = Uri.https(
        'raw.githubusercontent.com', '/Komgri/BasicAPI/main/data.json');
    var response = await http.get(url);
    var result = json.decode(response.body);
    return result;
  }
}
