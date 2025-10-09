import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MaterialApp(home: SwitchScreen()));
}

class SwitchScreen extends StatefulWidget {
  const SwitchScreen({super.key});

  @override
  State<SwitchScreen> createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  bool isSwitch = true;
  var Value = 'Music is ON';
  final player = AudioPlayer();
  bool isSwitched = false;
  var textValue = 'Switch is OFF';

  @override
  void initState() {
    super.initState();
    playMusic();
  }

  Future<void> playMusic() async {
    await player.play(AssetSource('music.mp3'));
  }

  Future<void> stopMusic() async {
    await player.stop();
  }

  void toggleSwitch(bool value) {
    setState(() {
      isSwitched = value;
      if (isSwitched) {
        playMusic();
        textValue = 'Music is ON';
        print('Music is ON');
      } else {
        stopMusic();
        textValue = 'Music is OFF';
        print('Music is OFF');
      }
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 2,
              child: Switch(
                onChanged: toggleSwitch,
                value: isSwitched,
                activeColor: Colors.blue,
                activeTrackColor: Colors.yellow,
                inactiveThumbColor: Colors.redAccent,
                inactiveTrackColor: Colors.orange,
              ),
            ),
            SizedBox(height: 10),
            Text('$textValue', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }

  // toggleSwitch(bool value)
  // {
  //   if(isSwitched == false)
  //   {
  //     setState(() {
  //       isSwitched = true;
  //       textValue = 'Switch Button is ON';
  //     });
  //     print('Switch Button is ON');
  //   }
  //   else
  //   {
  //     setState(() {
  //       isSwitched = false;
  //       textValue = 'Switch Button is OFF';
  //     });
  //     print('Switch Button is OFF');
  //   }
}
