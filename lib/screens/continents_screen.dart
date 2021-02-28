import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geo_quiz/model/continents.dart';
import 'package:geo_quiz/model/countries.dart';

import 'question_screen.dart';

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
              onTap: () {
                var questionSet =
                    createQuestions(continentList[index].continentCode);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            QuestionScreen(questionSet: questionSet)));
              },
              title: Text(continentList[index].continentName),
            );
          },
        ),
      ),
    );
  }
}

List<QuestionSet> createQuestions(String continentCode) {
  var countryDataList = getCountriesFromContinent(continentCode);
  var questionSet = createQuestionSet(countryDataList);
  return questionSet;
}

List<QuestionSet> createQuestionSet(List<CountryData> countryDataList) {
  List<QuestionSet> questionSetList = new List<QuestionSet>();
  for (var countryData in countryDataList) {
    var questionSet = new QuestionSet(countryData);
    questionSet.generateOptionList(countryDataList);
    questionSetList.add(questionSet);
  }
  return questionSetList;
}

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

class QuestionSet {
  final CountryData currentCountry;
  List<CountryData> optionList = new List<CountryData>();

  QuestionSet(this.currentCountry);

  generateOptionList(List<CountryData> countryDataList) {
    optionList.add(currentCountry);
    var indexList = getIndexList(countryDataList);
    for (var index in indexList) {
      optionList.add(countryDataList[index]);
    }
    optionList.shuffle();
  }

  List<int> getIndexList(List<CountryData> countryDataList) {
    var indexList = new List<int>();
    var random = new Random();
    while (indexList.length < 3) {
      var randomNumber = random.nextInt(countryDataList.length);
      if (!indexList.contains(randomNumber)) {
        indexList.add(randomNumber);
      }
    }
    return indexList;
  }
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
