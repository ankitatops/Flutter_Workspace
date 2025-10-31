import 'package:flutter/material.dart';

class FeedbackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feedback Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FeedbackForm(),
    );
  }
}

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _nameController = TextEditingController();
  final _messageController = TextEditingController();

  String _feedbackType = 'Bug';
  bool _uiChecked = false;
  bool _performanceChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Feedback Form')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),

            SizedBox(height: 16),
            Text('Feedback Type'),
            DropdownButton<String>(
              value: _feedbackType,
              items: ['Bug', 'Feature', 'Other'].map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _feedbackType = value!;
                });
              },
            ),

            SizedBox(height: 16),
            CheckboxListTile(
              title: Text('UI'),
              value: _uiChecked,
              onChanged: (value) {
                setState(() {
                  _uiChecked = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Performance'),
              value: _performanceChecked,
              onChanged: (value) {
                setState(() {
                  _performanceChecked = value!;
                });
              },
            ),

            SizedBox(height: 16),

            TextField(
              controller: _messageController,
              decoration: InputDecoration(labelText: 'Message'),
              maxLines: 4,
            ),

            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  String topics = '';
                  if (_uiChecked) topics += 'UI ';
                  if (_performanceChecked) topics += 'Performance';

                  String summary =
                      'Name: ${_nameController.text}\nType: $_feedbackType\nTopics: $topics\nMessage: ${_messageController.text}';

                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Feedback Submitted'),
                      content: Text(summary),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        )
                      ],
                    ),
                  );

                  _nameController.clear();
                  _messageController.clear();
                  setState(() {
                    _feedbackType = 'Bug';
                    _uiChecked = false;
                    _performanceChecked = false;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
