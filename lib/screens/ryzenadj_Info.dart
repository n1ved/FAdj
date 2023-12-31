import 'package:flutter/material.dart';
import 'package:process_run/process_run.dart';

class RyzenAdjInfo extends StatefulWidget {
  const RyzenAdjInfo({super.key});

  @override
  State<RyzenAdjInfo> createState() => _RyzenAdjInfoState();
}

class _RyzenAdjInfoState extends State<RyzenAdjInfo> {
  late var ryzenAdjInfo = "press refresh";
  @override
  void initState() {
    super.initState();
    getInfo();
  }

  Future<void> getInfo() async {
    var shell = Shell();
    await shell
        .run("ryzenadj -i")
        .then((value) => ryzenAdjInfo = value.outText);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ryzenadj -i",
            style: TextStyle(fontFamily: 'monospace')),
      ),
      body: Column(
        children: [
          Expanded(
            child: Text(
              ryzenAdjInfo,
              style: const TextStyle(
                fontFamily: 'monospace',
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            getInfo();
          });
        },
        tooltip: "Refresh",
        enableFeedback: true,
        label: const Text("Refresh"),
        icon: const Icon(Icons.refresh),
      ),
    );
  }
}
