import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // main part
  double a = 0.0;
  String distale = "";
  double b = 0.0;
  double ans = 0.0;
  int opp = 0;
  bool k = false;
  int count = -1;
  // for numbers
  void numbers(double c, String add) {
    if (k) {
      if (opp == 0) {
        setState(() {
          num s = c * pow(10, count--);
          a += s.toDouble();
          distale += add;
        });
      } else {
        setState(() {
          num s = c * pow(10, count--);
          b += s.toDouble();
          distale += add;
        });
      }
    } else {
      if (opp == 0) {
        setState(() {
          a *= 10;
          a += c;
          distale += add;
        });
      } else {
        setState(() {
          b *= 10;
          b += c;
          distale += add;
        });
      }
    }
  }

  // for operators
  void operation(int x, String add) {
    if (opp != 0) {
      setState(() {
        show();
        a = ans;
        ans = 0;
        opp = x;
        distale = "";
        distale += a.toString();
        distale += add;
        k = false;
      });
      return;
    }
    setState(() {
      opp = x;
      distale += add;
      k = false;
    });
  }

  //display result and clear the data
  void show() {
    k = true;
    if (opp == 1) {
      setState(() {
        ans = a + b;
      });
    }
    if (opp == 2) {
      setState(() {
        ans = a - b;
      });
    }
    if (opp == 3) {
      setState(() {
        ans = a * b;
      });
    }
    if (opp == 4) {
      setState(() {
        ans = a / b;
      });
    }
    if (opp == 5) {
      setState(() {
        num d = pow(a, b);
        ans = d.toDouble();
      });
    }
    setState(() {
      a = ans;
      b = 0;
      opp = 0;
    });
  }

  // clear all
  void clearall() {
    setState(() {
      a = 0;
      b = 0;
      opp = 0;
      ans = 0;
      distale = "";
      k = false;
    });
  }

  //decimal yes or no
  void devimal() {
    if (k == false) distale += '.';
    k = true;
  }

  // for del
  void del() {
    if (distale[distale.length - 1] == "+" ||
        distale[distale.length - 1] == "-" ||
        distale[distale.length - 1] == "*" ||
        distale[distale.length - 1] == "/" ||
        distale[distale.length - 1] == "^") {
      setState(() {
        opp = 0;
        distale = distale.substring(0, distale.length - 1);
      });
    }
    if (opp == 0) {
      setState(() {
        double k = a % 10;
        a -= k;
        a /= 10;
        distale = distale.substring(0, distale.length - 1);
      });
    } else {
      setState(() {
        double k = b % 10;
        b -= k;
        b /= 10;
        distale = distale.substring(0, distale.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'CALCULATOR',
          style: TextStyle(
            color: Colors.pink,
            fontWeight: FontWeight.bold,
            fontSize: 36.0,
          ),
        )),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        color: Color.fromARGB(255, 46, 43, 43),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30.0,
              ),
              PhysicalModel(
                color: Colors.black,
                elevation: 8,
                shadowColor: Colors.black,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            distale,
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink,
                              backgroundColor: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            (ans == 0) ? "" : "${ans.toStringAsPrecision(5)}",
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                              backgroundColor: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  width: double.infinity,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              PhysicalModel(
                color: Colors.black,
                elevation: 8,
                shadowColor: Colors.black,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  clearall();
                                },
                                child: Text(
                                  'C',
                                  style: TextStyle(color: Colors.pink),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(color: Colors.deepPurple)),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  operation(5, "^");
                                },
                                child: Text(
                                  '^',
                                  style: TextStyle(color: Colors.pink),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(color: Colors.deepPurple)),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  del();
                                },
                                child: Text(
                                  'del',
                                  style: TextStyle(color: Colors.pink),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(color: Colors.deepPurple)),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  operation(4, "/");
                                },
                                child: Text(
                                  '/',
                                  style: TextStyle(color: Colors.pink),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(color: Colors.deepPurple)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  numbers(7.0, "7");
                                },
                                child: Text(
                                  '7',
                                  style: TextStyle(color: Colors.pink),
                                ),
                                shape: StadiumBorder(
                                    side: BorderSide(color: Colors.deepPurple)),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  numbers(8.0, "8");
                                },
                                child: Text(
                                  '8',
                                  style: TextStyle(color: Colors.pink),
                                ),
                                shape: StadiumBorder(
                                    side: BorderSide(color: Colors.deepPurple)),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  numbers(9.0, "9");
                                },
                                child: Text(
                                  '9',
                                  style: TextStyle(color: Colors.pink),
                                ),
                                shape: StadiumBorder(
                                    side: BorderSide(color: Colors.deepPurple)),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  operation(1, "+");
                                },
                                child: Text(
                                  '+',
                                  style: TextStyle(color: Colors.pink),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(color: Colors.deepPurple)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  numbers(4.0, "4");
                                },
                                child: Text(
                                  '4',
                                  style: TextStyle(color: Colors.pink),
                                ),
                                shape: StadiumBorder(
                                    side: BorderSide(color: Colors.deepPurple)),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  numbers(5.0, "5");
                                },
                                child: Text(
                                  '5',
                                  style: TextStyle(color: Colors.pink),
                                ),
                                shape: StadiumBorder(
                                    side: BorderSide(color: Colors.deepPurple)),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  numbers(6.0, "6");
                                },
                                child: Text(
                                  '6',
                                  style: TextStyle(color: Colors.pink),
                                ),
                                shape: StadiumBorder(
                                    side: BorderSide(color: Colors.deepPurple)),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  operation(2, "-");
                                },
                                child: Text(
                                  '-',
                                  style: TextStyle(color: Colors.pink),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(color: Colors.deepPurple)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  numbers(1.0, "1");
                                },
                                child: Text(
                                  '1',
                                  style: TextStyle(color: Colors.pink),
                                ),
                                shape: StadiumBorder(
                                    side: BorderSide(color: Colors.deepPurple)),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  numbers(2.0, "2");
                                },
                                child: Text(
                                  '2',
                                  style: TextStyle(color: Colors.pink),
                                ),
                                shape: StadiumBorder(
                                    side: BorderSide(color: Colors.deepPurple)),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  numbers(3.0, "3");
                                },
                                child: Text(
                                  '3',
                                  style: TextStyle(color: Colors.pink),
                                ),
                                shape: StadiumBorder(
                                    side: BorderSide(color: Colors.deepPurple)),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  operation(3, "*");
                                },
                                child: Text(
                                  '*',
                                  style: TextStyle(color: Colors.pink),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(color: Colors.deepPurple)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  devimal();
                                },
                                child: Text(
                                  '.',
                                  style: TextStyle(color: Colors.pink),
                                ),
                                shape: StadiumBorder(
                                    side: BorderSide(color: Colors.deepPurple)),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  numbers(0.0, "0");
                                },
                                child: Text(
                                  '0',
                                  style: TextStyle(color: Colors.pink),
                                ),
                                shape: StadiumBorder(
                                    side: BorderSide(color: Colors.deepPurple)),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  numbers(0, "0");
                                  numbers(0, "0");
                                },
                                child: Text(
                                  'X100',
                                  style: TextStyle(color: Colors.pink),
                                ),
                                shape: StadiumBorder(
                                    side: BorderSide(color: Colors.deepPurple)),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  show();
                                },
                                child: Text(
                                  '=',
                                  style: TextStyle(color: Colors.pink),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(color: Colors.deepPurple)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
