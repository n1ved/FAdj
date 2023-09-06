import 'dart:async';

import 'package:flutter/material.dart';
import 'package:process_run/process_run.dart';
import 'package:ryzenadj_fluttter/default_controll_values.dart';
import '../components/settings_input_box.dart';
import '../components/status_text.dart';

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

  var acpi_temp;
  Timer? timer;

  void getAcpi() {
    var shell = Shell(verbose: false);
    shell.run('acpi -t').then((value) => acpi_temp = value.outText);
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      shell.run('acpi -t').then((value) => acpi_temp = value.outText);
      setState(() {});
    });
  }

  @override
  void initState() {
    getAcpi();
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
                    const StatusText(headline: "Clock Speed", value: "WIP"),
                    const StatusText(headline: "Utilization", value: "WIP"),
                    StatusText(
                        headline: "Temperature",
                        value: sortString(value: acpi_temp ?? ". . . -1")),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SettingsInputBox(
                      inputController: _tctlTemp,
                      id: 'tctl',
                      inputIcon: Icons.thermostat,
                      labelText: "Temperature Limit",
                    ),
                    SettingsInputBox(
                      inputController: _stapmLimit,
                      id: 'stapm',
                      inputIcon: Icons.computer,
                      labelText: "CPU TDP",
                    ),
                    SettingsInputBox(
                      inputController: _fastLimit,
                      id: 'fast',
                      inputIcon: Icons.computer,
                      labelText: "CPU FAST TDP",
                    ),
                    SettingsInputBox(
                      inputController: _slowLimit,
                      id: 'slow',
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          var shell = Shell();
          await shell.run(
              "ryzenadj --tctl-temp=${CntrlValues.tctl.toString()} --stapm-limit=${CntrlValues.stapm.toString()} --fast-limit=${CntrlValues.fast.toString()} --slow-limit=${CntrlValues.slow.toString()}");
        },
        icon: const Icon(Icons.settings_suggest),
        label: const Text("Apply Settings"),
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

String sortString({required value}) {
  var words = value.split(' ');
  return words[3];
}
