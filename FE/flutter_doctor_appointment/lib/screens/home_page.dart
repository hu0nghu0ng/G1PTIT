import 'package:flutter/material.dart';
import 'package:flutter_doctor_appointment/models/auth_model.dart';
import 'package:flutter_doctor_appointment/utils/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Map<String, dynamic> user = {};

  @override
  Widget build(BuildContext context) {

    Config().init(context);

    user = Provider.of<AuthModel>(context).getUser;

    List<Map<String, dynamic>> medCat = [
    {
      "icon": FontAwesomeIcons.userDoctor,
      "category": "General",
    },
    {
      "icon": FontAwesomeIcons.heartPulse,
      "category": "Cardiology",
    },
    {
      "icon": FontAwesomeIcons.lungs,
      "category": "Respirations",
    },
    {
      "icon": FontAwesomeIcons.hand,
      "category": "Dermatology",
    },
    {
      "icon": FontAwesomeIcons.personPregnant,
      "category": "Gynecology",
    },
    {
      "icon": FontAwesomeIcons.teeth,
      "category": "Dental",
    },
  ];

    return Scaffold(
      body: user.isEmpty ? const Center(child: CircularProgressIndicator(),)
        : Padding(
          padding: const EdgeInsets.all(15),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        user['userName'],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4fcUTsLhmCTsIjdTOR8CS5lRZvmqphNq7aw&usqp=CAU'
                        ),
                      )
                    ],
                  ),
                  Config.spaceSmall,
                  const Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Config.spaceSmall,
                  SizedBox(
                    height: Config.heightSize * 0.05,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: 
                        List<Widget>.generate(medCat.length, (index) {
                          return Card(
                            margin: const EdgeInsets.only(right: 20),
                            color: Config.primaryColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 15
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  FaIcon(
                                    medCat[index]['icon'],
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    medCat[index]['category'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        })
                    ),
                  ),
                  Config.spaceSmall,
                ],
              ),
            )
          ),
        ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    super.key,
    required this.date,
    required this.day,
    required this.time
  });

  final String date, day, time;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10)
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.calendar_today,
            color: Config.primaryColor,
            size: 15,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            '$day, $date',
            style: const TextStyle(
              color: Config.primaryColor,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          const Icon(
            Icons.access_alarm,
            color: Config.primaryColor,
            size: 17,
          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
            child: Text(
              time,
              style: const TextStyle(
                color: Config.primaryColor
              ),
            )
          )
        ],
      ),
    );
  }
}