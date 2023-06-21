import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maget_app/components/body.dart';

import 'package:maget_app/pages/home_page.dart';
import 'package:maget_app/pages/login_page.dart';
import 'package:provider/provider.dart';

import '../controllers/customer_controller.dart';
import '../models/customer_model.dart';
import '../services/customer_services.dart';
import '../widgets/drawerappbar.dart';

class ProfilePage extends StatefulWidget {
  // const ProfilePage({Key? key, required this.email, required this.role})
  //     : super(key: key);
  // final String email;
  // final String role;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  List<Customer> profile = List.empty();
  CustomerController controller = CustomerController(CustomerServices());

  // late String _email = widget.email;

  // late String _role = widget.role;
  late String _rolename;
  bool isLoading = false;

  void initState() {
    super.initState();
    controller.onSync.listen((bool synState) => setState(() {
          isLoading = synState;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ข้อมูลผู้ใช้งาน",
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => LoginPage(),
              ));
            },
          ),
          // IconButton(
          //   icon: const Icon(Icons.notifications),
          //   onPressed: () {},
          // ),
        ],
      ),
      drawer: DrawerBar(),
      body: Consumer<ProfileDetailModel>(
        builder: (context, ProfileDetailModel profiles, child) {
          return InkWell(
            onTap: () {
              //Navigator.pushNamed(context, '/5');
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                // width: 300,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 6.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    // Image.asset(
                    //   'images/profile.png',
                    //   height: 100,
                    // ),
                    SizedBox(height: 12),
                    Divider(
                      height: 2,
                      thickness: 1,
                      indent: 1,
                      color: Colors.black,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'ข้อมูลส่วนตัว',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    const Divider(
                      height: 2,
                      thickness: 1,
                      indent: 1,
                      color: Colors.black,
                    ),
                    SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'ชื่อ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              profiles.name,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'นามสกุล',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              profiles.lastName,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'เพศ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              profiles.Gender,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child: Text(
                    //           'เบอร์โทรศัพท์',
                    //           textAlign: TextAlign.left,
                    //           style: TextStyle(
                    //               fontSize: 16,
                    //               color: Colors.black,
                    //               fontWeight: FontWeight.bold),
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: Text(
                    //           profiles[index].telNo,
                    //           textAlign: TextAlign.end,
                    //           style: TextStyle(
                    //             color: Colors.black,
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'หมายเลขโทรศัพท์',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              profiles.telNo,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'พร้อมเพย์',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'หมายเลขบัตรประชาชน / หมายเลขโทรศัพท์มือถือ',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Text(
                              profiles.idCard,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'อีเมล',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Text(
                              profiles.email,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Text(
                          'แก้ไขข้อมูลส่วนตัว',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Widget buildorders(List<Customer> profiles) => ListView.builder(
//       itemCount: !profiles.isEmpty ? profiles.length : 1,
//       itemBuilder: (context, index) {
//         return InkWell(
//           onTap: () {
//             //Navigator.pushNamed(context, '/5');
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Container(
//               width: 300,
//               padding: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.shade400,
//                     blurRadius: 6.0,
//                     spreadRadius: 2.0,
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: <Widget>[
//                   // Image.asset(
//                   //   'images/profile.png',
//                   //   height: 100,
//                   // ),
//                   SizedBox(height: 12),
//                   const Divider(
//                     height: 2,
//                     thickness: 1,
//                     indent: 1,
//                     color: Colors.black,
//                   ),
//                   SizedBox(height: 5),
//                   Text(
//                     'ข้อมูลส่วนตัว',
//                     textAlign: TextAlign.left,
//                     style: TextStyle(
//                       fontSize: 20,
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   const Divider(
//                     height: 2,
//                     thickness: 1,
//                     indent: 1,
//                     color: Colors.black,
//                   ),
//                   SizedBox(height: 12),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             'ชื่อ',
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Expanded(
//                           child: Text(
//                             profiles[index].name,
//                             textAlign: TextAlign.end,
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             'นามสกุล',
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Expanded(
//                           child: Text(
//                             profiles[index].lastName,
//                             textAlign: TextAlign.end,
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             'เพศ',
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Expanded(
//                           child: Text(
//                             profiles[index].Gender,
//                             textAlign: TextAlign.end,
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Padding(
//                   //   padding: const EdgeInsets.all(8.0),
//                   //   child: Row(
//                   //     children: [
//                   //       Expanded(
//                   //         child: Text(
//                   //           'เบอร์โทรศัพท์',
//                   //           textAlign: TextAlign.left,
//                   //           style: TextStyle(
//                   //               fontSize: 16,
//                   //               color: Colors.black,
//                   //               fontWeight: FontWeight.bold),
//                   //         ),
//                   //       ),
//                   //       Expanded(
//                   //         child: Text(
//                   //           profiles[index].telNo,
//                   //           textAlign: TextAlign.end,
//                   //           style: TextStyle(
//                   //             color: Colors.black,
//                   //             fontSize: 14,
//                   //             fontWeight: FontWeight.bold,
//                   //           ),
//                   //         ),
//                   //       ),
//                   //     ],
//                   //   ),
//                   // ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             'หมายเลขโทรศัพท์',
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Expanded(
//                           child: Text(
//                             profiles[index].telNo,
//                             textAlign: TextAlign.end,
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Padding(
//                   //   padding: const EdgeInsets.all(8.0),
//                   //   child: Row(
//                   //     children: [
//                   //       Expanded(
//                   //         child: Text(
//                   //           'จังหวัด',
//                   //           textAlign: TextAlign.left,
//                   //           style: TextStyle(
//                   //               fontSize: 16,
//                   //               color: Colors.black,
//                   //               fontWeight: FontWeight.bold),
//                   //         ),
//                   //       ),
//                   //       Expanded(
//                   //         child: Text(
//                   //           profiles[index].province,
//                   //           textAlign: TextAlign.end,
//                   //           style: TextStyle(
//                   //             color: Colors.black,
//                   //             fontSize: 14,
//                   //             fontWeight: FontWeight.bold,
//                   //           ),
//                   //         ),
//                   //       ),
//                   //     ],
//                   //   ),
//                   // ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         Text(
//                           'อีเมล',
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: Text(
//                       profiles[index].email,
//                       textAlign: TextAlign.end,
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 12),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => LoginPage(),
//                           ),
//                         );
//                       },
//                       child: Text(
//                         'แก้ไขข้อมูลส่วนตัว',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
