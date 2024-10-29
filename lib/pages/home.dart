import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app_by_webadib/pages/service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool Mathematics = true,
      Sciencenature = false,
      General = false,
      Toysgames = false,
      Peopleplaces = false,
      answernow = false;

  String? question, answer;
  List<String> option = [];

  @override
  void initState() {
    super.initState();
    fetchQuiz("General");
    RestOption();
  }

  Future<void> fetchQuiz(String category) async {
    final response = await http.get(
      Uri.parse("https://api.api-ninjas.com/v1/trivia?category=$category"),
      headers: {'Content-Type': 'application/json', 'X-Api-Key': API_KEY},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      if (jsonData.isNotEmpty) {
        Map<String, dynamic> quiz = jsonData[0];
        question = quiz['question'];
        answer = quiz['answer'];
      }
      setState(() {});
    }
  }

  Future<void> RestOption() async {
    final response = await http.get(
      Uri.parse("https://api.api-ninjas.com/v1/randomword"),
      headers: {'Content-Type': 'application/json', 'X-Api-Key': API_KEY},
    );
    int randomIndex = Random().nextInt(4);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      if (jsonData.isNotEmpty) {
        String word = jsonData["word"].toString();
        option.add(word);
      }
      if (option.length < 4) {
        RestOption();
      }
      if (option.length == 4 && answer != null) {
        option[randomIndex] = answer!;
      } else {
        shuffleList();
      }
      print(option);
      setState(() {});
    }
  }

  void shuffleList() {
    option = List.from(option)..shuffle(Random());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: option.length != 4
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      "images/background.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50.0, left: 20),
                    child: Column(
                      children: [
                        Container(
                          height: 50.0,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Mathematics
                                  ? Container(
                                      margin: EdgeInsets.only(right: 20.0),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(30),
                                        elevation: 5.0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.deepOrangeAccent,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20.0, left: 20),
                                            child: Center(
                                              child: Text(
                                                "Mathematics",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () async {
                                        Mathematics = true;
                                        Sciencenature = false;
                                        General = false;
                                        Toysgames = false;
                                        Peopleplaces = false;
                                        option = [];
                                        await RestOption();
                                        await fetchQuiz("mathematics");
                                        setState(() {});
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 20.0),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20.0, left: 20),
                                          child: Center(
                                            child: Text(
                                              "Mathematics",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                              Sciencenature
                                  ? Container(
                                      margin: EdgeInsets.only(right: 20.0),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(30),
                                        elevation: 5.0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.deepOrangeAccent,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20.0, left: 20),
                                            child: Center(
                                              child: Text(
                                                "Sciencenature",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () async {
                                        Mathematics = false;
                                        Sciencenature = true;
                                        General = false;
                                        Toysgames = false;
                                        Peopleplaces = false;
                                        option = [];
                                        await RestOption();
                                        await fetchQuiz("sciencenature");
                                        setState(() {});
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 20.0),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20.0, left: 20),
                                          child: Center(
                                            child: Text(
                                              "Sciencenature",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                              General
                                  ? Container(
                                      margin: EdgeInsets.only(right: 20.0),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(30),
                                        elevation: 5.0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.deepOrangeAccent,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20.0, left: 20),
                                            child: Center(
                                              child: Text(
                                                "General",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () async {
                                        Mathematics = false;
                                        Sciencenature = false;
                                        General = true;
                                        Toysgames = false;
                                        Peopleplaces = false;
                                        option = [];
                                        await RestOption();
                                        await fetchQuiz("general");
                                        setState(() {});
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 20.0),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20.0, left: 20),
                                          child: Center(
                                            child: Text(
                                              "General",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                              Toysgames
                                  ? Container(
                                      margin: EdgeInsets.only(right: 20.0),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(30),
                                        elevation: 5.0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.deepOrangeAccent,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20.0, left: 20),
                                            child: Center(
                                              child: Text(
                                                "Toysgames",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () async {
                                        Mathematics = false;
                                        Sciencenature = false;
                                        General = false;
                                        Toysgames = true;
                                        Peopleplaces = false;
                                        option = [];
                                        await RestOption();
                                        await fetchQuiz("toysgames");
                                        setState(() {});
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 20.0),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20.0, left: 20),
                                          child: Center(
                                            child: Text(
                                              "Toysgames",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                              Peopleplaces
                                  ? Container(
                                      margin: EdgeInsets.only(right: 20.0),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(30),
                                        elevation: 5.0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.deepOrangeAccent,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20.0, left: 20),
                                            child: Center(
                                              child: Text(
                                                "Peopleplaces",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () async {
                                        Mathematics = false;
                                        Sciencenature = false;
                                        General = false;
                                        Toysgames = false;
                                        Peopleplaces = true;
                                        option = [];
                                        await RestOption();
                                        await fetchQuiz("peopleplaces");
                                        setState(() {});
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 20.0),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20.0, left: 20),
                                          child: Center(
                                            child: Text(
                                              "Peopleplaces",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(right: 20),
                          // height: MediaQuery.of(context).size.height / 2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 20.0),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  question!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 30.0),
                              GestureDetector(
                                onTap: () {
                                  answernow = true;
                                  setState(() {});
                                },
                                child: Container(
                                  height: 50,
                                  margin:
                                      EdgeInsets.only(right: 20.0, left: 20.0),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: answernow
                                              ? answer ==
                                                      option[0].replaceAll(
                                                          RegExp(r'[\[\]]'), "")
                                                  ? Colors.green
                                                  : Colors.red
                                              : Colors.black45,
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Center(
                                    child: Text(
                                      option[0]
                                          .replaceAll(RegExp(r'[\[\]]'), ""),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              GestureDetector(
                                onTap: () {
                                  answernow = true;
                                  setState(() {});
                                },
                                child: Container(
                                  height: 50,
                                  margin:
                                      EdgeInsets.only(right: 20.0, left: 20.0),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: answernow
                                              ? answer ==
                                                      option[1].replaceAll(
                                                          RegExp(r'[\[\]]'), "")
                                                  ? Colors.green
                                                  : Colors.red
                                              : Colors.black45,
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Center(
                                    child: Text(
                                      option[1]
                                          .replaceAll(RegExp(r'[\[\]]'), ""),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              GestureDetector(
                                onTap: () {
                                  answernow = true;
                                  setState(() {});
                                },
                                child: Container(
                                  height: 50,
                                  margin:
                                      EdgeInsets.only(right: 20.0, left: 20.0),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: answernow
                                              ? answer ==
                                                      option[2].replaceAll(
                                                          RegExp(r'[\[\]]'), "")
                                                  ? Colors.green
                                                  : Colors.red
                                              : Colors.black45,
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Center(
                                    child: Text(
                                      option[2]
                                          .replaceAll(RegExp(r'[\[\]]'), ""),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              GestureDetector(
                                onTap: () {
                                  answernow = true;
                                  setState(() {});
                                },
                                child: Container(
                                  height: 50,
                                  margin:
                                      EdgeInsets.only(right: 20.0, left: 20.0),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: answernow
                                              ? answer ==
                                                      option[3].replaceAll(
                                                          RegExp(r'[\[\]]'), "")
                                                  ? Colors.green
                                                  : Colors.red
                                              : Colors.black45,
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Center(
                                    child: Text(
                                      option[3]
                                          .replaceAll(RegExp(r'[\[\]]'), ""),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
