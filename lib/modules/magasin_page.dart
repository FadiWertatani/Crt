import 'package:crt_stand/modules/volunteer_exist.dart';
import 'package:crt_stand/sevices/dateServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

DateServices _dateServices = DateServices();

class MagasinScreen extends StatelessWidget {

  final DateTime date;

  MagasinScreen({Key? key,required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              '${date.day}-${date.month}-${date.year}'
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView(
            children: [
              InkWell(
                onTap: () {
                  _dateServices.addMagasinToDate(date.toString(), 'Mg', 'Stand');
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => VolunteerList(magasin: 'Mg',date: date.toString()),
                    ),
                  );
                },
                child: Container(
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
                  child: const ListTile(
                    leading: Image(
                      image: AssetImage('assets/mg.png'),
                      width: 50,
                    ),
                    title: Text('Mg'),
                    subtitle: Text('Erriadh'),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _dateServices.addMagasinToDate(date.toString(), 'Carrefour', 'Stand');
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => VolunteerList(magasin: 'Carrefour',date: date.toString()),
                    ),
                  );
                },
                child: Container(
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
                  child: const ListTile(
                    leading: Image(
                      image: AssetImage('assets/download.png'),
                      width: 50,
                    ),
                    title: Text('Carrefour'),
                    subtitle: Text('Erriadh'),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _dateServices.addMagasinToDate(date.toString(), 'AzizaH', 'Stand');
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => VolunteerList(magasin: 'AzizaH',date: date.toString()),
                    ),
                  );
                },
                child: Container(
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
                  child: const ListTile(
                    leading: Image(
                      image: AssetImage('assets/aziza.png'),
                      width: 50,
                    ),
                    title: Text('Aziza'),
                    subtitle: Text('Hammam Chatt'),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _dateServices.addMagasinToDate(date.toString(), 'Stand', 'Stand');
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => VolunteerList(magasin: 'AzizaH',date: date.toString()),
                    ),
                  );
                },
                child: Container(
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
                  child: const ListTile(
                    leading: Image(
                      image: AssetImage('assets/crt.png'),
                      width: 50,
                    ),
                    title: Text('porte à porte'),
                    subtitle: Text('All'),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
