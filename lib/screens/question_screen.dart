import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geo_quiz/model/capital_list.dart';

class QuestionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var countries = getCountryList();
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QuestionSection(size: size, country: getCorrectCountry(countries)),
            SizedBox(
              height: 40,
            ),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: [
                Option(size: size, capital: countries[0].capital),
                Option(size: size, capital: countries[1].capital),
                Option(size: size, capital: countries[2].capital),
                Option(size: size, capital: countries[3].capital),
              ],
            )
          ],
        ),
      ),
    );
  }

  List<CountryData> getCountryList() {
    var countryList = List<CountryData>();
    var indexList = getIndexList();
    var correctIndex = indexList[Random().nextInt(4)];
    for (var index in indexList) {
      var country = capitalList[index];
      var countryData = new CountryData(
        country: country["country"],
        capital: country["city"],
        isCorrect: index == correctIndex ? true : false,
      );
      countryList.add(countryData);
    }

    return countryList;
  }

  List<int> getIndexList() {
    var indexList = new List<int>();
    var random = new Random();
    while (indexList.length < 4) {
      var randomNumber = random.nextInt(capitalList.length);
      if (!indexList.contains(randomNumber)) {
        indexList.add(randomNumber);
      }
    }
    return indexList;
  }

  getCorrectCountry(List<CountryData> countries) {
    var country = countries.firstWhere((c) => c.isCorrect == true).country;
    return country;
  }
}

class CountryData {
  final String country;
  final String capital;
  final bool isCorrect;

  CountryData({this.country, this.capital, this.isCorrect = false});
}

class Option extends StatelessWidget {
  const Option({
    Key key,
    @required this.size,
    @required this.capital,
  }) : super(key: key);

  final Size size;
  final String capital;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 92,
      width: size.width / 2 - 2,
      color: Colors.white,
      child: Text(
        capital ?? '',
        textAlign: TextAlign.center,
      ),
    );
  }
}

class QuestionSection extends StatelessWidget {
  const QuestionSection({
    Key key,
    @required this.size,
    @required this.country,
  }) : super(key: key);

  final Size size;
  final String country;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: size.height * 0.35,
      width: double.infinity,
      padding: EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'What is the capital of',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            country,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
