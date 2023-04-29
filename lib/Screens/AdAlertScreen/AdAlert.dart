import 'package:flutter/material.dart';

class AdAlert extends StatefulWidget {
  const AdAlert({Key? key}) : super(key: key);

  @override
  State<AdAlert> createState() => _AdAlertState();
}

class _AdAlertState extends State<AdAlert> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Ad Alert",
          style: TextStyle(fontSize: 15),
        ),
        elevation: 0,
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
      ),
    );
  }
}