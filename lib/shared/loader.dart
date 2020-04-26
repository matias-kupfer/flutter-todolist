import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: SpinKitPulse(
          color: Colors.teal,
          size: 50.0,
        ),
      ),
    );
  }
}
