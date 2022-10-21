import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';

class ChooseCity extends StatefulWidget {
  const ChooseCity({super.key});

  @override
  State<ChooseCity> createState() => _ChooseCityState();
}

class _ChooseCityState extends State<ChooseCity> {
  late String cityValue;
  late String countryValue;
  late String stateValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      height: 180,
      child: Column(children: [
        SelectState(
          onCityChanged: (value) => setState(() {
            cityValue = value;
            print(cityValue);
          }),
          onCountryChanged: (value) {
            setState(() {
              countryValue = value;
            });
          },
          onStateChanged: (value) {
            setState(() {
              stateValue = value;
            });
          },
        ),
      ]),
    );
  }
}
