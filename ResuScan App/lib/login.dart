// // // import 'dart:convert';
// // //
// // // import 'package:ai_resume_screening/register.dart';
// // // import 'package:ai_resume_screening/userhome.dart';
// // // import 'package:flutter/cupertino.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:shared_preferences/shared_preferences.dart';
// // // import 'package:http/http.dart' as http;
// // //
// // // void main(){
// // //   runApp(login());
// // // }
// // // class login extends StatelessWidget {
// // //   const login({Key? key}) : super(key: key);
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return  MaterialApp(home: loginsub(),);
// // //   }
// // // }
// // // class loginsub extends StatefulWidget {
// // //   const loginsub({Key? key}) : super(key: key);
// // //
// // //   @override
// // //   State<loginsub> createState() => _loginsubState();
// // // }
// // //
// // // class _loginsubState extends State<loginsub> {
// // //   TextEditingController username=TextEditingController();
// // //   TextEditingController password=TextEditingController();
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //         body:Center(child:
// // //         Column(children:[SizedBox(height: 30,),
// // //           SizedBox(height: 30,width: 300,child:TextField(controller:username,decoration:InputDecoration(border: OutlineInputBorder(),labelText: "username") ,),),
// // //           SizedBox(height: 30,),
// // //           SizedBox(height: 30,width: 300,child:TextField(controller:password,decoration:InputDecoration(border: OutlineInputBorder(),labelText: "password") ,),),
// // //           ElevatedButton(onPressed: () async {
// // //             SharedPreferences prefs=await SharedPreferences.getInstance();
// // //             var data=await http.post(Uri.parse(prefs.getString("ip").toString()+'/user_login'),body:
// // //
// // //             {
// // //               'username':username.text,
// // //               'password':password.text,
// // //             });
// // //             var decodedata=json.decode(data.body);
// // //             if(decodedata['status'] == 'succesfull'){
// // //               prefs.setString("uid", decodedata['uid']);
// // //               showDialog(context: context, builder: (context)=>AlertDialog(title: Text("LOGIN"),content: Text("Succesfull"),
// // //               actions: [
// // //                 TextButton(onPressed: (){
// // //                   Navigator.push(context, MaterialPageRoute(builder: (context)=>userhome()));
// // //                 }, child: Text("OK"))
// // //               ],
// // //
// // //               ));
// // //             }
// // //           }, child: Text("Submit")),
// // //           ElevatedButton(onPressed: (){
// // //             Navigator.push(context, MaterialPageRoute(builder: (context)=>register()));
// // //           }, child: Text("Register"))
// // //         ])
// // //         )
// // //     );
// // //   }
// // // }
// //
// //
// // import 'dart:convert';
// //
// // import 'package:ai_resume_screening/register.dart';
// // import 'package:ai_resume_screening/userhome.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:http/http.dart' as http;
// //
// // void main() {
// //   runApp(login());
// // }
// //
// // class login extends StatelessWidget {
// //   const login({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(home: loginsub());
// //   }
// // }
// //
// // class loginsub extends StatefulWidget {
// //   const loginsub({Key? key}) : super(key: key);
// //
// //   @override
// //   State<loginsub> createState() => _loginsubState();
// // }
// //
// // class _loginsubState extends State<loginsub> {
// //   TextEditingController username = TextEditingController(text: 'jishnu@gmail.com');
// //   TextEditingController password = TextEditingController(text: 'jishnu246');
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         leading: IconButton(
// //           icon: Icon(Icons.arrow_back),
// //           onPressed: () {
// //             // Navigate back to userhome
// //             Navigator.pushReplacement(
// //               context,
// //               MaterialPageRoute(builder: (context) => userhome()),
// //             );
// //           },
// //         ),
// //        // Add title here
// //       ),
// //       body: Container(
// //         width: double.infinity,
// //         height: double.infinity,
// //         decoration: BoxDecoration(
// //           gradient: LinearGradient(
// //             begin: Alignment.topLeft,
// //             end: Alignment.bottomRight,
// //             colors: [
// //               Colors.blue.shade400,
// //               Colors.purple.shade400,
// //             ],
// //           ),
// //         ),
// //         child: Center(
// //           child: Container(
// //             padding: EdgeInsets.all(25),
// //             width: 330,
// //             decoration: BoxDecoration(
// //               color: Colors.white.withOpacity(0.9),
// //               borderRadius: BorderRadius.circular(20),
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: Colors.black26,
// //                   blurRadius: 10,
// //                   spreadRadius: 2,
// //                 ),
// //               ],
// //             ),
// //             child: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 Text(
// //                   "LOGIN",
// //                   style: TextStyle(
// //                       fontSize: 26,
// //                       fontWeight: FontWeight.bold,
// //                       color: Colors.black87),
// //                 ),
// //
// //                 SizedBox(height: 25),
// //
// //                 // Username Field
// //                 TextField(
// //                   controller: username,
// //                   decoration: InputDecoration(
// //                     labelText: "Username",
// //                     prefixIcon: Icon(Icons.person),
// //                     filled: true,
// //                     fillColor: Colors.grey.shade100,
// //                     border: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(12),
// //                       borderSide: BorderSide.none,
// //                     ),
// //                   ),
// //                 ),
// //
// //                 SizedBox(height: 20),
// //
// //                 // Password Field
// //                 TextField(
// //                   controller: password,
// //                   obscureText: true,
// //                   decoration: InputDecoration(
// //                     labelText: "Password",
// //                     prefixIcon: Icon(Icons.lock),
// //                     filled: true,
// //                     fillColor: Colors.grey.shade100,
// //                     border: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(12),
// //                       borderSide: BorderSide.none,
// //                     ),
// //                   ),
// //                 ),
// //
// //                 SizedBox(height: 25),
// //
// //                 // Login Button
// //                 ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                     padding:
// //                     EdgeInsets.symmetric(horizontal: 60, vertical: 14),
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(12),
// //                     ),
// //                     backgroundColor: Colors.blue,
// //                     foregroundColor: Colors.white,
// //                   ),
// //                   onPressed: () async {
// //                     SharedPreferences prefs =
// //                     await SharedPreferences.getInstance();
// //
// //                     var data = await http.post(
// //                         Uri.parse(prefs.getString("ip").toString() +
// //                             '/user_login'),
// //                         body: {
// //                           'username': username.text,
// //                           'password': password.text,
// //                         });
// //
// //                     var decodedata = json.decode(data.body);
// //
// //                     if (decodedata['status'] == 'succesfull') {
// //                       prefs.setString("uid", decodedata['uid']);
// //                       prefs.setString('password', password.text);
// //                       showDialog(
// //                           context: context,
// //                           builder: (context) => AlertDialog(
// //                             title: Text("LOGIN"),
// //                             content: Text("Succesfull"),
// //                             actions: [
// //                               TextButton(
// //                                   onPressed: () {
// //                                     Navigator.push(
// //                                         context,
// //                                         MaterialPageRoute(
// //                                             builder: (context) =>
// //                                                 userhome()));
// //                                   },
// //                                   child: Text("OK"))
// //                             ],
// //                           ));
// //                     }
// //                   },
// //                   child: Text(
// //                     "Login",
// //                     style:
// //                     TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                   ),
// //                 ),
// //
// //                 SizedBox(height: 10),
// //
// //                 // Register Button
// //                 TextButton(
// //                   onPressed: () {
// //                     Navigator.push(context,
// //                         MaterialPageRoute(builder: (context) => register()));
// //                   },
// //                   child: Text(
// //                     "Create an Account",
// //                     style: TextStyle(
// //                         fontSize: 16,
// //                         color: Colors.blue,
// //                         fontWeight: FontWeight.w500),
// //                   ),
// //                 )
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
//
// //
// // import 'dart:convert';
// //
// // import 'package:ai_resume/register.dart';
// // import 'package:ai_resume/userhome.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:http/http.dart' as http;
// //
// // import 'main.dart';
// //
// // void main() {
// //   runApp(login());
// // }
// //
// // class login extends StatelessWidget {
// //   const login({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: loginsub(),
// //       theme: ThemeData.dark().copyWith(
// //         scaffoldBackgroundColor: Colors.black,
// //         appBarTheme: AppBarTheme(
// //           backgroundColor: Colors.black,
// //           elevation: 0,
// //           foregroundColor: Colors.white,
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class loginsub extends StatefulWidget {
// //   const loginsub({Key? key}) : super(key: key);
// //
// //   @override
// //   State<loginsub> createState() => _loginsubState();
// // }
// //
// // class _loginsubState extends State<loginsub> {
// //   TextEditingController username =
// //       TextEditingController(text: 'jishnu@gmail.com');
// //   TextEditingController password = TextEditingController(text: 'jishnu246');
// //   bool _isLoading = false;
// //   bool _passwordVisible = false;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         leading: IconButton(
// //           icon: Icon(Icons.arrow_back, color: Colors.white),
// //           onPressed: () {
// //             Navigator.pushReplacement(
// //               context,
// //               MaterialPageRoute(
// //                   builder: (context) => MyHomePage(
// //                         title: '',
// //                       )),
// //             );
// //           },
// //         ),
// //         backgroundColor: Colors.black,
// //         elevation: 0,
// //       ),
// //       body: Container(
// //         width: double.infinity,
// //         height: double.infinity,
// //         decoration: BoxDecoration(
// //           gradient: LinearGradient(
// //             begin: Alignment.topCenter,
// //             end: Alignment.bottomCenter,
// //             colors: [
// //               Colors.black,
// //               Color(0xFF0A0A1A),
// //               Color(0xFF121230),
// //             ],
// //           ),
// //         ),
// //         child: Center(
// //           child: Container(
// //             padding: EdgeInsets.all(25),
// //             width: 330,
// //             decoration: BoxDecoration(
// //               color: Color(0xFF1A1A2E).withOpacity(0.9),
// //               borderRadius: BorderRadius.circular(20),
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: Colors.blue.withOpacity(0.2),
// //                   blurRadius: 20,
// //                   spreadRadius: 5,
// //                 ),
// //                 BoxShadow(
// //                   color: Colors.black.withOpacity(0.5),
// //                   blurRadius: 30,
// //                   spreadRadius: 5,
// //                 ),
// //               ],
// //               border: Border.all(
// //                 color: Colors.blue.withOpacity(0.3),
// //                 width: 1,
// //               ),
// //             ),
// //             child: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 // Logo/Icon
// //                 Container(
// //                   width: 80,
// //                   height: 80,
// //                   decoration: BoxDecoration(
// //                     shape: BoxShape.circle,
// //                     gradient: LinearGradient(
// //                       begin: Alignment.topLeft,
// //                       end: Alignment.bottomRight,
// //                       colors: [
// //                         Color(0xFF0066FF),
// //                         Color(0xFF00CCFF),
// //                       ],
// //                     ),
// //                     boxShadow: [
// //                       BoxShadow(
// //                         color: Color(0xFF0066FF).withOpacity(0.4),
// //                         blurRadius: 15,
// //                         spreadRadius: 3,
// //                       ),
// //                     ],
// //                   ),
// //                   child: Icon(
// //                     Icons.person,
// //                     size: 40,
// //                     color: Colors.white,
// //                   ),
// //                 ),
// //
// //                 SizedBox(height: 25),
// //
// //                 // Title
// //                 Text(
// //                   "LOGIN",
// //                   style: TextStyle(
// //                     fontSize: 26,
// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.white,
// //                     letterSpacing: 1,
// //                   ),
// //                 ),
// //
// //                 SizedBox(height: 8),
// //
// //                 Text(
// //                   "Access your account",
// //                   style: TextStyle(
// //                     fontSize: 14,
// //                     color: Colors.grey.shade400,
// //                   ),
// //                 ),
// //
// //                 SizedBox(height: 25),
// //
// //                 // Username Field - 300 width as in original
// //                 Container(
// //                   width: 300,
// //                   decoration: BoxDecoration(
// //                     borderRadius: BorderRadius.circular(12),
// //                     gradient: LinearGradient(
// //                       begin: Alignment.centerLeft,
// //                       end: Alignment.centerRight,
// //                       colors: [
// //                         Colors.grey.shade900.withOpacity(0.7),
// //                         Colors.grey.shade900.withOpacity(0.5),
// //                       ],
// //                     ),
// //                   ),
// //                   child: TextField(
// //                     controller: username,
// //                     style: TextStyle(color: Colors.white, fontSize: 16),
// //                     decoration: InputDecoration(
// //                       labelText: "Username",
// //                       labelStyle: TextStyle(color: Colors.grey.shade400),
// //                       prefixIcon: Icon(Icons.email, color: Colors.blue),
// //                       border: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(12),
// //                         borderSide: BorderSide.none,
// //                       ),
// //                       filled: true,
// //                       fillColor: Colors.transparent,
// //                       contentPadding: EdgeInsets.symmetric(
// //                         horizontal: 20,
// //                         vertical: 16,
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //
// //                 SizedBox(height: 20),
// //
// //                 // Password Field - 300 width as in original
// //                 Container(
// //                   width: 300,
// //                   decoration: BoxDecoration(
// //                     borderRadius: BorderRadius.circular(12),
// //                     gradient: LinearGradient(
// //                       begin: Alignment.centerLeft,
// //                       end: Alignment.centerRight,
// //                       colors: [
// //                         Colors.grey.shade900.withOpacity(0.7),
// //                         Colors.grey.shade900.withOpacity(0.5),
// //                       ],
// //                     ),
// //                   ),
// //                   child: TextField(
// //                     controller: password,
// //                     obscureText: !_passwordVisible,
// //                     style: TextStyle(color: Colors.white, fontSize: 16),
// //                     decoration: InputDecoration(
// //                       labelText: "Password",
// //                       labelStyle: TextStyle(color: Colors.grey.shade400),
// //                       prefixIcon: Icon(Icons.lock, color: Colors.blue),
// //                       suffixIcon: IconButton(
// //                         icon: Icon(
// //                           _passwordVisible
// //                               ? Icons.visibility
// //                               : Icons.visibility_off,
// //                           color: Colors.grey.shade400,
// //                           size: 20,
// //                         ),
// //                         onPressed: () {
// //                           setState(() {
// //                             _passwordVisible = !_passwordVisible;
// //                           });
// //                         },
// //                       ),
// //                       border: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(12),
// //                         borderSide: BorderSide.none,
// //                       ),
// //                       filled: true,
// //                       fillColor: Colors.transparent,
// //                       contentPadding: EdgeInsets.symmetric(
// //                         horizontal: 20,
// //                         vertical: 16,
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //
// //                 SizedBox(height: 25),
// //
// //                 // Login Button - 300 width as in original
// //                 Container(
// //                   width: 300,
// //                   height: 50,
// //                   decoration: BoxDecoration(
// //                     borderRadius: BorderRadius.circular(12),
// //                     gradient: LinearGradient(
// //                       begin: Alignment.centerLeft,
// //                       end: Alignment.centerRight,
// //                       colors: [
// //                         Color(0xFF0066FF),
// //                         Color(0xFF0099FF),
// //                       ],
// //                     ),
// //                     boxShadow: [
// //                       BoxShadow(
// //                         color: Color(0xFF0066FF).withOpacity(0.4),
// //                         blurRadius: 10,
// //                         spreadRadius: 2,
// //                       ),
// //                     ],
// //                   ),
// //                   child: ElevatedButton(
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: Colors.transparent,
// //                       shadowColor: Colors.transparent,
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(12),
// //                       ),
// //                       padding: EdgeInsets.zero,
// //                     ),
// //                     onPressed: _isLoading
// //                         ? null
// //                         : () async {
// //                             setState(() {
// //                               _isLoading = true;
// //                             });
// //
// //                             SharedPreferences prefs =
// //                                 await SharedPreferences.getInstance();
// //
// //                             try {
// //                               var data = await http.post(
// //                                   Uri.parse(prefs.getString("ip").toString() +
// //                                       '/user_login'),
// //                                   body: {
// //                                     'username': username.text,
// //                                     'password': password.text,
// //                                   });
// //
// //                               var decodedata = json.decode(data.body);
// //
// //                               if (decodedata['status'] == 'succesfull') {
// //                                 prefs.setString(
// //                                     "uid", decodedata['uid'].toString());
// //                                 prefs.setString(
// //                                     "lid", decodedata['lid'].toString());
// //                                 prefs.setString('password', password.text);
// //
// //                                 setState(() {
// //                                   _isLoading = false;
// //                                 });
// //
// //                                 showDialog(
// //                                     context: context,
// //                                     builder: (context) => AlertDialog(
// //                                           backgroundColor: Color(0xFF1A1A2E),
// //                                           title: Text(
// //                                             "LOGIN",
// //                                             style: TextStyle(
// //                                               color: Colors.white,
// //                                               fontWeight: FontWeight.bold,
// //                                             ),
// //                                           ),
// //                                           content: Text(
// //                                             "Succesfull",
// //                                             style: TextStyle(
// //                                               color: Colors.grey.shade300,
// //                                             ),
// //                                           ),
// //                                           actions: [
// //                                             TextButton(
// //                                                 onPressed: () {
// //                                                   Navigator.push(
// //                                                       context,
// //                                                       MaterialPageRoute(
// //                                                           builder: (context) =>
// //                                                               userhome()));
// //                                                 },
// //                                                 child: Text(
// //                                                   "OK",
// //                                                   style: TextStyle(
// //                                                     color: Colors.blue,
// //                                                     fontWeight: FontWeight.bold,
// //                                                   ),
// //                                                 ))
// //                                           ],
// //                                         ));
// //                               } else {
// //                                 setState(() {
// //                                   _isLoading = false;
// //                                 });
// //                                 _showErrorDialog(
// //                                     "Login failed. Please check your credentials.");
// //                               }
// //                             } catch (e) {
// //                               setState(() {
// //                                 _isLoading = false;
// //                               });
// //                               _showErrorDialog(
// //                                   "Connection error. Please try again.");
// //                             }
// //                           },
// //                     child: _isLoading
// //                         ? SizedBox(
// //                             height: 20,
// //                             width: 20,
// //                             child: CircularProgressIndicator(
// //                               strokeWidth: 2,
// //                               color: Colors.white,
// //                             ),
// //                           )
// //                         : Text(
// //                             "Submit",
// //                             style: TextStyle(
// //                               fontSize: 18,
// //                               fontWeight: FontWeight.bold,
// //                               color: Colors.white,
// //                             ),
// //                           ),
// //                   ),
// //                 ),
// //
// //                 SizedBox(height: 15),
// //
// //                 // Register Button - 300 width as in original
// //                 Container(
// //                   width: 300,
// //                   height: 50,
// //                   decoration: BoxDecoration(
// //                     borderRadius: BorderRadius.circular(12),
// //                     border: Border.all(
// //                       color: Colors.blue.withOpacity(0.5),
// //                       width: 2,
// //                     ),
// //                   ),
// //                   child: ElevatedButton(
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: Colors.transparent,
// //                       shadowColor: Colors.transparent,
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(12),
// //                       ),
// //                       padding: EdgeInsets.zero,
// //                     ),
// //                     onPressed: () {
// //                       Navigator.push(context,
// //                           MaterialPageRoute(builder: (context) => register()));
// //                     },
// //                     child: Text(
// //                       "Register",
// //                       style: TextStyle(
// //                         fontSize: 16,
// //                         fontWeight: FontWeight.w600,
// //                         color: Colors.blue,
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //
// //                 SizedBox(height: 20),
// //
// //                 // Footer note
// //                 Text(
// //                   "AI Resume Screening System",
// //                   style: TextStyle(
// //                     color: Colors.grey.shade600,
// //                     fontSize: 12,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   void _showErrorDialog(String message) {
// //     showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         backgroundColor: Color(0xFF1A1A2E),
// //         title: Text(
// //           "Error",
// //           style: TextStyle(
// //             color: Colors.red.shade300,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //         content: Text(
// //           message,
// //           style: TextStyle(
// //             color: Colors.grey.shade300,
// //           ),
// //         ),
// //         actions: [
// //           TextButton(
// //             onPressed: () {
// //               Navigator.pop(context);
// //             },
// //             child: Text(
// //               "OK",
// //               style: TextStyle(
// //                 color: Colors.blue,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
// import 'dart:convert';
//
// import 'package:ai_resume/register.dart';
// import 'package:ai_resume/userhome.dart';
// import 'package:ai_resume/forgot email.dart'; // 👈 ADD THIS
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// import 'main.dart';
//
// void main() {
//   runApp(login());
// }
//
// class login extends StatelessWidget {
//   const login({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false, // 👈 disable debug banner
//       home: loginsub(),
//       theme: ThemeData.dark().copyWith(
//         scaffoldBackgroundColor: Colors.black,
//         appBarTheme: AppBarTheme(
//           backgroundColor: Colors.black,
//           elevation: 0,
//           foregroundColor: Colors.white,
//         ),
//       ),
//     );
//   }
// }
//
// class loginsub extends StatefulWidget {
//   const loginsub({Key? key}) : super(key: key);
//
//   @override
//   State<loginsub> createState() => _loginsubState();
// }
//
// class _loginsubState extends State<loginsub> {
//   TextEditingController username =
//       TextEditingController(text: 'riss.muraleekrishnanvv@gmail.com');
//   TextEditingController password = TextEditingController(text: 'murali@123');
//
//   bool _isLoading = false;
//   bool _passwordVisible = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => MyHomePage(title: '')),
//             );
//           },
//         ),
//         backgroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Colors.black,
//               Color(0xFF0A0A1A),
//               Color(0xFF121230),
//             ],
//           ),
//         ),
//         child: Center(
//           child: Container(
//             padding: EdgeInsets.all(25),
//             width: 330,
//             decoration: BoxDecoration(
//               color: Color(0xFF1A1A2E).withOpacity(0.9),
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.blue.withOpacity(0.2),
//                   blurRadius: 20,
//                   spreadRadius: 5,
//                 ),
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.5),
//                   blurRadius: 30,
//                   spreadRadius: 5,
//                 ),
//               ],
//               border: Border.all(
//                 color: Colors.blue.withOpacity(0.3),
//                 width: 1,
//               ),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 /// ICON
//                 Container(
//                   width: 80,
//                   height: 80,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     gradient: LinearGradient(
//                       colors: [Color(0xFF0066FF), Color(0xFF00CCFF)],
//                     ),
//                   ),
//                   child: Icon(Icons.person, size: 40, color: Colors.white),
//                 ),
//
//                 SizedBox(height: 25),
//
//                 Text("LOGIN",
//                     style: TextStyle(
//                         fontSize: 26,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white)),
//
//                 SizedBox(height: 25),
//
//                 /// USERNAME
//                 Container(
//                   width: 300,
//                   child: TextField(
//                     controller: username,
//                     style: TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                       labelText: "Username",
//                       prefixIcon: Icon(Icons.email, color: Colors.blue),
//                       filled: true,
//                       fillColor: Colors.grey.shade900,
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide.none),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 20),
//
//                 /// PASSWORD
//                 Container(
//                   width: 300,
//                   child: TextField(
//                     controller: password,
//                     obscureText: !_passwordVisible,
//                     style: TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                       labelText: "Password",
//                       prefixIcon: Icon(Icons.lock, color: Colors.blue),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _passwordVisible
//                               ? Icons.visibility
//                               : Icons.visibility_off,
//                           color: Colors.grey,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _passwordVisible = !_passwordVisible;
//                           });
//                         },
//                       ),
//                       filled: true,
//                       fillColor: Colors.grey.shade900,
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide.none),
//                     ),
//                   ),
//                 ),
//
//                 /// ✅ FORGOT PASSWORD LINK
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => forgotemail()),
//                       );
//                     },
//                     child: Text(
//                       "Forgot Password?",
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 10),
//
//                 /// LOGIN BUTTON
//                 Container(
//                   width: 300,
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: _isLoading
//                         ? null
//                         : () async {
//                             setState(() => _isLoading = true);
//
//                             SharedPreferences prefs =
//                                 await SharedPreferences.getInstance();
//
//                             try {
//                               var data = await http.post(
//                                 Uri.parse(prefs.getString("ip").toString() +
//                                     '/user_login'),
//                                 body: {
//                                   'username': username.text,
//                                   'password': password.text,
//                                 },
//                               );
//
//                               var decodedata = json.decode(data.body);
//
//                               if (decodedata['status'] == 'succesfull') {
//                                 prefs.setString(
//                                     "uid", decodedata['uid'].toString());
//
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => userhome()));
//                               } else {
//                                 _showErrorDialog("Invalid credentials");
//                               }
//                             } catch (e) {
//                               _showErrorDialog("Connection error");
//                             }
//
//                             setState(() => _isLoading = false);
//                           },
//                     child: _isLoading
//                         ? CircularProgressIndicator(color: Colors.white)
//                         : Text("Submit"),
//                   ),
//                 ),
//
//                 SizedBox(height: 15),
//
//                 /// REGISTER
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => register()));
//                   },
//                   child: Text("Create an Account",
//                       style: TextStyle(color: Colors.blue)),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Error"),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:ai_resume/register.dart';
import 'package:ai_resume/userhome.dart';
import 'package:ai_resume/forgot email.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

void main() {
  runApp(const login());
}

class login extends StatelessWidget {
  const login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: loginsub(),
    );
  }
}

class loginsub extends StatefulWidget {
  const loginsub({Key? key}) : super(key: key);

  @override
  State<loginsub> createState() => _loginsubState();
}

class _loginsubState extends State<loginsub> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _passwordVisible = false;

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final ip = prefs.getString("ip");

      if (ip == null) {
        _showError("Server not configured");
        return;
      }

      var data = await http.post(
        Uri.parse("$ip/user_login"),
        body: {
          'username': username.text.trim(),
          'password': password.text.trim(),
        },
      );

      var decodedata = json.decode(data.body);

      if (decodedata['status'] == 'succesfull') {
        prefs.setString("uid", decodedata['uid'].toString());

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => userhome()),
        );
      } else {
        _showError("Invalid username or password");
      }
    } catch (e) {
      _showError("Connection error. Try again.");
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0f172a),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildLogo(),
                        const SizedBox(height: 30),
                        _buildTitle(),
                        const SizedBox(height: 40),
                        _buildUsernameField(),
                        const SizedBox(height: 20),
                        _buildPasswordField(),
                        _buildForgotPassword(),
                        const SizedBox(height: 30),
                        _buildLoginButton(),
                        const SizedBox(height: 20),
                        _buildRegisterButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= HEADER =================

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff1e293b), Color(0xff334155)],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => MyHomePage(title: "")),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white, size: 18),
            ),
          ),
          const SizedBox(width: 20),
          const Text(
            "Welcome Back",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  // ================= LOGO =================

  Widget _buildLogo() {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Colors.indigo, Colors.deepPurple],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.4),
            blurRadius: 25,
            spreadRadius: 5,
          ),
        ],
      ),
      child: const Icon(Icons.person_outline, size: 55, color: Colors.white),
    );
  }

  // ================= TITLE =================

  Widget _buildTitle() {
    return const Column(
      children: [
        Text(
          "Login to Continue",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          "Access your AI Resume Dashboard",
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }

  // ================= USERNAME =================

  Widget _buildUsernameField() {
    return TextFormField(
      controller: username,
      style: const TextStyle(color: Colors.white),
      validator: (v) {
        if (v == null || v.isEmpty) return "Username required";
        if (!v.contains("@")) return "Enter valid email";
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: const Icon(Icons.email, color: Colors.white70),
        filled: true,
        fillColor: const Color(0xff1e293b),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // ================= PASSWORD =================

  Widget _buildPasswordField() {
    return TextFormField(
      controller: password,
      obscureText: !_passwordVisible,
      style: const TextStyle(color: Colors.white),
      validator: (v) => v == null || v.length < 4 ? "Password required" : null,
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: const Icon(Icons.lock, color: Colors.white70),
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.white70,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
        filled: true,
        fillColor: const Color(0xff1e293b),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // ================= FORGOT PASSWORD =================

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => forgotemail()),
          );
        },
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.indigoAccent),
        ),
      ),
    );
  }

  // ================= LOGIN BUTTON =================

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _login,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigoAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              )
            : const Text(
                "LOGIN",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
      ),
    );
  }

  // ================= REGISTER =================

  Widget _buildRegisterButton() {
    return TextButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => register()));
      },
      child: const Text(
        "Create an Account",
        style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w500),
      ),
    );
  }

  // ================= ERROR =================

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xff1e293b),
        title:
            const Text("Login Failed", style: TextStyle(color: Colors.white)),
        content: Text(message, style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK",
                  style: TextStyle(color: Colors.indigoAccent)))
        ],
      ),
    );
  }
}
