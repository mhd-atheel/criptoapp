import 'dart:convert';

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:criptoapp/screens/details.dart';
import 'package:criptoapp/services/dataServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class MarketOverView extends StatefulWidget {
  const MarketOverView({super.key});

  @override
  State<MarketOverView> createState() => _MarketOverViewState();
}

class _MarketOverViewState extends State<MarketOverView> {

  final DataServices dataServices = Get.put(DataServices());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Simple Trading App'.toUpperCase()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              if (dataServices.dataList.isEmpty) {
                return const  Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: dataServices.dataList.length,
                  itemBuilder: (context, index) {
                    return listView(
                        dataServices.dataList[index].name,
                        dataServices.dataList[index].subname,
                        dataServices.dataList[index].history,
                        dataServices.dataList[index].image,
                        dataServices.dataList[index].increase,
                        dataServices.dataList[index].price
                    );
                  },
                );
              }
            }),

          ],
        ),
      ),
    );
  }

  listView(name,subName,history,image,increase,price){
    return Slidable(
      endActionPane:  ActionPane(
        motion: const ScrollMotion(),
        dragDismissible: false,
        children: [
          SlidableAction(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,

            label: 'Sell', onPressed: (BuildContext context) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    duration: Duration(seconds: 1),
                    content:Center(
                      child: Text("Sold It",style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                  backgroundColor: Colors.orange,
                )
              );
              },
          ),
          SlidableAction(
            backgroundColor:  Colors.green,
            foregroundColor: Colors.white,
            label: 'Buy', onPressed: (BuildContext context) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(seconds: 1),
                  content:Center(
                    child: Text("Buy It",style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                  backgroundColor: Colors.green,
                )
            );
          },
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0,),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade100,
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: InkWell(
              onTap: (){

                Get.to(
                    Details(
                      name:name,
                      image:image,
                      history:history,
                      subname:subName,
                      increase:increase,
                      price:price,
                    )
                );
              },
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name),
                        Text(
                          subName,
                          style:const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),

                    Center(
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: Sparkline(
                            data: history as List<double>,
                            pointColor: Colors.amber,
                            fallbackHeight: 150,
                            gridLineLabelPrecision: 3,
                            // enableGridLines: true,
                            // useCubicSmoothing: true,
                            cubicSmoothingFactor: 0.2,

                            lineColor:increase.toString().contains('+') ? Colors.green:Colors.red,
                          ),
                        )
                    ),

                  ],
                ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(30),
                    child: CircleAvatar(
                      child: Image.asset(image),
                    ),
                  ),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(price,style: const TextStyle(
                        fontSize: 15,fontWeight: FontWeight.bold,
                      ),),
                      Text('$increase%',style:  TextStyle(
                          fontSize: 10,fontWeight: FontWeight.bold,
                          color: increase.toString().contains('+') ? Colors.green:Colors.red
                      ),)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }



}
