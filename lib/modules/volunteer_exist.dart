import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crt_stand/sevices/dateServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../sevices/auth_services.dart';

AuthServices _authServices = AuthServices();
FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
DateServices _dateServices = DateServices();
TextEditingController _timeFrom = TextEditingController();
TextEditingController _timeTo = TextEditingController();

class VolunteerList extends StatefulWidget {
  final String magasin;
  final String date;
  const VolunteerList({Key? key,required this.magasin,required this.date}) : super(key: key);

  @override
  State<VolunteerList> createState() => _VolunteerListState();
}

class _VolunteerListState extends State<VolunteerList> {

  var _dialogKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('${widget.magasin=="AzizaH"? "Aziza" : widget.magasin}'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: _dateServices
                        .getListVolunteerData(widget.date.toString(),widget.magasin),
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
                                title: Text(
                                    '${document["name"]}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text('${document["timeFrom"]} To ${document["timeTo"]}'),
                                trailing: FutureBuilder<DocumentSnapshot>(
                                  future: _authServices.getUserData(_firebaseAuth.currentUser!.uid),
                                  builder: (context, snapshot) {
                                    if(snapshot.hasData){
                                      if(document["name"] == snapshot.data!["name"]){
                                        return IconButton(
                                          onPressed: (){
                                            _dateServices.deleteVolunteerFromMagasin(widget.date.toString(),widget.magasin,document["name"]);
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
                         // _dateServices.addVolunteerToMagasin(widget.date, widget.magasin, snapshot.data!["name"]);
                          _dialog(snapshot.data!["name"]);
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

  _dialog(String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            title: const Text(
              'The time you\'ll be availble at?',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
              ),
            ),
            actions: [
              Form(
                key: _dialogKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(bottom: 10.0,start: 10.0,end: 10.0),
                      child: TextFormField(
                        controller: _timeFrom,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'From',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'From must not be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(bottom: 10.0,start: 10.0,end: 10.0),
                      child: TextFormField(
                        controller: _timeTo,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'To',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'To must not be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    TextButton(
                      child: const Text('Ok'),
                      onPressed: () {
                        if(_dialogKey.currentState!.validate()){
                          _dateServices.addVolunteerToMagasin(widget.date, widget.magasin, name,_timeFrom.text.trim(),_timeTo.text.trim());
                          Navigator.pop(context);
                          _timeFrom.clear();
                          _timeTo.clear();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

