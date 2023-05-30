// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import '../controller/authen_controller.dart';
// import '../model/authen_model.dart';
// import '../service/authen_service.dart';
// import '/home.dart';

// class ContractPage extends StatefulWidget {
//   static const routeName = '/';

//   const ContractPage({Key? key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() {
//     return _ContractPageState();
//   }
// }

// class _ContractPageState extends State<ContractPage> {
//   int _selectedItemIndex = 2;
//   final _pageController = PageController();
//   bool isLoading = false;
//   List<ProfileContractModel> profileCont = List.empty();
//   AuthenController controller = AuthenController(AuthenServices());
//   AuthenModel? model;
//   double sum_contBalance = 0.00;
//   final oCcy = new NumberFormat("#,##0.00", "en_US");

//   @override
//   void initState() {
//     double accAvalable = context.read<LoansAccountModel>().accAvalable;
//     double accBalance = context.read<LoansAccountModel>().accBalance;
//     double accLimit = context.read<LoansAccountModel>().accLimit;
//     int proID = context.read<LoansAccountModel>().proID;
//     super.initState();

//     print(' initState() ContractPage');

//     controller.onSync.listen((bool syncState) => setState(() {
//           isLoading = syncState;
//         }));

//     var empCode = context.read<ProfilesAPIModel>().empCode.toString();
//     _getProfileContract(empCode, "Y");
//   }

//   Future<List<ProfileContractModel>> _getProfileContract(
//       _empcode, _isActive) async {
//     print(_empcode);
//     var getToken = await controller.getToken();
//     setState(() => model = getToken);
//     List<ProfileContractModel> response =
//         await controller.getProfileContract(model!.token, _empcode, _isActive);
//     setState(() => profileCont = response);
//     print("ProfileContract  ${profileCont.length}");

//     for (var i = 0; i < profileCont.length; i++) {
//       sum_contBalance = sum_contBalance + profileCont[i].contBalance;
//     }

//     print(oCcy.format(sum_contBalance).toString());
//     // }
//     return profileCont;
//   }

//   @override
//   Widget get bodyTransactions => isLoading
//       ? Center(child: CircularProgressIndicator())
//       : ListView.builder(
//           itemCount: profileCont.isNotEmpty ? profileCont.length : 1,
//           itemBuilder: (context, index) {
//             var col;
//             if (profileCont.isNotEmpty) {
//               col = Colors.white70;
//               return Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: InkWell(
//                   onTap: () {},
//                   child: Container(
//                     padding: EdgeInsets.all(15),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: col.withOpacity(0.25),
//                     ),
//                     height: 130,
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 Icon(
//                                   Icons.account_balance_wallet,
//                                   color: Color(0xFF00B686),
//                                 ),
//                                 Text(
//                                   ' (' + profileCont[index].contNo + ') ',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                                 Text(
//                                   ' ' + profileCont[index].lUsername,
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 // Icon(
//                                 //   Icons.keyboard_arrow_right,
//                                 //   color: Colors.deepOrange,
//                                 //   size: 30.0,
//                                 // ),
//                               ],
//                             )
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Text(
//                                   ' วงเงินค้ำประกัน',
//                                 )
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Text(
//                                   profileCont[index].contLimit,
//                                   style: TextStyle(),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 Text(' ผู้กู้จ่ายแล้ว'),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Text(
//                                   profileCont[index].contPay,
//                                   style: TextStyle(),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 Text(' คงเหลือ'),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Text(
//                                   oCcy
//                                       .format(profileCont[index].contBalance)
//                                       .toString(),
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.blue,
//                                   ),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                         Container(
//                           height: 1,
//                           width: double.maxFinite,
//                           color: Colors.grey.withOpacity(0.5),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             } else {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     height: 180,
//                   ),
//                   Text(' ไม่พบรายการภาระการค้ำประกัน'),
//                 ],
//               );
//             }
//           });

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ภาระการค้ำประกัน'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white38,
//               borderRadius: BorderRadius.circular(16.0),
//               border: Border.all(width: 1.5, color: Colors.black38),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 // const SizedBox(
//                 //   height: 5,
//                 // ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Table(
//                     //defaultColumnWidth: FixedColumnWidth(200.0),
//                     // border: TableBorder.all(color: Colors.black, width: 1.5),
//                     children: [
//                       TableRow(
//                         decoration: const BoxDecoration(color: Colors.blue),
//                         children: [
//                           Text(' สถานะ : ติดสัญญา ',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                   color: Colors.white)),
//                           SizedBox(
//                             height: 40,
//                           ),
//                         ],
//                       ),
//                       // TableRow(
//                       //   children: [
//                       //     Text(' นายอี',
//                       //         style: TextStyle(
//                       //           fontSize: 18,
//                       //         )),
//                       //     Text('งวด 10/36  800,000 บาท'),
//                       //   ],
//                       // ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   height: 400,
//                   width: 400,
//                   child: PageView(
//                     controller: _pageController,
//                     scrollDirection: Axis.horizontal,
//                     children: [bodyTransactions],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   height: 1,
//                   width: double.maxFinite,
//                   color: Colors.grey.withOpacity(0.5),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Table(
//                     children: [
//                       TableRow(
//                         // decoration: const BoxDecoration(color: Colors.blue),
//                         children: [
//                           Text(' รวมภาระการค้ำประกัน',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.blue)),
//                           Text(
//                               '  ' +
//                                   oCcy.format(sum_contBalance).toString() +
//                                   '  บาท',
//                               style: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.blue)),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   height: 1,
//                   width: double.maxFinite,
//                   color: Colors.grey.withOpacity(0.5),
//                 ),
//                 // SizedBox(
//                 //   height: 20,
//                 // ),
//                 // Padding(
//                 //   padding: const EdgeInsets.all(8.0),
//                 //   child: Table(
//                 //     // border: TableBorder.all(color: Colors.black, width: 1.5),
//                 //     children: [
//                 //       TableRow(
//                 //         decoration: const BoxDecoration(color: Colors.green),
//                 //         children: [
//                 //           Text('สถานะ : ปิดบัญชี',
//                 //               style: TextStyle(
//                 //                   fontWeight: FontWeight.bold,
//                 //                   fontSize: 20,
//                 //                   color: Colors.white)),
//                 //           SizedBox(
//                 //             height: 40,
//                 //           ),
//                 //         ],
//                 //       ),
//                 //       TableRow(children: [
//                 //         TableCell(
//                 //           child: SizedBox(
//                 //             height: 5,
//                 //           ),
//                 //         ),
//                 //         TableCell(
//                 //           child: SizedBox(
//                 //             height: 5,
//                 //           ),
//                 //         ),
//                 //       ]),
//                 //       TableRow(
//                 //         children: [
//                 //           Text(' นายเอ',
//                 //               style: TextStyle(
//                 //                 fontSize: 18,
//                 //               )),
//                 //           Text('งวด 36/36   0 บาท'),
//                 //         ],
//                 //       ),
//                 //       TableRow(
//                 //         children: [
//                 //           Text(' นายบี',
//                 //               style: TextStyle(
//                 //                 fontSize: 18,
//                 //               )),
//                 //           Text('งวด 36/36   0 บาท'),
//                 //         ],
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//                 // SizedBox(
//                 //   height: 20,
//                 // ),
//                 // Container(
//                 //   height: 1,
//                 //   width: double.maxFinite,
//                 //   color: Colors.grey.withOpacity(0.5),
//                 // ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Table(
//                     // border: TableBorder.all(color: Colors.black, width: 1.5),
//                     children: [
//                       TableRow(
//                         children: [
//                           Text("เงื่อนไขการค้ำประกัน",
//                               style: TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.blue)),
//                         ],
//                       ),
//                       TableRow(
//                         children: [
//                           Text(
//                             ' 1.การค้ำประกันบุคคลไม่เกิน 3 ราย และ/หรือ ไม่เกิน 5 สัญญา    ',
//                           ),
//                         ],
//                       ),
//                       TableRow(
//                         children: [
//                           Text(
//                             ' 2.การค้ำประกัน สูงสุดได้ไม่เกิน 8 ล้านบาท และจะต้องมีเงินเดือนคงเหลือไม่ต่ำกว่า 10% ของเงินเดือน',
//                           ),
//                         ],
//                       ),
//                       TableRow(
//                         children: [
//                           Text(
//                             ' 3.การค้ำประกันต้องมีอายุงานคงเหลือไม่น้อยกว่าระยะเวลาในการชำระหนี้ของผู้กู้',
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
