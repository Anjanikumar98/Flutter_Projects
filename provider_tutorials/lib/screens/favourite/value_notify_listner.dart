import 'package:flutter/material.dart';

class ValueNotifyListnerScreen extends StatefulWidget {
  const ValueNotifyListnerScreen({super.key});

  @override
  State<ValueNotifyListnerScreen> createState() =>
      _ValueNotifyListnerScreenState();
}

class _ValueNotifyListnerScreenState extends State<ValueNotifyListnerScreen> {
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  final ValueNotifier<bool> toggle = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anjanikumar'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ValueListenableBuilder(
              valueListenable: toggle,
              builder: (context, value, child){
                return TextFormField(
                  obscureText: toggle.value,
                  decoration: InputDecoration(
                      hintText: 'password',
                      suffixIcon: InkWell(
                          onTap: () {
                            toggle.value = !toggle.value;
                          },
                          child: Icon(toggle.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility))),
                );
              }),
          Center(
            child: ValueListenableBuilder<int>(
              valueListenable: _counter,
              builder: (context, value, child) {
                return Text(
                  'Counter: $value',
                  style: const TextStyle(fontSize: 50),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _counter.value++;
          print(_counter.value.toString());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _counter.dispose(); // Dispose of ValueNotifier to free resources.
    super.dispose();
  }
}
