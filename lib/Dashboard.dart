import 'Profile.dart';
import 'main.dart';
import 'model/UserProfileModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'StateManagement/UserProvider.dart';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Lottery/SchemeList.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future logout() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    UserProfileModel _udata = userProvider.profile();

    return userProvider.isLoading == false
        ? Container(
            child: Scaffold(
              backgroundColor: NeumorphicTheme.baseColor(context),
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                actions: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Profile()));
                    },
                    child: Icon(
                      Icons.account_circle,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 20)
                ],
              ),
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(color: Colors.green),
                      accountName: Text(
                        _udata.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      accountEmail: Text(
                        _udata.email,
                        style: TextStyle(color: Colors.white60),
                      ),
                      currentAccountPicture: Card(
                        shape: CircleBorder(),
                        elevation: 8,
                        child: ClipOval(
                            // backgroundColor: Colors.white,
                            child: Padding(
                          padding: EdgeInsets.all(6),
                          child: Center(
                            child: Text(
                              "${_udata.email[0]}",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )),
                      ),
                    ),
                    ListTile(
                      title: Text('Home'),
                      trailing: Icon(Icons.home),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Privacy Policy'),
                      trailing: Icon(Icons.report),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Logout'),
                      trailing: Icon(Icons.highlight_off),
                      onTap: () {
                        logout().then((onValue) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => MyApp()));
                        });
                      },
                    ),
                  ],
                ),
              ),
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        child: Text('Welcome To Star Lottery',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        NeumorphicButton(
                            margin: EdgeInsets.only(top: 12),
                            onClick: () {
                              
                            },
                            style: NeumorphicStyle(
                                shape: NeumorphicShape.flat,
                                color: Colors.redAccent),
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(8)),
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "My Entries",
                              style: TextStyle(color: Colors.white),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        NeumorphicButton(
                            margin: EdgeInsets.only(top: 12),
                            onClick: () {
                            
                            },
                            style: NeumorphicStyle(
                                shape: NeumorphicShape.flat,
                                color: Colors.redAccent),
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(8)),
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "Winners",
                              style: TextStyle(color: Colors.white),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        child: Text('Open Schemes',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SchemeList(),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            body: Center(
                child: AwesomeLoader(
              loaderType: AwesomeLoader.AwesomeLoader4,
              color: Colors.green,
            )),
          );
  }
}
