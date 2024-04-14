import 'package:covid_tracker/Model/CountryModel.dart';
import 'package:covid_tracker/Services/states_services.dart';
import 'package:covid_tracker/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();

StatesServices statesServices = StatesServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text('Countries'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value){
                setState(() {

                });
              },
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search country name',
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0)
                )
              ),
            ),
          ),
          Expanded(
              child:FutureBuilder(
                future: statesServices.countriesListApi(),
                builder: (context, AsyncSnapshot<List<CountryModel>> snapshot){
                  if(!snapshot.hasData){
                    return ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index){

                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child:  Column(
                              children: [
                                ListTile(
                                  leading: Container(
                                    height: 50, width: 50, color: Colors.white60,
                                  ),
                                  title: Container(
                                    height: 10, width: 89, color: Colors.white60,
                                  ),
                                  subtitle: Container(
                                    height: 10, width: 89, color: Colors.white60,
                                  ),
                                  trailing: Container(
                                    height: 10, width: 89, color: Colors.white60,
                                  ),
                                )

                              ],
                            )) ;


                        });


                  }else{
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                        itemBuilder: (context, index){
                        String name = snapshot.data![index].country.toString();

                      if(searchController.text.isEmpty){
                        return Column(
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>DetaliScreen(name:snapshot.data![index].country.toString(),image: snapshot.data![index].countryInfo!.flag.toString(),
                                    totalCases: snapshot.data![index].cases!.toInt(),
                                  active: snapshot.data![index].active!.toInt(),
                                  test: snapshot.data![index].tests!.toInt(),
                                  todayRecovered: snapshot.data![index].todayRecovered!.toInt(),
                                  totalDeaths: snapshot.data![index].deaths!.toInt(),
                                  critical: snapshot.data![index].critical!.toInt(),
                                  totalRecovered: snapshot.data![index].recovered!.toInt(),

                                )) );

                        },

                              child: ListTile(
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(
                                      snapshot.data![index].countryInfo!.flag.toString()
                                  ),

                                ),
                                title: Text(snapshot.data![index].country.toString() ),
                                subtitle: Text(snapshot.data![index].active.toString()),
                                trailing: Text('Active Cases'),
                              ),
                            )

                          ],
                        );

                      }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                        return Column(
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>DetaliScreen(name:snapshot.data![index].country.toString(),image: snapshot.data![index].countryInfo!.flag.toString(),
                                  totalCases: snapshot.data![index].cases!.toInt(),
                                  active: snapshot.data![index].active!.toInt(),
                                  test: snapshot.data![index].tests!.toInt(),
                                  todayRecovered: snapshot.data![index].todayRecovered!.toInt(),
                                  totalDeaths: snapshot.data![index].deaths!.toInt(),
                                  critical: snapshot.data![index].critical!.toInt(),
                                  totalRecovered: snapshot.data![index].recovered!.toInt(),

                                )) );

                              },
                              child: ListTile(
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(
                                      snapshot.data![index].countryInfo!.flag.toString()
                                  ),

                                ),
                                title: Text(snapshot.data![index].country.toString() ),
                                subtitle: Text(snapshot.data![index].active.toString()),
                                trailing: Text('Active Cases'),
                              ),
                            )

                          ],
                        );

                      }else{
                        return Container(
                        );

                      }


                    });
                  }


                },

              )
          ),


        ],
      ),
    );
  }
}
