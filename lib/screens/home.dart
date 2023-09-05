import 'package:flutter/material.dart';
import 'package:process_run/process_run.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _tctlTemp = TextEditingController();
  int _tctlTempVal = 90;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          title: const Text("FAdj"),
          actions: [
            TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/info');
              },
              icon: const Icon(Icons.info),
              label: const Text("RyzenAdj Info"),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DataText(headline: "Clock Speed", value: "4.5GHz"),
                    DataText(headline: "Utilization", value: "80%"),
                    DataText(
                        headline: "Temperature",
                        value: _tctlTempVal.toString()),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    TextField(
                      controller: _tctlTemp,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _tctlTempVal = int.parse(value);
                        });
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var shell = Shell();
          await shell.run("ryzenadj --tctl-temp=${_tctlTempVal.toString()}");
        },
        child: Icon(Icons.start),
      ),
    );
  }
}

class DataText extends StatelessWidget {
  DataText({super.key, required this.headline, required this.value});
  String headline;
  String value;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headline,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ],
    );
  }
}
