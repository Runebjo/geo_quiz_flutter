import 'package:flutter/material.dart';
import 'continents_screen.dart';

class QuestionScreen extends StatelessWidget {
  final List<QuestionSet> questionSet;

  const QuestionScreen({Key key, this.questionSet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QuestionSection(
                size: size, countryData: questionSet[0].currentCountry),
            SizedBox(
              height: 40,
            ),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: [
                Option(
                    size: size, capital: questionSet[0].optionList[0].capital),
                Option(
                    size: size, capital: questionSet[0].optionList[1].capital),
                Option(
                    size: size, capital: questionSet[0].optionList[2].capital),
                Option(
                    size: size, capital: questionSet[0].optionList[3].capital),
              ],
            )
          ],
        ),
      ),
    );
  }
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
    @required this.countryData,
  }) : super(key: key);

  final Size size;
  final CountryData countryData;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: size.height * 0.4,
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
            height: 10,
          ),
          Text(
            countryData.countryName,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          Image.asset(
            "assets/flags/${countryData.countryCode.toLowerCase()}.png",
            width: 180,
          ),
        ],
      ),
    );
  }
}
