
import 'package:flutter/material.dart';
void main()
{
  runApp(new MaterialApp(home: new CheckBoxEx()));
}


class CheckBoxEx extends StatefulWidget {
  const CheckBoxEx({super.key});

  @override
  State<CheckBoxEx> createState() => _checkBoxEx();
}

class _checkBoxEx extends State<CheckBoxEx>
{
  bool cricket = false;
  bool reading = false;
  bool music = false;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
      (
      appBar: AppBar(title: Text("Checkbox Example"),),
      body: Center
        (
        child: Column
          (
          children:
          [
            CheckboxListTile
              (
                title: Text("Cricket"),
                value: cricket,
                onChanged:(value)
                {
                  setState(()
                  {
                    //cricket = true;
                    this.cricket = value!;
                  });
                }),

            CheckboxListTile
              (
                title: Text("Reading"),
                value: reading,
                onChanged:(value)
                {
                  setState(()
                  {
                    //cricket = true;
                    this.reading = value!;
                  });
                }),

            CheckboxListTile
              (
                title: Text("Music"),
                value: music,
                onChanged:(value)
                {
                  setState(()
                  {
                    //cricket = true;
                    this.music = value!;
                  });
                }),
            ElevatedButton(onPressed: ()
            {
              print("Cricket : $cricket");
              print("Reading : $reading");
              print("Music : $music");

            }, child: Text("Submit")
            )
          ],
        ),
      ),
    );
  }
}
