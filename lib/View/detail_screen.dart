import 'package:covid_tracker/View/world_states.dart';
import 'package:flutter/material.dart';


class DetaliScreen extends StatefulWidget {
  String image;
  String name;
  int totalCases, totalDeaths, totalRecovered, active,critical,todayRecovered, test;
  DetaliScreen({Key? key, required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,

  }) : super(key: key);

  @override
  State<DetaliScreen> createState() => _DetaliScreenState();
}

class _DetaliScreenState extends State<DetaliScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    title: Text(widget.name),
    ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,

            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                          height:MediaQuery.of(context).size.height * .06
                      ),
                      ReUsableRow(title: 'Cases', value: widget.totalCases.toString()),
                      ReUsableRow(title: 'Total Recovered', value: widget.totalRecovered.toString()),
                      ReUsableRow(title: 'Active', value: widget.active.toString()),
                      ReUsableRow(title: 'Critical', value: widget.critical.toString()),
                      ReUsableRow(title: 'Deaths', value: widget.totalDeaths.toString()),

                      ReUsableRow(title: 'Today Recovered', value: widget.todayRecovered.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )

            ],
          )
        ],
      ),
    );
  }
}
