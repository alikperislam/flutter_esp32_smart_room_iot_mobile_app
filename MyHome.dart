import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

Container gostergeSicaklik() {
  return Container(
    width: 330,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
    ),
    child: SfRadialGauge(axes: <RadialAxis>[
      RadialAxis(minimum: -30, maximum: 80, ranges: <GaugeRange>[
        GaugeRange(startValue: -30, endValue: 18, color: Colors.blue),
        GaugeRange(startValue: 18, endValue: 30, color: Colors.lightGreen),
        GaugeRange(startValue: 30, endValue: 45, color: Colors.orange),
        GaugeRange(startValue: 45, endValue: 80, color: Colors.red),
      ], pointers: <GaugePointer>[
        NeedlePointer(value: c)
      ], annotations: <GaugeAnnotation>[
        GaugeAnnotation(
            widget: Container(
                child: Text("°C",
                    style: TextStyle(
                        color: tema ? Color(0xFFEB5556) : Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold))),
            angle: 90,
            positionFactor: 0.8)
      ])
    ]),
  );
}

Widget gostergeNem() {
  return Container(
    width: 330,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
    ),
    child: SfRadialGauge(axes: <RadialAxis>[
      RadialAxis(minimum: 0, maximum: 100, ranges: <GaugeRange>[
        GaugeRange(startValue: 0, endValue: 30, color: Colors.blue[100]),
        GaugeRange(startValue: 30, endValue: 50, color: Colors.blue[300]),
        GaugeRange(startValue: 50, endValue: 75, color: Colors.blue[500]),
        GaugeRange(startValue: 75, endValue: 100, color: Colors.blue[900]),
      ], pointers: <GaugePointer>[
        NeedlePointer(value: nem)
      ], annotations: <GaugeAnnotation>[
        GaugeAnnotation(
            widget: Container(
                child: Text("Nem",
                    style: TextStyle(
                        color: tema ? Color(0xFFEB5556) : Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold))),
            angle: 90,
            positionFactor: 0.8)
      ])
    ]),
  );
}

Widget gostergeBatarya() {
  return Container(
    width: 330,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
    ),
    child: SfRadialGauge(axes: <RadialAxis>[
      RadialAxis(minimum: -22, maximum: 176, ranges: <GaugeRange>[
        GaugeRange(startValue: -22, endValue: 64.4, color: Colors.blue),
        GaugeRange(startValue: 64.4, endValue: 86, color: Colors.lightGreen),
        GaugeRange(startValue: 86, endValue: 113, color: Colors.orange),
        GaugeRange(startValue: 113, endValue: 176, color: Colors.red),
      ], pointers: <GaugePointer>[
        NeedlePointer(value: f)
      ], annotations: <GaugeAnnotation>[
        GaugeAnnotation(
            widget: Container(
                child: Text("°F",
                    style: TextStyle(
                        color: tema ? Color(0xFFEB5556) : Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold))),
            angle: 90,
            positionFactor: 0.8)
      ])
    ]),
  );
}

Widget gostergeIsik() {
  return Container(
    width: 330,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
    ),
    child: SfRadialGauge(axes: <RadialAxis>[
      RadialAxis(minimum: 0, maximum: 100, ranges: <GaugeRange>[
        GaugeRange(startValue: 0, endValue: 10, color: Colors.yellow[100]),
        GaugeRange(startValue: 10, endValue: 20, color: Colors.yellow[200]),
        GaugeRange(startValue: 20, endValue: 30, color: Colors.yellow[300]),
        GaugeRange(startValue: 30, endValue: 40, color: Colors.yellow[400]),
        GaugeRange(startValue: 40, endValue: 50, color: Colors.yellow[500]),
        GaugeRange(startValue: 50, endValue: 60, color: Colors.yellow[600]),
        GaugeRange(startValue: 60, endValue: 70, color: Colors.yellow[700]),
        GaugeRange(startValue: 70, endValue: 80, color: Colors.yellow[800]),
        GaugeRange(startValue: 80, endValue: 100, color: Colors.yellow[900]),
      ], pointers: <GaugePointer>[
        NeedlePointer(value: isik)
      ], annotations: <GaugeAnnotation>[
        GaugeAnnotation(
            widget: Container(
                child: Text("Işık",
                    style: TextStyle(
                        color: tema ? Color(0xFFEB5556) : Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold))),
            angle: 90,
            positionFactor: 0.8)
      ])
    ]),
  );
}

//tanimlamalar
double nem = 0;
double c = 0;
double f = 0;
double isik = 0;
bool tema = false; // true - acik tema
List<String> parserData = []; //isik, nem, sicaklik C, sicaklik F, tema
String veriler = "";

int isikInt = 0, nemInt = 0, cInt = 0, fInt = 0;

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late DatabaseReference ref = FirebaseDatabase.instance.ref("Veriler/veri");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: ref.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.hasError) {
            veriler = snapshot.data!.snapshot.value.toString();
            parserData = veriler.split('/');

            isik = double.parse(parserData[0]);
            nem = double.parse(parserData[1]);
            c = double.parse(parserData[2]);
            f = double.parse(parserData[3]);
            tema = (int.parse(parserData[4]) == 0) ? false : true;

            isikInt = isik.toInt();
            nemInt = nem.toInt();
            fInt = f.toInt();
            cInt = c.toInt();
          } else {}
          return _body();
        },
      ),
    );
  }

  // 0 - appbarColor, 1 - cardColor, 2 - bgColor, 3 - titleColor, 4 - grafTitleColor, 5 - shadowColor
  List<Color> acikTema = [
    Color(0xFFEB5556),
    Color(0xFFEB5556),
    Color(0xFFFAFAFA),
    Color(0xFFeeeded),
    Color(0xFFEB5556),
    Colors.grey,
  ];
  // 0 - appbarColor, 1 - cardColor, 2 - bgColor, 3 - titleColor, 4 - grafTitleColor, 5 - shadowColor
  List<Color> koyuTema = [
    Color(0xFF404040),
    Color(0xFF404040),
    Color(0xFF282828),
    Color(0xFFB8B8B8),
    Colors.white,
    Colors.black,
  ];

  Widget _body() {
    return Container(
      color: tema ? Color(0xFFFAFAFA) : Color(0xFF282828),
      child: Column(
        children: [
          _appbar(),
          // row (sicaklik cont - nem cont)
          top_cards(),
          // row (basinc cont - isik cont)
          bottom_cards(),
          // grafik
          carousel_charts(),
        ],
      ),
    );
  }

  Widget _appbar() {
    return Container(
      height: 120,
      width: double.infinity,
      color: tema ? acikTema[0] : koyuTema[0],
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Text(
            "Smart Room",
            style: TextStyle(fontSize: 23, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget carousel_charts() {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: CarouselSlider(
          items: [
            gostergeSicaklik(),
            gostergeNem(),
            gostergeBatarya(),
            gostergeIsik(),
          ].map((item) => item).toList(),
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 1.7,
            enlargeCenterPage: true,
          )),
    );
  }

  Widget top_cards() {
    return Padding(
      padding: EdgeInsets.only(top: 45),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _card(0),
          _card(1),
        ],
      ),
    );
  }

  Widget bottom_cards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _card(2),
        _card(3),
      ],
    );
  }

  Widget _card(int indeks) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          color: tema ? acikTema[1] : koyuTema[1],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: tema
                  ? Colors.grey.withOpacity(0.7)
                  : Colors.black.withOpacity(0.7),
              spreadRadius: 1,
              blurRadius: 6,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: _cardData(indeks),
      ),
    );
  }

  List<Icon> iconList = [
    Icon(
      FontAwesome.temperature_full,
      size: 35,
      color: Color.fromARGB(255, 237, 237, 237),
    ),
    Icon(
      LineAwesome.temperature_high_solid,
      size: 40,
      color: Color.fromARGB(255, 237, 237, 237),
    ),
    Icon(
      FontAwesome.temperature_half,
      size: 35,
      color: Color.fromARGB(255, 237, 237, 237),
    ),
    Icon(
      FontAwesome.lightbulb,
      size: 35,
      color: Color.fromARGB(255, 237, 237, 237),
    ),
  ];

  List<String> titles = [
    "Sıcaklık °C",
    "Nem",
    "Sıcaklık °F",
    "Işık",
  ];

  Widget _cardData(int indeks) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //icon
        iconList[indeks],
        //veriler
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // title
            Text(
              titles[indeks],
              style: TextStyle(
                color: tema ? acikTema[3] : koyuTema[3],
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            // data
            if (indeks == 0) ...[
              Text(
                "$c°C",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ] else if (indeks == 1) ...[
              Text(
                "%$nemInt",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ] else if (indeks == 2) ...[
              Text(
                "$fInt°F",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ] else if (indeks == 3) ...[
              Text(
                "%$isikInt",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ]
          ],
        )
      ],
    );
  }
}
