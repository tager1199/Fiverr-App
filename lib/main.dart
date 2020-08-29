import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './WordPress.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const PrimaryColor = const Color(0xFFDF725B);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: PrimaryColor,
      ),
      title: 'phillycouponmom',
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const PrimaryColor = const Color(0xFFDF725B);
  static const SecondaryColor = const Color(0xFF635C5A);

  static List<Widget> _widgetOptions = <Widget>[
    PostManager(449),
    PostManager(427),
    PostManager(22),
    PostManager(84),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Choice _selectedChoice = choices[0]; // The app's "state".
  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    setState(() {
      _selectedChoice = choice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        leading: // overflow menu
            PopupMenuButton<Choice>(
          onSelected: _select,
          itemBuilder: (BuildContext context) {
            return choices.map((Choice choice) {
              return PopupMenuItem<Choice>(
                value: choice,
                child: Text(choice.title),
              );
            }).toList();
          },
        ),
        title: const Text('Philly Coupon Mom'),
        centerTitle: true,
        actions: <Widget>[
          // Text
          // Search button
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              //_select(choices[1]);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomAppBar(
        color: SecondaryColor,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
              textColor: Colors.white,
              child: Text("Coupons"),
              onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
            FlatButton(
              textColor: Colors.white,
              child: Text("Hacks"),
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
            ),
            FlatButton(
              textColor: Colors.white,
              child: Text("Walmart"),
              onPressed: () {
                setState(() {
                  _selectedIndex = 2;
                });
              },
            ),
            FlatButton(
              textColor: Colors.white,
              child: Text("\$1 or Less"),
              onPressed: () {
                setState(() {
                  _selectedIndex = 3;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Account', icon: Icons.account_circle),
  const Choice(title: 'Settings', icon: Icons.settings),
];
