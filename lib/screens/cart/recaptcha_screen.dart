// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class RecaptchaScreen extends StatefulWidget {
//   @override
//   _RecaptchaScreenState createState() => _RecaptchaScreenState();
// }
//
// class _RecaptchaScreenState extends State<RecaptchaScreen> {
//   WebViewController? _webViewController;
//   bool _isVerified = false;
//
//   @override
//   void dispose() {
//     _webViewController?.clearCache();
//     super.dispose();
//   }
//
//   void _handleVerification(String response) {
//     if (response.isNotEmpty) {
//       setState(() {
//         _isVerified = true;
//       });
//       Navigator.pop(context, true);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('reCAPTCHA'),
//       ),
//       body: Stack(
//         children: [
//           WebView(
//             initialUrl: 'https://www.google.com/recaptcha/api2/demo',
//             javascriptMode: JavascriptMode.unrestricted,
//             onPageFinished: (String url) {
//               if (url.contains('recaptcha/api2/demo')) {
//                 _webViewController?.evaluateJavascript('''
//                   document.getElementById('recaptcha-demo-form').addEventListener('submit', function(event) {
//                     event.preventDefault();
//                     var response = grecaptcha.getResponse();
//                     window.flutter_inappwebview.postMessage(response);
//                   });
//                 ''');
//               }
//             },
//             onWebViewCreated: (WebViewController webViewController) {
//               _webViewController = webViewController;
//             },
//             javascriptChannels: Set.from([
//               JavascriptChannel(
//                 name: 'flutter_inappwebview',
//                 onMessageReceived: (JavascriptMessage message) {
//                   _handleVerification(message.message);
//                 },
//               ),
//             ]),
//           ),
//           if (!_isVerified)
//             Center(
//               child: CircularProgressIndicator(),
//             ),
//         ],
//       ),
//     );
//   }
// }
