import 'dart:io';

Future<void> main(List<String> arguments) async {
  print('Running style-dictionary with arguments: $arguments');
  // print current script path
  // print(Platform.script.toFilePath());

  final proc = await Process.start(
    'npm',
    [
      '--prefix',
      'packages/commons/ui/design_system',
      'exec',
      'style-dictionary',
      ...arguments,
    ],
    runInShell: true,
    workingDirectory: 'packages/commons/ui/design_system',
    mode: ProcessStartMode.inheritStdio,
  );

  exit(await proc.exitCode);
}
