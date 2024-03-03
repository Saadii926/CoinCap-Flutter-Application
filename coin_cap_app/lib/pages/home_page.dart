import 'dart:convert';
import 'package:coin_cap_app/pages/details_page.dart';
import 'package:coin_cap_app/services/http_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? _deviceHight, _deviceWidth;
  String? _selectedCoin = 'bitcoin';
  @override
  Widget build(BuildContext context) {
    _deviceHight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _dropDownMenuButton(),
                _dataWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dropDownMenuButton() {
    List<String> coins = [
      'bitcoin',
      'ethereum',
      'tether',
      'cardano',
      'ripple',
      'solana'
    ];
    List<DropdownMenuItem<String>> items = coins.map(
      (e) {
        return DropdownMenuItem(
          value: e,
          child: Text(
            e.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: _deviceWidth! * 0.04,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    ).toList();
    return DropdownButton(
      // itemHeight: _deviceHight! * 0.10,
      value: _selectedCoin,
      items: items,
      onChanged: (dynamic value) {
        setState(() {
          _selectedCoin = value;
        });
      },
      underline: Container(),
      dropdownColor: const Color.fromRGBO(83, 88, 206, 1.0),
      borderRadius: BorderRadius.circular(20),
      // itemHeight: _deviceWidth! * 0.08,
      // menuMaxHeight: _deviceHight! * 0.20,
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
        size: 30,
      ),
    );
  }

  Widget _dataWidget() {
    return FutureBuilder(
      future: GetIt.instance.get<HTTPServies>().get("/coins/$_selectedCoin"),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map data = jsonDecode(snapshot.data.toString());
          num usdPrice = data['market_data']['current_price']['usd'];
          num percent24h = data['market_data']['price_change_percentage_24h'];
          String imgurl = data['image']['large'];
          String discription = data['description']['en'];
          Map currentPrice = data['market_data']['current_price'];
          // print(currentPrice);
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onDoubleTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return DetailsPage(rates: currentPrice);
                    },
                  ));
                },
                child: _coinImageWidget(imgurl),
              ),
              _currentPriceWidget(usdPrice),
              _perenctageChange(percent24h),
              _discriptionCard(discription),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
      },
    );
  }

  Widget _currentPriceWidget(num rate) {
    return Text(
      "${rate.toStringAsFixed(2)} USD",
      style: TextStyle(
        color: Colors.white,
        fontSize: _deviceWidth! * 0.08,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _perenctageChange(num change) {
    return Text(
      "${change.toString()} %",
      style: TextStyle(
        color: Colors.white,
        fontSize: _deviceWidth! * 0.04,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _coinImageWidget(String imgurl) {
    return Container(
      // padding: EdgeInsets.symmetric(vertical: _deviceHight! * 1.9),
      height: _deviceHight! * 0.15,
      width: _deviceWidth! * 0.15,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imgurl),
        ),
      ),
    );
  }

  Widget _discriptionCard(String discription) {
    return Container(
      height: _deviceHight! * 0.40,
      width: _deviceWidth! * 0.90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color.fromRGBO(83, 88, 206, 0.5),
      ),
      margin: EdgeInsets.symmetric(vertical: _deviceHight! * 0.05),
      padding: EdgeInsets.symmetric(
        vertical: _deviceHight! * 0.03,
        horizontal: _deviceHight! * 0.03,
      ),
      child: ListView(
        // clipBehavior: Clip.none,
        children: [
          Text(
            discription,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
