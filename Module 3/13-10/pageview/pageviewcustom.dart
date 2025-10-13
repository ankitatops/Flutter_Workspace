import 'package:flutter/material.dart';

class PageViewCustom extends StatefulWidget {
  const PageViewCustom({super.key});

  @override
  State<PageViewCustom> createState() => _PageViewCustomState();
}

class _PageViewCustomState extends State<PageViewCustom>
{
  List<String> items = <String>['1', '2', '3', '4', '5','6'];

  void _reverse()
  {
    setState(()
    {
      items = items.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
      (
        appBar: AppBar
          (
          title: Text('PageView Custom'),
          centerTitle: true,
          elevation: 0,
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () => _reverse(),
                child: Text('Reverse item'),
              ),
            ],
          ),
        ),
        body: PageView.custom
          (
          childrenDelegate: SliverChildBuilderDelegate
            ((context, index)
          {
            return KeepAlive
              (

              key: ValueKey<String>(items[index]),
              keepAlive: true,
              child:Text("1234 ${items[index]}"),
            );
            // return Center(
            //   child: Text('Page $index'),
            // );
          },

          ),


        ));
  }
}