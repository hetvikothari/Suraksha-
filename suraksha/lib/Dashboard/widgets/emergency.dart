import 'package:flutter/material.dart';

class Emergency extends StatelessWidget {
  const Emergency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: const [
          EmergencyCard(
              imageName: "assets/icons/alert.png",
              title: "Active Emergency",
              description: "Call 0-1-5 for emergencies.",
              number: "0 -1 -5",
              callNum: "15"),
          EmergencyCard(
              imageName: "assets/ambulance.png",
              title: "Ambulance",
              description: "Any medical emergency",
              number: "1 -1 -2 -2",
              callNum: "1122"),
          EmergencyCard(
              imageName: "assets/icons/alert.png",
              title: "Fire Brigade",
              description: "any Fire emergencies",
              number: "0 -1 -6",
              callNum: "16"),
          EmergencyCard(
              imageName: "assets/army.png",
              title: "NACTA",
              description: "National Counter Terrorism Authority",
              number: "1 -7 -1 -7",
              callNum: "1717"),
        ],
      ),
    );
  }
}

class EmergencyCard extends StatelessWidget {
  final String imageName;
  final String title;
  final String description;
  final String number;
  final String callNum;

  const EmergencyCard(
      {Key? key,
      required this.imageName,
      required this.description,
      required this.number,
      required this.title,
      required this.callNum})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10.0, bottom: 5),
        child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
                onTap: () {},
                child: Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromRGBO(143, 148, 251, 1),
                          Color.fromRGBO(143, 148, 251, .6)
                        ],
                      ),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                  backgroundColor:
                                      Colors.white.withOpacity(0.5),
                                  radius: 25,
                                  child: Center(
                                      child:
                                          Image.asset(imageName, height: 35))),
                              Text(title,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24)),
                              Text(
                                description,
                                style: const TextStyle(color: Colors.white),
                              ),
                              Expanded(
                                  child: Container(
                                      height: 30,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(300)),
                                      child: Center(
                                          child: Text(number,
                                              style: TextStyle(
                                                  color: Colors.red[300],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18)))))
                            ]))))));
  }
}
