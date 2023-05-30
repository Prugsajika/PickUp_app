// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:wesaving_app/controller/authen_controller.dart';
// import 'package:intl/intl.dart';
// import 'package:wesaving_app/page/loan_transaction.dart';
// import '../model/authen_model.dart';
// import '../service/authen_service.dart';

// class LoanAccountPage extends StatefulWidget {
//   @override
//   State<LoanAccountPage> createState() => _LoanAccountPage();
// }

// class _LoanAccountPage extends State<LoanAccountPage> {
//   final _pageController = PageController();
//   final oCcy = new NumberFormat("#,##0.00", "en_US");
//   bool isLoading = false;
//   List<LoanAccountModel> loansAcc = List.empty();
//   AuthenController controller = AuthenController(AuthenServices());
//   AuthenModel? model;
//   @override
//   void initState() {
//     super.initState();
//     controller.onSync.listen((bool syncState) => setState(() {
//           isLoading = syncState;
//         }));
//     var empCode = context.read<ProfilesAPIModel>().empCode.toString();
//     print(empCode);
//     _getLoanAccount(empCode);
//   }

//   Future<List<LoanAccountModel>> _getLoanAccount(_empcode) async {
//     print(_empcode);
//     var getToken = await controller.getToken();
//     setState(() => model = getToken);
//     var response = await controller.getLoanAccount(model!.token, _empcode);

//     setState(() => loansAcc = response);
//     print("loansAcc ${loansAcc.length}");

//     return loansAcc;
//   }

//   Widget get bodyTransactions => isLoading
//       ? Center(child: CircularProgressIndicator())
//       : ListView.builder(
//           itemCount: loansAcc.isNotEmpty ? loansAcc.length : 1,
//           itemBuilder: (context, index) {
//             var col;
//             if (loansAcc.isNotEmpty) {
//               col = Colors.white;
//               return Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: InkWell(
//                   onTap: () {
//                     setState(() {
//                       context.read<LoansAccountModel>()
//                         ..accID = loansAcc[index].accID
//                         ..accBalance = loansAcc[index].accBalance
//                         ..accLimit = loansAcc[index].accLimit
//                         ..accAvalable = loansAcc[index].accAvalable
//                         ..accAmount = loansAcc[index].accAmount
//                         ..proID = loansAcc[index].proID
//                         ..procode = loansAcc[index].procode
//                         ..proName = loansAcc[index].proName
//                         ..proInterest = loansAcc[index].proInterest
//                         ..empcode = loansAcc[index].empcode
//                         ..accStartDate = loansAcc[index].accStartDate
//                         ..accEndDate = loansAcc[index].accEndDate
//                         ..isActive = loansAcc[index].isActive
//                         ..updateBy = loansAcc[index].updateBy
//                         ..updateDate = loansAcc[index].updateDate;
//                     });

//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => LoanTranPage(),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     padding: EdgeInsets.all(15),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: col.withOpacity(0.25),
//                     ),
//                     height: 120,
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
//                                   ' (' + loansAcc[index].procode + ') ',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                                 Text(
//                                   ' บัญชี' + loansAcc[index].proName,
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Icon(
//                                   Icons.keyboard_arrow_right,
//                                   color: Colors.deepOrange,
//                                   size: 30.0,
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
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Text(
//                                   ' ยอดชำระ',
//                                 )
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Text(
//                                   ' ${oCcy.format(loansAcc[index].accAmount)}',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                   ),
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
//                                 Text(' ยอดเงินคงเหลือ'),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Text(
//                                   ' ${oCcy.format(loansAcc[index].accAvalable)}',
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     color: Color(0xFF00B686),
//                                   ),
//                                 ),
//                               ],
//                             )
//                           ],
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
//                   Text(' ไม่พบรายการบัญชีเงินกู้'),
//                 ],
//               );
//             }
//           });

//   Widget build(BuildContext context) {
//     // _getCards();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('บัญชีสินเชื่อ '),
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 30,
//               ),
//               Container(
//                 height: 450,
//                 child: PageView(
//                   controller: _pageController,
//                   scrollDirection: Axis.horizontal,
//                   children: [bodyTransactions],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
