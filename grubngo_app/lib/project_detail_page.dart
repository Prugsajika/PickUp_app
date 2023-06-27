// import 'package:flutter/material.dart';
// import 'package:m_pam/providers/user_provider.dart';
// import 'package:m_pam/services/appl_appraisal_service.dart';
// import 'package:m_pam/services/appl_document_service.dart';
// import 'package:m_pam/services/application_service.dart';
// import 'package:m_pam/services/parameter_service.dart';
// import 'package:provider/provider.dart';

// import '../../models/appl_document_model.dart';
// import '../../models/application_model.dart';
// import '../../models/appraisal_company_model.dart';
// import '../../providers/list_appl_document_provider.dart';
// import '../../providers/list_appl_provider.dart';
// import '../../services/activity_service.dart';
// import '../../widgets/activity_timeline_widget.dart';
// import '../../widgets/appbar.dart';
// import '../../widgets/project_detail_widget.dart';
// import '../../widgets/success_page.dart';
// import 'document_list_page.dart';

// class DocumentCheckProjectDetailPage extends StatefulWidget {
//   final int applID;

//   DocumentCheckProjectDetailPage({
//     super.key,
//     required this.applID,
//   });

//   @override
//   State<DocumentCheckProjectDetailPage> createState() =>
//       _DocumentCheckProjectDetailPageState();
// }

// class _DocumentCheckProjectDetailPageState
//     extends State<DocumentCheckProjectDetailPage> {
//   String userCode = "";
//   List<String> allowDoc = ["01", "02", "03", "04", "99"];
//   final _formKey = GlobalKey<FormState>();
//   String _remark = "";
//   String activityToClick = "";
//   /* Following here : ประกาศตัวแปร */
//   String? _assessmentCompany = null;
//   List<DropdownMenuItem<String>> _ddlAssessmentCompany = [];
//   /* Following here : ประกาศตัวแปร */

//   getAppraisalCompany() async {
//     List<GetAppraisalCompanyResponseModel> listApprComp =
//         await ParameterService().GetApprisalCompary(widget.applID);

//     /* Following here : เอาค่าเข้า dropdownlist */
//     listApprComp.forEach((e) {
//       _ddlAssessmentCompany.add(
//           DropdownMenuItem(child: Text(e.apprCompName), value: e.apprCompCode));
//     });
//     /* Following here : เอาค่าเข้า dropdownlist */

//     setState(() {});
//   }

//   void initState() {
//     userCode = context.read<UserProvider>().data.username!;

//     final applDocProvider =
//         Provider.of<ListApplDocumentProvider>(context, listen: false);
//     applDocProvider.getDocs(widget.applID, userCode, allowDoc);
//     getAppraisalCompany();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
//       child: Scaffold(
//         appBar: MPamAppBar(title: "ตรวจเอกสาร จ่ายงานประเมิน"),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Form(
//               key: _formKey,
//               child: Consumer<ListApplDataProvider>(
//                 builder: (context, value, child) {
//                   var applInfo = value.applData
//                       .where((element) => element.applID == widget.applID)
//                       .first;
                  
//                 /* Following here : Consumer ค่าจาก db เป็น default */
//                   _assessmentCompany = applInfo.appraisalCompanyCode;
//                 /* Following here : Consumer ค่าจาก db เป็น default */
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       project_detail_widget(title: "รายละเอียดโครงการ", applID: widget.applID,),
//                       Card(
//                         child: Column(
//                           children: [
//                             ListTile(
//                               onTap: () async {
//                                 bool? _checkresult = await Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             DocumentCheckDocListPage()));

//                                 setState(() {});
//                               },
//                               leading: context
//                                           .read<ListApplDocumentProvider>()
//                                           .applDoc
//                                           .where((element) =>
//                                               element.verifyFlag == null)
//                                           .length >
//                                       0
//                                   ? Icon(
//                                       Icons.warning,
//                                       color: Colors.orangeAccent,
//                                     )
//                                   : Icon(
//                                       Icons.check_circle_rounded,
//                                       color: Colors.teal,
//                                     ),
//                               title: Text('ตรวจสอบเอกสาร'),
//                               trailing: Icon(Icons.arrow_forward_ios),
//                             ),
//                             const Divider(),
//                             ActivityTimelineWidget(applID: widget.applID),
//                           ],
//                         ),
//                       ),
//                       Card(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: DropdownButtonFormField(
//                             hint: Text(" - กรุณาเลือกบริษัทประเมิน - "),
//                             decoration: InputDecoration(
//                               labelText: 'บริษัทประเมิน',
//                             ),
//                             /* Following here : set default value */
//                             value: _assessmentCompany, 
//                             /* Following here : set default value */
//                             /* Following here : set dropdownlist จากบรรทัดที่52 */
//                             items: _ddlAssessmentCompany,
//                             /* Following here : set dropdownlist จากบรรทัดที่52 */
//                             onChanged: (String? value) {
//                               _assessmentCompany = value;
//                             },
//                             validator: (value) {
//                               if (activityToClick == "F" &&
//                                   (value == null || value == "")) {
//                                 return "กรุณาเลือกบริษัทประเมิน";
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       Text("ความเห็น/ข้อเสนอแนะ",
//                           style:
//                               TextStyle(color: Colors.black87, fontSize: 16)),
//                       Card(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               TextFormField(
//                                 maxLength: 200,
//                                 maxLines: 5,
//                                 initialValue: _remark.toString(),
//                                 decoration: InputDecoration(
//                                   hintText: "ความเห็น/ข้อเสนอแนะ",
//                                   counter: Offstage(),
//                                 ),
//                                 keyboardType: TextInputType.text,
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return "กรุณาระบุ ความเห็น/ข้อเสนอแนะ";
//                                   }
//                                   return null;
//                                 },
//                                 onChanged: (value) {
//                                   _remark = value;
//                                 },
//                                 onSaved: (value) {
//                                   _remark = value!;
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//         bottomNavigationBar: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: [
//               Expanded(
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.redAccent),
//                   onPressed: context
//                               .read<ListApplDocumentProvider>()
//                               .applDoc
//                               .where((e) => e.verifyFlag == null)
//                               .length >
//                           0
//                       ? null
//                       : () async {
//                           activityToClick = "B";
//                           if (_formKey.currentState!.validate()) {
//                             List<VerifyApplDocumentRequestModel> verifyList =
//                                 getDocVerifyModel();
//                             await ApplDocumentService()
//                                 .verifyDocument(verifyList);

//                             await ActivityService().updateNextActivity(
//                                 widget.applID,
//                                 activityToClick,
//                                 _remark,
//                                 userCode);

//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => SuccessPage(isForward: false, title: "ส่งกลับเพื่อแก้ไข")));
//                           }
//                         },
//                   child: Text(
//                     "ส่งแก้ไข",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               Expanded(
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: Theme.of(context).primaryColor),
//                   onPressed: context
//                               .read<ListApplDocumentProvider>()
//                               .applDoc
//                               .where((e) =>
//                                   (e.verifyFlag == "N" || e.verifyFlag == null))
//                               .length >
//                           0
//                       ? null
//                       : () async {
//                           activityToClick = "F";
//                           if (_formKey.currentState!.validate()) {
//                             List<VerifyApplDocumentRequestModel> verifyList =
//                                 getDocVerifyModel();
//                             await ApplDocumentService()
//                                 .verifyDocument(verifyList);

//                             await ApplicationService().updateAppraisalCompany(
//                                 UpdateAppraisalCompanyRequestModel(
//                                     widget.applID,
//                                     _assessmentCompany!,
//                                     userCode));

//                             await ActivityService().updateNextActivity(
//                                 widget.applID,
//                                 activityToClick,
//                                 _remark,
//                                 userCode);

//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         SuccessPage(isForward: true, title: "ตรวจเอกสาร จ่ายงานประเมิน",)));
//                           }
//                         },
//                   child: Text(
//                     "ส่งประเมิน",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   List<VerifyApplDocumentRequestModel> getDocVerifyModel() {
//     List<GetApplDocumentResponseModel> applDoc =
//         context.read<ListApplDocumentProvider>().applDoc;

//     List<VerifyApplDocumentRequestModel> verifyList = [];
//     applDoc.forEach((element) {
//       verifyList.add(VerifyApplDocumentRequestModel(element.applID!,
//           element.docTypeCode!, element.verifyFlag!, userCode));
//     });
//     return verifyList;
//   }
// }
