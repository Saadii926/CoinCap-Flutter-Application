import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final Map rates;
  const DetailsPage({
    super.key,
    required this.rates,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  double? _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    List currencies = widget.rates.keys.toList();
    List rate = widget.rates.values.toList();
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Container(
          // height: _deviceHight! * 0.45,
          width: _deviceWidth! * 0.90,
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color.fromRGBO(83, 88, 206, 0.5),
          ),
          child: ListView.builder(
            itemCount: currencies.length,
            itemBuilder: (context, index) {
              String curreny = currencies[index].toString().toUpperCase();
              String price = rate[index].toString();
              return ListTile(
                title: Text(
                  "$curreny:      $price",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        ),
      )),
    );
  }
}
