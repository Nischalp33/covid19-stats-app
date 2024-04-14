import 'package:covid_tracker/Model/WorldStatesModel.dart';
import 'package:covid_tracker/Services/states_services.dart';
import 'package:covid_tracker/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shimmer/shimmer.dart';

class WorldStats extends StatefulWidget {
  const WorldStats({Key? key}) : super(key: key);

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();


  @override

  void dispose(){
    super.dispose();
    _controller.dispose();
  }
  final colorList = <Color> [
    Color(0xff4285f4),
    Color(0xff1aa260),
    Color(0xffde5246),

  ];



  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
                             
              ),
              FutureBuilder(
              future: statesServices.fetchWorldStatesRecords(),
                  builder: (context,AsyncSnapshot<WorldStatesModel> snapshot){
                 if(!snapshot.hasData){
                   return Expanded(
                       child:SpinKitFadingCircle(
                         color: Colors.white60,
                         size: 50,
                         controller: _controller,
                       ) );

                 }else{
                   return Column(
                     children: [
                       PieChart(
                         chartValuesOptions: ChartValuesOptions(
                           showChartValuesInPercentage: true
                         ),
                         dataMap: {
                           "Total":double.parse((snapshot.data!.cases!.toString())),
                           "Recovered" :double.parse((snapshot.data!.recovered!.toString())),
                           "Deaths":double.parse((snapshot.data!.deaths!.toString())),
                         },
                         chartRadius: MediaQuery.of(context).size.width / 3.2,
                         legendOptions: LegendOptions(
                             legendPosition: LegendPosition.left
                         ),
                         animationDuration: Duration(milliseconds: 1200) ,
                         chartType: ChartType.ring,
                         colorList: colorList,
                       ),
                       Padding(
                         padding: EdgeInsets.only(left: 10,right: 10, top: 10, bottom: 50),
                         child: Card(
                           child: Column(
                             children: [
                               ReUsableRow(title: 'Total', value: snapshot.data!.cases!.toString()),
                               ReUsableRow(title: 'Recovered', value: snapshot.data!.recovered!.toString()),
                               ReUsableRow(title: 'Deaths', value: snapshot.data!.deaths!.toString()),
                               ReUsableRow(title: 'Active', value: snapshot.data!.active!.toString()),
                               ReUsableRow(title: 'Critical', value: snapshot.data!.critical!.toString()),
                               ReUsableRow(title: 'Today Cases', value: snapshot.data!.todayCases!.toString()),
                               ReUsableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered!.toString()),
                               ReUsableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths!.toString()),


                             ],
                           ),
                         ),
                       ),
                       GestureDetector(
                         onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesList()));
                    },
                         child: Container(
                           height: 50,
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(10),
                               color: Color(0xff1aa268)
                           ),
                           child: Center(
                             child: Text('Track Countries'),
                           ),
                         ),
                       )

                     ],
                   );

                 }
              }),

            ],
          ),
        ),
      )
    );
  }
}

class ReUsableRow extends StatelessWidget {
  String title, value;
  ReUsableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),


            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider()
        ],
      ),
    );
  }
}

