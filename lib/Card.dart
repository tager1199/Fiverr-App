import 'package:flutter/material.dart';

class coupon extends StatelessWidget {
  final List<String> _coupons;

  coupon(this._coupons);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
        children: _coupons.map(
      (element) => Card(
        child: Column(
          children: <Widget>[Image.asset('Assets/unnamed.png'), Text(element)],
        ),
      ),
    ).toList());
  }
}
