import 'package:flutter/material.dart';
import '../bloc/triggerLogicBloc.dart';
import '../event/just_data_event.dart';
import '../ui_component/imageCard.dart';



class TriggerLogicTab extends StatefulWidget {

  @override
  _TriggerLogicTabState createState() => _TriggerLogicTabState();
}

class _TriggerLogicTabState extends State<TriggerLogicTab> {
  @override
  void initState()
  {
    super.initState();
    myName = 'Bruce Wayne';
    myImagePath = 'https://cdn.vectorstock.com/i/1000v/92/05/panda-cartoon-cute-animals-vector-39469205.jpg';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 45),
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                imageCard("https://media.gettyimages.com/id/1422276740/vector/software-developer-flat-design.jpg?s=612x612&w=gi&k=20&c=nAeiHldWvLHV-S4CRv5BsRtwH2PlS7t7Dynol9npglE="),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'It\'s not\nwho I am\nunderneath,\nbut what I do that\ndefines me.\n\nAnyway, I am',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 15),
                    Text(
                      myName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 38,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              setState(() {
                triggerLogicBloc.sinkTriggerLogic(TriggerSwitchId());
              });
            },
            child: Text(
              'Tell Them',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),

          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}