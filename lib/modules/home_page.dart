import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crt_stand/models/date.dart';
import 'package:crt_stand/modules/Login.dart';
import 'package:crt_stand/modules/magasin_page.dart';
import 'package:crt_stand/sevices/auth_services.dart';
import 'package:crt_stand/sevices/dateServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

AuthServices _authServices = AuthServices();
FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
DateServices _dateServices = DateServices();

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.red,
                ),
                child: Center(
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Icon(
                          Icons.account_circle,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      FutureBuilder<DocumentSnapshot>(
                          future: _authServices
                              .getUserData(_firebaseAuth.currentUser!.uid),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Expanded(
                                flex: 6,
                                child: Text(
                                  "${textNullCheck(snapshot.data!["name"])}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 8.0),
                child: GestureDetector(
                  onTap: () async {
                    await _authServices.logout(); //new !!!!!
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: const ListTile(
                    title: Text(
                      "Log out",
                      style: TextStyle(
                        color: Colors.redAccent,
                      ),
                    ),
                    leading: Icon(
                      Icons.logout_outlined,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
            ]
          ),

        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: TableCalendar(
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2023, 3, 18),
              focusedDay: DateTime.now(),
              onDaySelected: (date, events) {
                DateModel dateM = DateModel(
                  date: date.toString(),
                );
                _dateServices.addDateToCollection(dateM, date.toString());
                // Navigate to another screen here
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => MagasinScreen(date: date,),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
String? textNullCheck(String? str){
  if(str == null){
    return '';
  }else{
    return str;
  }
}