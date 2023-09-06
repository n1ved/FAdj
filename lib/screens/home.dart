import 'dart:async';

import 'package:flutter/material.dart';
import 'package:process_run/process_run.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _tctlTemp = TextEditingController();
  final TextEditingController _stapmLimit = TextEditingController();
  final TextEditingController _fastLimit = TextEditingController();
  final TextEditingController _slowLimit = TextEditingController();
  int _tctlTempVal = 90;
  int _stapmLimitVal = 45000;
  int _fastLimitVal = 45000;
  int _slowLimitVal = 45000;

  var sensor_tctl;
  Timer? timer;

  Future<String> getTemp() async {
    var shell = Shell(workingDirectory: '/', runInShell: true);
    var result = "0.0";
    await shell
        .run("cat sys/class/thermal/thermal_zone*/temp")
        .then((value) => result = value.outText.toString());
    return result;
  }

  @override
  void initState() {
    super.initState();
  }

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
                    DataText(headline: "Clock Speed", value: "WIP"),
                    DataText(headline: "Utilization", value: "WIP"),
                    DataText(headline: "Temperature", value: "WIP"),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ControllerInputBox(
                      inputController: _tctlTemp,
                      onChanged: () {
                        _tctlTempVal = int.parse(_tctlTemp.value.toString());
                      },
                      inputIcon: Icons.thermostat,
                      labelText: "Temperature Limit",
                    ),
                    ControllerInputBox(
                      inputController: _stapmLimit,
                      onChanged: () {
                        _stapmLimitVal =
                            int.parse(_stapmLimit.value.toString());
                      },
                      inputIcon: Icons.computer,
                      labelText: "CPU TDP",
                    ),
                    ControllerInputBox(
                      inputController: _fastLimit,
                      onChanged: () {
                        _fastLimitVal = int.parse(_fastLimit.value.toString());
                      },
                      inputIcon: Icons.computer,
                      labelText: "CPU FAST TDP",
                    ),
                    ControllerInputBox(
                      inputController: _slowLimit,
                      onChanged: () {
                        _slowLimitVal = int.parse(_slowLimit.value.toString());
                      },
                      inputIcon: Icons.computer,
                      labelText: "CPU SLOW TDP",
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
          await shell.run(
              "ryzenadj --tctl-temp=${_tctlTempVal.toString()} --stapm-limit=${_stapmLimitVal.toString()} --fast-limit=${_fastLimitVal.toString()} --slow-limit=${_slowLimitVal.toString()}");
        },
        child: const Icon(Icons.start),
      ),
    );
  }

  @override
  void dispose() {
    _tctlTemp.dispose();
    _fastLimit.dispose();
    _stapmLimit.dispose();
    _slowLimit.dispose();
    super.dispose();
  }
}

class DataText extends StatefulWidget {
  DataText({super.key, required this.headline, required this.value});
  String headline;
  String value;

  @override
  State<DataText> createState() => _DataTextState();
}

class _DataTextState extends State<DataText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.headline,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        Text(
          widget.value,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ],
    );
  }
}

class ControllerInputBox extends StatefulWidget {
  ControllerInputBox(
      {super.key,
      required this.inputController,
      required this.onChanged,
      required this.inputIcon,
      required this.labelText});

  final TextEditingController inputController;
  final Function() onChanged;
  final IconData inputIcon;
  final String labelText;

  @override
  State<ControllerInputBox> createState() => _ControllerInputBoxState();
}

class _ControllerInputBoxState extends State<ControllerInputBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: TextField(
        controller: widget.inputController,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          setState(() {
            widget.onChanged;
          });
        },
        decoration: InputDecoration(
          labelText: widget.labelText,
          border: const OutlineInputBorder(),
          prefixIcon: Icon(widget.inputIcon),
        ),
      ),
    );
  }
}
