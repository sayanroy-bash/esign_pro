import 'dart:convert';

import 'package:demo_sdk/demo_sdk.dart';
import 'package:demo_sdk/view/widgets/app_button.dart';
import 'package:demo_sdk/view/widgets/json_editor_widget.dart';
import 'package:demo_sdk/view/widgets/text_form_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdvanceJsonView extends StatefulWidget {
  const AdvanceJsonView({super.key});

  @override
  State<AdvanceJsonView> createState() => _AdvanceJsonViewState();
}

enum Editors { text, tree }

class _AdvanceJsonViewState extends State<AdvanceJsonView> {
  @override
  TextEditingController controller = TextEditingController()..text = stringifyData("", 0, true);
  List<Editors> editors = const [Editors.text, Editors.tree];
  TextEditingController nameController = TextEditingController();
  List<String> stepsList = [];
  List<String> flowList = [
    "Initialization with Theming",
    "New e-sign Flow",
    "E-Sign Gateway Flow",
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadJsonFiles();
    });
    selectedFlow = flowList[0];
    //jsonData = step1;
  }

  loadJsonFiles() async {
    final assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    final jsonAssetsList = assetManifest.listAssets().where((string) => string.startsWith("assets/jsonData/")).toList();
    print(jsonAssetsList);
    for (var jsonList in jsonAssetsList) {
      var fileName = jsonList.split('/').last;
      stepsList.add(fileName);
    }
    if (stepsList.length > 0) {
      String jsonString = await rootBundle.loadString('assets/jsonData/${stepsList[0]}');
      controller.text = stringifyData(jsonDecode(jsonString), 0, true);
      selectedFile = stepsList[0];
    }
    setState(() {});
  }

  setJsonData(value) async {
    String jsonString = await rootBundle.loadString('assets/jsonData/${value}').then((value){
      print(value);
      return value;
    });
    selectedFile = value;
    controller.text = stringifyData(jsonDecode(jsonString), 0, true);
    print(controller.text);
  }

  String selectedFile = "";
  String selectedFlow = "";
  void copyData() async {
    await Clipboard.setData(
      ClipboardData(text: controller!.text),
    );
  }

  bool onError = false;
  final ESignViewModel eSignProSDK = ESignViewModel();
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            title: Text("Advanced JSON Editor"),
            actions: [
              // InkWell(
              //   onTap: copyData,
              //   child: const Tooltip(
              //     message: 'Copy',
              //     child: Icon(Icons.copy, size: 20),
              //   ),
              // ),
              // onError
              //     ? SizedBox.shrink()
              //     : PopupMenuButton<Editors>(
              //         initialValue: _editor,
              //         tooltip: 'Change editor',
              //         padding: EdgeInsets.zero,
              //         onSelected: (value) {
              //           setState(() {
              //             _editor = value;
              //           });
              //         },
              //         position: PopupMenuPosition.under,
              //         enabled: editors.length > 1,
              //         constraints: const BoxConstraints(
              //           minWidth: 50,
              //           maxWidth: 150,
              //         ),
              //         itemBuilder: (context) {
              //           return <PopupMenuEntry<Editors>>[
              //             PopupMenuItem<Editors>(
              //               height: _popupMenuHeight,
              //               padding: const EdgeInsets.symmetric(horizontal: 12),
              //               enabled: editors.contains(Editors.tree),
              //               value: Editors.tree,
              //               child: const Text("Tree"),
              //             ),
              //             PopupMenuItem<Editors>(
              //               height: _popupMenuHeight,
              //               padding: const EdgeInsets.symmetric(horizontal: 12),
              //               enabled: editors.contains(Editors.text),
              //               value: Editors.text,
              //               child: const Text("Text"),
              //             ),
              //           ];
              //         },
              //         child: Row(
              //           mainAxisSize: MainAxisSize.min,
              //           children: [
              //             Text(
              //               _editor.name,
              //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              //             ),
              //             const Icon(Icons.arrow_drop_down, size: 20),
              //           ],
              //         ),
              //       ),
            ],
          ),
          body: stepsList.length > 0
              ? ListView(
                  primary: true,
                  padding: EdgeInsets.all(15),
                  shrinkWrap: true,
                  children: [
                    DropDownTextField(
                      hint: Text("Select Flow"),
                      isDense: true,
                      borderRadius: 0,
                      value: flowList[0],
                      items: flowList
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        selectedFlow = value!;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DropDownTextField(
                      hint: Text("Select Steps"),
                      isDense: true,
                      borderRadius: 0,
                      value: stepsList[0],
                      items: stepsList
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setJsonData(value);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.68,
                      child: JsonEditorWidget(
                        controller: controller,
                        onError: onError,
                        onChanged: (value) {
                          //controller.text = value.toString().replaceAll('”', '"');
                          //jsonoStep1 = value;
                          // setState(() {});
                          //”
                        },
                        //json: jsonEncode(jsonData),
                      ),
                    ),
                    // Row(
                    //   children: [
                    SizedBox(
                      height: 10,
                    ),
                    AppButton(
                      'Execute',
                      () {
                        try {
                          if (selectedFlow == "Initialization with Theming") {
                            eSignProSDK
                                .initializeSDK(context, "syedam@moneymul.com", "Test@123", brandingData: jsonDecode(controller.text))
                                .then((value) {
                              if (value.status == 200) {
                                eSignProSDK.eSignProFlow(
                                  context,
                                );
                              }
                            });
                          } else if (selectedFlow == "New e-sign Flow") {
                            eSignProSDK.eSignProFlow(context, requestData: jsonDecode(controller.text));
                          } else if (selectedFlow == "E-Sign Gateway Flow") {
                            eSignProSDK.eSignProGatewayFlowInitialize(context, requestData: jsonDecode(controller.text));
                          }
                          // var fileName = selectedFile.split('.').first;
                          // if (fileName.toLowerCase().contains("step1")) {
                          //   print("step1");
                          //   eSignProSDK.eSignProFlow(context, step1: jsonDecode(controller.text));
                          // } else if (fileName.toLowerCase().contains("step2")) {
                          //   print("step2");
                          //   eSignProSDK.eSignProFlow(context, step2: jsonDecode(controller.text));
                          // } else if (fileName.toLowerCase().contains("step3")) {
                          //   eSignProSDK.eSignProFlow(context, step3: jsonDecode(controller.text));
                          // } else if (fileName.toLowerCase().contains("step4")) {
                          //   print("step4");
                          //   eSignProSDK.eSignProFlow(context, step4: jsonDecode(controller.text));
                          // } else if (fileName.toLowerCase().contains("step5")) {
                          //   print("step5");
                          //   eSignProSDK.eSignProFlow(context, step5: jsonDecode(controller.text));
                          // } else {
                          //   eSignProSDK.displayMessage(context, "Json File not match with JSON");
                          // }
                        } catch (ex) {
                          eSignProSDK.displayMessage(context, ex.toString());
                        }
                        // eSignProSDK.eSignProFlow(
                        //   context,
                        // );
                      },
                      isLoading: false,
                      textStyle: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    //     // SizedBox(
                    //     //   width: 10,
                    //     // ),
                    //     // Expanded(
                    //     //     child: AppButton(
                    //     //   'Formatting',
                    //     //   () async {
                    //     //     controller!.text = stringifyData(jsonDecode(controller!.text), 0, true);
                    //     //     // setState(() {});
                    //     //   },
                    //     //   isLoading: false,
                    //     //   textStyle: TextStyle(fontSize: 16, color: Colors.black),
                    //     // )),
                    //   ],
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )
              : Text("PLease add json file in assets")),
    );
  }
}
