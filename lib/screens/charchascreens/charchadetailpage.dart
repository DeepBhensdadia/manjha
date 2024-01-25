import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:manjha/const.dart';
import 'package:manjha/model/charcharesponse.dart';
import 'package:manjha/model/getfourmdetailsresponse.dart';
import 'package:manjha/screens/charchascreens/charchascreen.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:manjha/services/apiconst.dart';
import 'package:manjha/widget/textfieldscreen.dart';
import 'package:manjha/widget/textstyle.dart';

class ForumDetailPage extends StatefulWidget {
  Forum _forumItem;
  ForumTypeLabel label;

  @override
  ForumDetailPage(this._forumItem, this.label);

  @override
  _ForumDetailPageState createState() => _ForumDetailPageState();
}

class _ForumDetailPageState extends State<ForumDetailPage> {
  TextEditingController answerController = new TextEditingController();

  List<ForumDetailItem> list = [];
  var isFirstLoading = true;

  getcharchadetail() {
    getfourmdetails(fourmid: widget._forumItem.id.toString())
        .then((value) {
    setState(() {
      list = value.data ?? [];
      isFirstLoading =false;
    });

    })
        .onError((error, stackTrace) {
      print(error);
    });
  }

  @override
  void initState() {
    getcharchadetail();
    super.initState();
  }

  List<Widget> getNoRecord() {
    return [
      Divider(),
      Container(
          //height: 100,
          // padding: EdgeInsets.all(8.0),
          width: double.infinity,
          child: Card(
              elevation: 0,
              child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child:
                      NormalText("Be the first to comment.", kdarkBlue, 18.0))))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFE6E6E6),
        appBar: AppBar(
          // iconTheme: IconThemeData(color: kblack),
          backgroundColor: kheader,
          title: NormalText(
              widget._forumItem == null
                  ? widget.label.myPageTitle
                  : widget._forumItem.question ?? "",
              kwhite,
              20),
          centerTitle: false,
          // elevation: 2.0,
        ),
        // floatingActionButton: new FloatingActionButton(
        //     elevation: 0.0,
        //     foregroundColor: kwhite,
        //     child: new Icon(Icons.add),
        //     backgroundColor: kheader,
        //     onPressed: () {
        //       this._showDialog();
        //       // Fluttertoast.showToast(msg: ('Add New'));
        //     }),
        body: isFirstLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                children: [
                  populateItem(this.widget._forumItem),
                ],
              )
                // Column(
                //     children: list.length == 0
                //         ? this.getNoRecord()
                //         : list.map((forumDetailItem) {
                //             return populateSubItem(forumDetailItem);
                //           }).toList()),
                ));
  }

  Padding populateItem(Forum forumItem) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 8, 0, 4), //const EdgeInsets.all(8.0),
        child: InkWell(
            onTap: () async {
              print(forumItem.question);
              // Fluttertoast.showToast(msg: (forumItem.question));
              // bool blnResponse =
              //     await Navigator.push(context, MaterialPageRoute(builder: (_) {
              //   return ForumDetailPage(forumItem, this.widget.label);
              // }));
              // print('arjun' + blnResponse.toString());
              // if (blnResponse != null && blnResponse) {
              //   this._fetchData();
              // }
            },
            child: Container(
                //height: 100,
                width: double.infinity,
                child: Card(
                  margin: EdgeInsets.all(0),
                  // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fitWidth,
                                        image: NetworkImage(
                                            forumItem.getCustomerPhoto())),
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BoldText(
                                      forumItem.customerName ?? "", 18, kblack),
                                  NormalText(forumItem.getFormattedDate(),
                                      kgreyDark, 14),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(forumItem.question ?? "",
                              style:
                                  TextStyle(fontSize: 16.0, color: kgreyDark)),
                          //  SizedBox(height: 10),
                          forumItem.hasDescription()
                              ? ExpandableText(forumItem.description ?? "")
                              : Container(),
                          forumItem.hasImage()
                              ? Container(
                                  height: 180,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fitWidth,
                                          image: NetworkImage(
                                              forumItem.getImageURL())),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0))),
                                  // child: Image(
                                  //     image: NetworkImage(
                                  //         'https://manjha.in/public/news/1621076362.png')),
                                )
                              : Container(),
                          // Divider(),
                          SizedBox(height: 10),
                          populateCommentBox(),
                          SizedBox(height: 10),
                          Column(
                              children: list.length == 0
                                  ? this.getNoRecord()
                                  : list.map((forumDetailItem) {
                                      return populateSubItem(forumDetailItem);
                                    }).toList()),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: [
                          //     Column(children: [
                          //       IconButton(
                          //         icon: Icon(
                          //             forumItem.isLiked()
                          //                 ? FontAwesomeIcons.solidThumbsUp
                          //                 : FontAwesomeIcons.thumbsUp,
                          //             color: kgreyDark),
                          //         onPressed: () {
                          //           this._fetchLikeUnLike(forumItem.id);
                          //         },
                          //       ),
                          //       NormalText(forumItem.getLikes(), kgreyDark, 12),
                          //     ]),
                          //     Column(children: [
                          //       IconButton(
                          //         icon: Icon(FontAwesomeIcons.comment,
                          //             color: kgreyDark),
                          //         onPressed: () {},
                          //       ),
                          //       NormalText(
                          //           forumItem.getComments(), kgreyDark, 12),
                          //     ]),
                          //     Column(children: [
                          //       IconButton(
                          //         icon: Icon(FontAwesomeIcons.shareAlt,
                          //             color: kgreyDark),
                          //         onPressed: () {},
                          //       ),
                          //       NormalText('Share', kgreyDark, 12),
                          //     ]),
                          //   ],
                          // )
                          // NormalText("28, Nov at 15:30 pm", kdarkBlue, 12),
                        ]),
                  ),
                ))));
  }

  Widget populateSubItem(ForumDetailItem forumDetailItem) {
    return Padding(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 4), //const EdgeInsets.all(8.0),
        child: InkWell(
            onTap: () {
              print(forumDetailItem.answer);
              // Fluttertoast.showToast(msg: (forumDetailItem.question));
            },
            child: Container(
                //height: 100,
                width: double.infinity,
                padding: EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: kgreyFill))),
                child: Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fitWidth,
                                        image: NetworkImage(forumDetailItem
                                            .getCustomerPhoto())),
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BoldText(
                                      forumDetailItem.getName(), 18, kblack),
                                  NormalText(forumDetailItem.getFormattedDate(),
                                      kgreyDark, 14),
                                ],
                              )),
                              (!forumDetailItem.isDeletePermission())
                                  ? SizedBox()
                                  : PopupMenuButton(
                                      icon: Icon(Icons.more_vert),
                                      onSelected: (value) {
                                        // if (value == 'delete') {
                                        //   this._fetchDelete(forumDetailItem.id);
                                        // }
                                      },
                                      itemBuilder: (context) => [
                                            const PopupMenuItem<String>(
                                              value: 'delete',
                                              child: Text('Delete'),
                                            ),
                                          ])
                            ],
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 58.0),
                            child: Text(forumDetailItem.answer ?? "",
                                style:
                                    TextStyle(color: kblack, fontSize: 16.0)),
                          ),
                        ]),
                  ),
                ))));
  }

  Widget populateCommentBox() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 8, 0, 4), //const EdgeInsets.all(8.0),
        child: Container(
            //height: 100,
            width: double.infinity,
            padding: EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: kgreyFill))),
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image:
                                  NetworkImage(widget.label.getProfilePhoto())),
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                        child: NormalForm(
                            null, this.widget.label.detailTextAnswerHint,
                            controller: answerController,
                            textInputType: TextInputType.multiline)),
                    MaterialButton(
                        child: Icon(FontAwesomeIcons.paperPlane,
                            color: kwhite, size: 18),
                        minWidth: 50,
                        color: kheader,
                        padding: EdgeInsets.fromLTRB(0, 0, 4, 4),
                        shape: CircleBorder(),
                        onPressed: () async {
                          // if (answerController.text.length == 0) {
                          //   EasyLoading.showToast('Please enter something.');
                          //   return;
                          // }
                          // await this._fetchAdd(
                          //     widget._forumItem.id, answerController.text);
                          // answerController.text = '';
                          // FocusScope.of(context).requestFocus(FocusNode());
                          // print('post');
                        }),
                  ],
                ),
              ),
            )));
  }

  _showDialog() async {
    TextEditingController _answerController = new TextEditingController();
    await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        title: new Text(this.widget.label.detailTextHeading),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                autofocus: true,
                controller: _answerController,
                decoration: new InputDecoration(
                    labelText: this.widget.label.detailTextAnswer,
                    hintText: this.widget.label.detailTextAnswerHint),
              ),
            )
          ],
        ),
        actions: <Widget>[
          MaterialButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              }),
          MaterialButton(
              child: const Text('Submit'),
              onPressed: () {
                // if (_answerController.text.length == 0) {
                //   EasyLoading.showToast("Please enter your answer.");
                //   return;
                // }
                // this._fetchAdd(widget._forumItem.id, _answerController.text);
                // // Fluttertoast.showToast(msg: "Answer has been submitted.");
                // Navigator.pop(context);
              })
        ],
      ),
    );
  }
}

class ExpandableText extends StatefulWidget {
  ExpandableText(this.text);

  final String text;
  bool isEnable = false;
  bool isExpanded = false;

  @override
  _ExpandableTextState createState() => new _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  @override
  Widget build(BuildContext context) {
    widget.isEnable = (widget.text.length > 50);
    return new Column(children: <Widget>[
      new ConstrainedBox(
          constraints: widget.isExpanded
              ? new BoxConstraints()
              : new BoxConstraints(maxHeight: 50.0),
          child: new Text(
            widget.text,
            softWrap: true,
            overflow: TextOverflow.fade,
            textAlign: TextAlign.left,
          )),
      !widget.isEnable
          ? new Container()
          : Align(
              alignment: Alignment.centerRight,
              child: new TextButton(
                  // : kheader,
                  // height: 30,
                  child: Text(widget.isExpanded ? 'read less' : 'read more'),
                  onPressed: () =>
                      setState(() => widget.isExpanded = !widget.isExpanded)),
            ) //widget.isExpanded = true
    ]);
  }
}
