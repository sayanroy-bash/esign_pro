import 'package:demo_sdk/demo_sdk.dart';
import 'package:demo_sdk/resources/colors.dart';
import 'package:demo_sdk/view/widgets/app_button.dart';
import 'package:demo_sdk/view/widgets/discard_dialog.dart';
import 'package:flutter/material.dart';

class DraftListView extends StatefulWidget {
  const DraftListView({super.key});

  @override
  State<DraftListView> createState() => _DraftListViewState();
}

enum Options { edit, delete }

class _DraftListViewState extends State<DraftListView> {
  ScrollController scrollController = ScrollController();
  bool isLoading = false;
  int currentPage = 1;

  @override
  void initState() {
    //added the pagination function with listener
    fetchDraftList();
    scrollController.addListener(pagination);
    super.initState();
  }

  final ESignViewModel eSignProSDK = ESignViewModel();

  List<DraftData> draftList = [];
  late DraftRespoModel draftRespo;

  fetchDraftList() async {
    try {
      setState(() {
        isLoading = true;
      });
      var fetchDraftResponseData = await eSignProSDK.fetchDraftList(limit: 20, page: currentPage);
      if (fetchDraftResponseData.status == Status.error) {
        eSignProSDK.displayMessage(context, fetchDraftResponseData.message.toString());
        print(fetchDraftResponseData.message);
      } else if (fetchDraftResponseData.status == Status.completed) {
        draftRespo = fetchDraftResponseData.data!;
        draftList.addAll(fetchDraftResponseData.data!.data);
      }
      setState(() {
        isLoading = false;
      });
    } catch (ex) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void pagination() {
    if ((scrollController.position.pixels == scrollController.position.maxScrollExtent) && (draftList.length < int.parse(draftRespo.totalCount))) {
      setState(() {
        isLoading = true;
        currentPage += 1;
        fetchDraftList();
        //add api for load the more data according to new page
      });
    }
  }

  PopupMenuItem _buildPopupMenuItem(String title, IconData iconData, int position) {
    return PopupMenuItem(
      value: position,
      child: Row(
        children: [
          Icon(
            iconData,
            color: AppColor.textSecondaryColor,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: AppColor.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  delete(index) async {
    try {
      showLoader(context);
      var deleteESignData = await eSignProSDK.eSignProDeleteFlow(
        documentId: draftList[index].documentId,
      );
      if (deleteESignData.status == Status.error) {
        eSignProSDK.displayMessage(context, deleteESignData.message.toString());
      } else if (deleteESignData.status == Status.completed) {
        eSignProSDK.displayMessage(context, deleteESignData.data!.message.toString());
        draftList.removeAt(index);
        setState(() {});
      }
      Navigator.pop(context);
    } catch (ex) {
      print(ex);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Draft of E-sign"),
      ),
      body: (currentPage == 1 && isLoading)
          ? Center(child: CircularProgressIndicator())
          : (draftList.length == 0)
              ? Center(
                  child: Text(
                    "No Draft",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColor.textSecondaryColor,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(15),
                  shrinkWrap: true,
                  itemCount: draftList.length,
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 12),
                          child: ListTile(
                              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: AppColor.textSecondaryColor, width: 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              title: Text(
                                draftList[index].documentName,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColor.textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: PopupMenuButton(
                                child: Container(
                                  height: 36,
                                  width: 48,
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.more_vert,
                                    color: AppColor.textSecondaryColor,
                                  ),
                                ),
                                onSelected: (value) async {
                                  print(value);
                                  if (value == 0) {
                                    //Edit
                                    //print(draftList[index].);
                                    eSignProSDK.eSignProEditFlow(context,
                                        documentId: draftList[index].documentId, documentName: draftList[index].documentName);
                                  } else {
                                    //Delete
                                    try {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) => DeleteDialog(
                                          yes: () async {
                                            Navigator.pop(context);
                                            delete(index);
                                          },
                                          no: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      );
                                    } catch (ex) {
                                      Navigator.pop(context);
                                    }
                                  }
                                },
                                itemBuilder: (ctx) => [
                                  _buildPopupMenuItem('Edit', Icons.edit_note, Options.edit.index),
                                  _buildPopupMenuItem('Delete', Icons.delete, Options.delete.index),
                                ],
                              )),
                        ),
                        if (draftList.length - 1 == index && isLoading) CircularProgressIndicator()
                      ],
                    );
                  },
                ),
    );
  }
}
