import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();

  void _incrementCounter() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      _formKey.currentState?.save();
      print(_formKey.currentState.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }
  }

  Widget _textField({
    label,
    onTap,
  }) {
    return Row(
      children: [
        SizedBox(width: 170, child: Text(label)),
        const SizedBox(width: 10),
        Flexible(
          child: TextFormField(
            keyboardType: TextInputType.number,
            onTap: onTap,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '*';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMilkForm() {
    return Form(
      key: _formKey,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _textField(label: '🍼 Daily Milk (L/Kg):'),
            _textField(label: '📏 Milk Rate:'),
            _textField(
                label: '⏰ Milk Notification Time:',
                onTap: () async {
                  TimeOfDay? newTime = await showTimePicker(
                    context: context,
                    initialTime: const TimeOfDay(hour: 7, minute: 15),
                  );
                  print("*****");
                  print(newTime);
                }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                '🐮',
                style: TextStyle(fontSize: 100),
              ),
              const SizedBox(height: 40),
              _buildMilkForm(),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
