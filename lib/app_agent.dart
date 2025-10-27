import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bmi_calculator/tools.dart';
import 'package:flutter_bmi_calculator/utils.dart';
import 'package:provider/provider.dart';
import 'package:firebase_ai/firebase_ai.dart';
import '../app_state.dart';

class AppAgent {
  final gemini = FirebaseAI.googleAI().generativeModel(
    systemInstruction: Content.text('''
      You are a friendly and helpful app concierge. Your job is to help the user
      get the best, frictionless app experience. 
      If you have access to a tool that can configure the setting for
      the user and address their feedback, ALWAYS ask the user to confirm the
      change before making the change using the 'askConfirmation' tool.
      Before filing a feedback report, first gather all of the following information:
      - Device Information
      - When the user has feedback regarding performance, also include battery information.
      to include in the feedback report.
      '''),
    model: 'gemini-2.5-flash',
    toolConfig: ToolConfig(
      functionCallingConfig: FunctionCallingConfig.any({
        'setPrimaryButtonColor',
        'askConfirmation',
        'setFontFamily',
        'setFontSizeFactor',
        'setAppColor',
        'getDeviceInfo',
        'getBatteryInfo',
        'fileFeedback',
      }),
    ),
    tools: [
      Tool.functionDeclarations([
        setPrimaryButtonColorTool,
        askConfirmationTool,
        fontFamilyTool,
        fontSizeFactorTool,
        appThemeColorTool,
        deviceInfoTool,
        batteryInfoTool,
        fileFeedbackTool,
      ]),
    ],
  );
  late ChatSession chat;
  late Uint8List screenshot;
  late String feedbackText;

  initialize() {
    chat = gemini.startChat();
  }

  Future<bool> askConfirmation(BuildContext context, String question) async {
    var response = await showDialog<bool>(
      context: context,
      builder: (context) {
        return Theme(
          data: context.read<AppState>().appTheme,
          child: AlertDialog(
            title: const Text('App Manager'),
            content: Text(question),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text('Yes, please'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('No.'),
              ),
            ],
          ),
        );
      },
    );

    return response ?? false;
  }

  Future<GenerateContentResponse?> askConfirmationCall(
    BuildContext context,
    FunctionCall functionCall,
  ) async {
    var question = functionCall.args['question']! as String;

    if (context.mounted) {
      final functionResult = await askConfirmation(context, question);

      final response = await chat.sendMessage(
        functionResult
            ? Content.text('Yes, please do that.')
            : Content.text('No, thank you.'),
      );

      return response;
    }
    return null;
  }

  void checkFunctionCalls(
    BuildContext context,
    Iterable<FunctionCall> functionCalls,
  ) async {
    for (var functionCall in functionCalls) {
      debugPrint('Handling tool: ${functionCall.name}');
      GenerateContentResponse? response;

      switch (functionCall.name) {
        case 'askConfirmation':
          response = await askConfirmationCall(context, functionCall);
          break;

        case 'setPrimaryButtonColor':
          setPrimaryButtonColorCall(context, functionCall);
          break;

        case 'setFontFamily':
          setFontFamilyCall(context, functionCall);
          break;

        case 'setFontSizeFactor':
          setFontSizeFactorCall(context, functionCall);
          break;

        case 'setAppColor':
          setAppColorCall(context, functionCall);
          break;

        case 'getDeviceInfo':
          var deviceInfo = await getDeviceInfoCall();
          response = await chat.sendMessage(
            Content.text('Device Info: $deviceInfo'),
          );
          break;

        case 'getBatteryInfo':
          var batteryInfo = await getBatteryInfoCall();
          response = await chat.sendMessage(
            Content.text('Battery Info: $batteryInfo'),
          );
          break;

        case 'fileFeedback':
          var feedbackReport = await fileFeedbackReport(context, functionCall);
          await chat.sendMessage(
            Content.text(
              'Feedback Report successfully filed: $feedbackReport.',
            ),
          );
          break;

        default:
          throw UnimplementedError(
            'Function not declared to the model: ${functionCall.name}',
          );
      }

      if (response != null &&
          response.functionCalls.isNotEmpty &&
          context.mounted) {
        // Recursively handle any chained function calls
        checkFunctionCalls(context, response.functionCalls);
      }
    }
  }

  Future<String> fileFeedbackReport(
    BuildContext context,
    FunctionCall functionCall,
  ) async {
    // Safely retrieve arguments, using defaults for nullable fields
    String summary = functionCall.args['summary'] as String? ?? 'No Summary';
    String deviceInfo =
        functionCall.args['deviceInfo'] as String? ?? 'No Device Info';
    String batteryInfo = functionCall.args['batteryInfo'] as String? ?? 'N/A';
    String actionHistory =
        functionCall.args['actionHistory'] as String? ?? 'No History';
    List<dynamic> tagsList = functionCall.args['tags'] as List<dynamic>? ?? [];
    List<String> tags = tagsList.map((tag) => tag as String).toList();
    int priority = functionCall.args['priority'] as int? ?? 3;

    // Create a detailed report string for logging/display
    String feedbackReport =
        '''
    Report Filed:
    Summary: $summary
    Device Info: $deviceInfo
    Battery Info: $batteryInfo
    Action History: $actionHistory
    Tags: ${tags.join(', ')}
    Priority: $priority
    User Feedback: "$feedbackText"
    ''';

    // Log the detailed report (in a real app, this would be sent to a server)
    debugPrint(feedbackReport);

    // Show a demonstration dialog of the filed report
    AppState manager = context.read<AppState>();
    showDialog(
      context: context,
      builder: (context) {
        return Theme(
          data: manager.appTheme,
          child: AlertDialog(
            actions: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
            title: const Text('Feedback Report Filed'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Summary: $summary',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  Text(
                    'Priority: $priority',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  Text('Tags: ${tags.join(', ')}'),
                  const SizedBox(height: 10),
                  const Text(
                    'Device & Performance Data:',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                  Text(deviceInfo),
                  Text(batteryInfo),
                  const SizedBox(height: 10),
                  const Text(
                    'User Comment:',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                  Text(feedbackText),
                  const SizedBox(height: 10),
                  const Text(
                    'Screenshot:',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                  // Display the screenshot
                  Image.memory(screenshot),
                ],
              ),
            ),
          ),
        );
      },
    );

    // Return the report string for the agent to use in its chat response
    return "Feedback report filed with priority $priority, tags: ${tags.join(', ')}";
  }

  void submitFeedback(
    BuildContext context,
    Uint8List userScreenshot,
    String userFeedbackText,
  ) async {
    screenshot = userScreenshot;
    feedbackText = userFeedbackText;

    // 💡 Directive Prompt: Ask the agent to recommend a fix OR file a report.
    final prompt = Content.multi([
      TextPart(
        '''The user has submitted the following written feedback: "$userFeedbackText". 
           First, analyze the feedback and suggest a UI configuration change (color, font, or size) to address their issue. If you suggest a change, you MUST use the 'askConfirmation' tool first. 
           If the user denies the change, OR if no change is appropriate for the feedback, you MUST proceed to file a detailed feedback report using the 'fileFeedback' tool.
        ''',
      ),
      // Pass the screenshot to the agent for visual context
      InlineDataPart('image/png', screenshot),
    ]);

    final response = await chat.sendMessage(prompt);

    final functionCalls = response.functionCalls.toList();

    if (context.mounted && functionCalls.isNotEmpty) {
      checkFunctionCalls(context, functionCalls);
    }
  }
}
