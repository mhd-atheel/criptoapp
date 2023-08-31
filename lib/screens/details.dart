import 'dart:ffi';

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final String name;
  final String image;
  final String subname;
  final String price;
  final String increase;
  final List<dynamic> history;
  const Details({super.key, required this.name, required this.image,
    required this.history, required  this.subname, required this.increase, required  this.price });
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:  Text(widget.name.toUpperCase()),
        actions:[
      ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox.fromSize(
        //size: const Size.fromRadius(20),
        child: CircleAvatar(
          child: Image.asset(widget.image),
        ),
      ),

          ),
          const SizedBox(width: 10,),
        ]
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50,),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width/1.2,
                  height: 250.0,
                  // width: 40,
                  // height: 40,
                  child: Sparkline(
                    data: widget.history as List<double>,
                    pointsMode: PointsMode.all,
                    pointSize: 2.0,
                    pointColor: Colors.amber,
                    fallbackHeight: 150,
                    gridLineLabelPrecision: 3,
                    // enableGridLines: true,
                    // useCubicSmoothing: true,
                    cubicSmoothingFactor: 0.2,
                    lineWidth: 2,
                    kLine: const ['max', 'min', 'first', 'last'],
                    lineColor: Colors.green,
                  )
                ),
              ),
            ),
            SizedBox(height: 20,),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: SizedBox.fromSize(
                          child: CircleAvatar(
                            child: Image.asset(widget.image),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.name),
                          Text(
                            widget.subname,
                            style:const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.price,style: const TextStyle(
                        fontSize: 15,fontWeight: FontWeight.bold,
                      ),),
                      Text('${widget.increase}%',style:  TextStyle(
                          fontSize: 10,fontWeight: FontWeight.bold,
                          color: widget.increase.toString().contains('+') ? Colors.green:Colors.red
                      ),)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
