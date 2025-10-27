import 'package:flutter/material.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:provider/provider.dart';
import './device_helper.dart';
import '../app_state.dart';

void setFontFamilyCall(BuildContext context, FunctionCall functionCall) {
  var fontFamily = functionCall.args['fontFamily']! as String;

  if (context.mounted) {
    context.read<AppState>().setFontFamily(fontFamily);
  }

  return;
}

void setFontSizeFactorCall(BuildContext context, FunctionCall functionCall) {
  var fontSizeFactor = functionCall.args['fontSizeFactor']! as num;

  if (context.mounted) {
    context.read<AppState>().setFontSizeFactor(fontSizeFactor.toDouble());
  }

  return;
}

void setAppColorCall(BuildContext context, FunctionCall functionCall) async {
  int red = functionCall.args['red']! as int;
  int green = functionCall.args['green']! as int;
  int blue = functionCall.args['blue']! as int;

  Color newSeedColor = Color.fromRGBO(red, green, blue, 1);

  if (context.mounted) {
    context.read<AppState>().setAppColor(newSeedColor);
  }
}

Future<String> getDeviceInfoCall() async {
  var deviceInfo = await DeviceHelper.getDeviceInfo();
  return 'Device Info: ${deviceInfo.toString()}';
}

Future<String> getBatteryInfoCall() async {
  var batteryInfo = await DeviceHelper.getBatteryInfo();
  return 'Battery Info: ${batteryInfo.toString()}';
}

Color colorFromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

void setPrimaryButtonColorCall(
  BuildContext context,
  FunctionCall functionCall,
) {
  final colorHex = functionCall.args['color']! as String;
  final newColor = colorFromHex(colorHex);
  if (context.mounted) {
    context.read<AppState>().setPrimaryButtonColor(newColor);
  }
}
