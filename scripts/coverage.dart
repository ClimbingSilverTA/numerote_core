#!/usr/bin/env dart

import 'dart:io';

Future<void> main() async {
  await Process.run('fvm', ['flutter', 'test', '--coverage']);
  await Process.run('genhtml', ['coverage/lcov.info', '-o', 'coverage/html']);
}
