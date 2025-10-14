import 'dart:convert';
import 'dart:io';

Future<String> loadFixtureString(String path) async {
  final file = File(path);
  return file.readAsString();
}

Future<Map<String, dynamic>> loadFixtureJson(String path) async {
  final raw = await loadFixtureString(path);
  return jsonDecode(raw) as Map<String, dynamic>;
}
