import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crt_stand/sevices/dateServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../sevices/auth_services.dart';

AuthServices _authServices = AuthServices();
FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
DateServices _dateServices = DateServices();

class VolunteerList extends StatelessWidget {
  final String magasin;
  final String date;
  const VolunteerList({Key? key,required this.magasin,required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('${magasin=="AzizaH"? "Aziza" : magasin}'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: _dateServices
                        .getListVolunteerData(date.toString(),magasin),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          Map<String, dynamic> document =
                          snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;
                          if(document["name"]!="Stand"){
                            return Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, 2),
                                      blurRadius: 6.0)
                                ],
                              ),
                              child: ListTile(
                                leading: const Icon(Icons.account_circle, size: 50,color: Colors.black,),
                                title: Text('${document["name"]}'),
                                subtitle: Text('Subtitle'),
                                trailing: FutureBuilder<DocumentSnapshot>(
                                  future: _authServices.getUserData(_firebaseAuth.currentUser!.uid),
                                  builder: (context, snapshot) {
                                    if(snapshot.hasData){
                                      if(document["name"] == snapshot.data!["name"]){
                                        return IconButton(
                                          onPressed: (){
                                            _dateServices.deleteVolunteerFromMagasin(date.toString(),magasin,document["name"]);
                                            print('done');
                                          },
                                            icon: Icon(Icons.cancel_outlined),
                                        );
                                      }else{
                                        return Container();
                                      }
                                    }else{
                                      return const CircularProgressIndicator();
                                    }
                                  }
                                ),
                              ),
                            );
                          }else{
                            return Container();
                          }
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 0.0);
                        },
                        itemCount: snapshot.data!.docs.length,
                      );
                    }
                    else{
                      return Container();
                    }
                  }
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadiusDirectional.all(Radius.circular(20.0),
                  ),
                ),
                child: FutureBuilder<DocumentSnapshot>(
                    future: _authServices
                        .getUserData(_firebaseAuth.currentUser!.uid),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return CupertinoButton(
                        child: const Text(
                          'Tap to submit',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                        onPressed: (){
                          _dateServices.addVolunteerToMagasin(date, magasin, snapshot.data!["name"]);
                        },
                      );
                    }else{
                      return const CircularProgressIndicator();
                    }
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
