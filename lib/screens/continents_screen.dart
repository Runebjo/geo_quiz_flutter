import 'package:flutter/material.dart';
import 'package:geo_quiz/model/continents.dart';
import 'package:geo_quiz/model/countries.dart';

class ContinentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var continentList = List<Continent>();
    continents.forEach((key, value) {
      var continent = Continent(
        continentCode: key,
        continentName: value,
      );
      continentList.add(continent);
    });
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: continentList.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () => createQuestions(continentList[index].continentCode),
              title: Text(continentList[index].continentName),
            );
          },
        ),
      ),
    );
  }
}

createQuestions(String continentCode) {
  var countryDataList = getCountriesFromContinent(continentCode);
  var questionSet = createQuestionSet(countryDataList);
}

createQuestionSet(countryDataList) {}

List<CountryData> getCountriesFromContinent(String continentCode) {
  List<CountryData> countryDataList = new List<CountryData>();
  countries.forEach((countryCode, countryData) {
    if (continentCode == countryData["continent"]) {
      var country = new CountryData(
        countryCode: countryCode,
        countryName: countryData["name"],
        capital: countryData["capital"],
      );
      countryDataList.add(country);
    }
  });
  return countryDataList;
}

class CountryData {
  final String countryCode;
  final String countryName;
  final String capital;

  CountryData({this.countryCode, this.countryName, this.capital});
}

class Continent {
  final String continentCode;
  final String continentName;

  Continent({this.continentCode, this.continentName});
}
