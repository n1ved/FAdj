import 'dart:convert';

import 'package:process_run/process_run.dart';

class CpuInfo {
  dynamic _lscpuOut;
  dynamic _lscpuParsed;

  CpuInfo();

  void loadInfo() async {
    var shell = Shell(verbose: false);
    await shell.run('lscpu -J').then((value) => _lscpuOut = value.outText);
    _lscpuParsed = jsonDecode(_lscpuOut);
  }

  String getCpuName() {
    return _lscpuParsed['lscpu'][8]['data'];
  }
}
