// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:flutter/material.dart';
// import '../controller/authen_controller.dart';
// import '../model/authen_model.dart';
// import '../service/authen_service.dart';
// import '/home.dart';

// class LoanTranPage extends StatefulWidget {
//   static const routeName = '/';

//   const LoanTranPage({Key? key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() {
//     return _LoanTranPageState();
//   }
// }

// List<GDPData> getChartData(_num1, _num2) {
//   final List<GDPData> chartData = [
//     GDPData('Avalable', _num1),
//     GDPData('Pay', _num2),
//   ];
//   return chartData;
// }

// class GDPData {
//   GDPData(this.continent, this.num);
//   final String continent;
//   final double num;
// }

// class _LoanTranPageState extends State<LoanTranPage> {
//   int _selectedItemIndex = 2;
//   late List<GDPData> _chartData;
//   late TooltipBehavior _tooltipBehavior;
//   final oCcy = new NumberFormat("#,##0.00", "en_US");
//   final _pageController = PageController();
//   bool isLoading = false;
//   List<ProfileTransactionModel> profileTran_loan = List.empty();
//   AuthenController controller = AuthenController(AuthenServices());
//   AuthenModel? model;

//   @override
//   void initState() {
//     double accAvalable = context.read<LoansAccountModel>().accAvalable;
//     double accBalance = context.read<LoansAccountModel>().accBalance;
//     double accLimit = context.read<LoansAccountModel>().accLimit;
//     int proID = context.read<LoansAccountModel>().proID;
//     _chartData = getChartData(accAvalable, accBalance);
//     _tooltipBehavior = TooltipBehavior(enable: true);
//     super.initState();

//     print(' initState() LoanTranPage');

//     controller.onSync.listen((bool syncState) => setState(() {
//           isLoading = syncState;
//         }));

//     var empCode = context.read<ProfilesAPIModel>().empCode.toString();
//     _getProfileTranloan(empCode, proID);
//   }

//   Future<List<ProfileTransactionModel>> _getProfileTranloan(
//       _empcode, _proID) async {
//     print(_empcode);
//     var getToken = await controller.getToken();
//     setState(() => model = getToken);
//     var response =
//         await controller.getProfileTran_Deposit(model!.token, _empcode, _proID);

//     setState(() => profileTran_loan = response);
//     print("profileTran_loan ${profileTran_loan.length}");
//     return profileTran_loan;
//   }

//   @override
//   Widget get bodyTransactions => isLoading
//       ? Center(child: CircularProgressIndicator())
//       : ListView.builder(
//           itemCount: profileTran_loan.isNotEmpty ? profileTran_loan.length : 1,
//           itemBuilder: (context, index) {
//             var col;
//             if (profileTran_loan.isNotEmpty) {
//               col = Colors.white;
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
//                     height: 60,
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 Icon(
//                                   Icons.transfer_within_a_station,
//                                   color: Color(0xFF00B686),
//                                 ),
//                                 Text(
//                                   profileTran_loan[index].payDate,
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                                 Text(
//                                   'ชำระ' + profileTran_loan[index].proName,
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Text(
//                                   ' + ${profileTran_loan[index].amount}',
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
//                   Text('Tab button to fetch transection'),
//                 ],
//               );
//             }
//           });

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('บัญชี : ${context.read<LoansAccountModel>().proName} '),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.menu),
//             onPressed: () => Navigator.pushNamed(context, '/main'),
//           )
//         ],
//       ),
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   // padding: EdgeInsets.symmetric(horizontal: 20),
//                   // height: 350,
//                   // decoration: BoxDecoration(
//                   //   color: Colors.white38,
//                   //   borderRadius: BorderRadius.circular(16.0),
//                   //   border: Border.all(width: 1.5, color: Colors.black38),
//                   // ),

//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Text(
//                           'ยอดเงินต้นคงเหลือ ${oCcy.format(context.read<LoansAccountModel>().accAvalable)}  บาท',
//                           style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.blue)),
//                       Text(
//                           'จากยอดกู้ ${oCcy.format(context.read<LoansAccountModel>().accLimit)} บาท',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black54)),
//                       SfCircularChart(
//                         legend: Legend(
//                             isVisible: true,
//                             overflowMode: LegendItemOverflowMode.wrap),
//                         palette: const <Color>[Colors.blue, Color(0XFF00B686)],
//                         tooltipBehavior: _tooltipBehavior,
//                         series: <CircularSeries>[
//                           DoughnutSeries<GDPData, String>(
//                             dataSource: _chartData, explodeIndex: 0,
//                             xValueMapper: (GDPData data, _) => data.continent,
//                             yValueMapper: (GDPData data, _) => data.num,
//                             dataLabelSettings:
//                                 DataLabelSettings(isVisible: true),
//                             enableTooltip: true,
//                             // maximumValue: 100000
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 height: 300,
//                 width: 400,
//                 child: PageView(
//                   controller: _pageController,
//                   scrollDirection: Axis.horizontal,
//                   children: [bodyTransactions],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   GestureDetector buildNavBarItem(IconData icon, int index) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedItemIndex = index;
//         });
//       },
//       child: Container(
//         width: MediaQuery.of(context).size.width / 5,
//         height: 60,
//         decoration: index == _selectedItemIndex
//             ? BoxDecoration(
//                 border:
//                     Border(bottom: BorderSide(width: 4, color: Colors.green)),
//                 gradient: LinearGradient(colors: [
//                   Colors.green.withOpacity(0.3),
//                   Colors.green.withOpacity(0.016),
//                 ], begin: Alignment.bottomCenter, end: Alignment.topCenter))
//             : BoxDecoration(),
//         child: Icon(
//           icon,
//           color: index == _selectedItemIndex ? Color(0XFF00B868) : Colors.grey,
//         ),
//       ),
//     );
//   }

//   Container buildCategoryCard(
//       IconData icon, String date, String title, String amount, int percentage) {
//     return Container(
//       padding: EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.white,
//       ),
//       height: 60,
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Icon(
//                     icon,
//                     color: Color(0xFF00B686),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text(
//                     date,
//                     style: TextStyle(
//                       fontSize: 14,
//                     ),
//                   ),
//                   Text(
//                     title,
//                     style: TextStyle(
//                       fontSize: 18,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Text(
//                     "$amount",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   GestureDetector buildActivityButton(
//       IconData icon, String title, Color backgroundColor, Color iconColor) {
//     return GestureDetector(
//       onTap: () => Navigator.of(context).push(
//           MaterialPageRoute(builder: (BuildContext context) => HomePage())),
//       child: Container(
//         margin: EdgeInsets.all(10),
//         height: 90,
//         width: 90,
//         decoration: BoxDecoration(
//             color: backgroundColor, borderRadius: BorderRadius.circular(10.0)),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               icon,
//               color: iconColor,
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Text(
//               title,
//               style:
//                   TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
