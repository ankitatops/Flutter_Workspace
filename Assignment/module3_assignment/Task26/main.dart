import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Infinite Scroll List',
      home: InfiniteListScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class InfiniteListScreen extends StatefulWidget {
  @override
  _InfiniteListScreenState createState() => _InfiniteListScreenState();
}

class _InfiniteListScreenState extends State<InfiniteListScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<int> _items = [];
  bool _isLoading = false;
  int _page = 0;
  final int _limit = 20;
  final int _maxItems = 50;

  @override
  void initState() {
    super.initState();
    _loadMoreItems();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_isLoading &&
          _items.length < _maxItems) {
        _loadMoreItems();
      }
    });
  }

  Future<void> _loadMoreItems() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));

    List<int> newItems = List.generate(
      _limit,
      (index) => _page * _limit + index + 1,
    );

    setState(() {
      _page++;
      _items.addAll(newItems);
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildList() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _items.length + 1,
      itemBuilder: (context, index) {
        if (index == _items.length) {
          if (_items.length >= _maxItems) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(child: Text('No more items')),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        }
        return ListTile(
          leading: CircleAvatar(child: Text('${_items[index]}')),
          title: Text('Item ${_items[index]}'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Infinite Scrolling List')),
      body: _buildList(),
    );
  }
}
