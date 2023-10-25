import 'dart:io';

Future<void> main(List<String> arguments) async {
  final proc = await Process.start(
    'npm',
    [
      '--prefix',
      'packages/ds/generator',
      'exec',
      'style-dictionary',
      ...arguments,
    ],
    runInShell: true,
    workingDirectory: 'packages/ds',
    mode: ProcessStartMode.inheritStdio,
  );

  exit(await proc.exitCode);
}
