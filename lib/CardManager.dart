import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './Card.dart';

class CouponManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CouponManagerState();
  }
}

class _CouponManagerState extends State<CouponManager> {
  List<String> _Coupons = [];

  _loadList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _Coupons = (prefs.getStringList('List') ?? []);
    });
  }

  final prefs = SharedPreferences.getInstance();

  _SetList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setStringList('List', _Coupons);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadList();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10.0),
          child: RaisedButton(
            onPressed: () {
              setState(() {
                _Coupons.add("Coupon");
                _SetList();
              });
            },
            child: Text('Add Coupon'),
          ),
        ),
        coupon(_Coupons)
      ],
    );
  }
}
