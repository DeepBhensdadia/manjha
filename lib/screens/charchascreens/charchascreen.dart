import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:manjha/const.dart';
import 'package:manjha/getxcontrollers/charchacontroller.dart';
import 'package:manjha/model/charcharesponse.dart';
import 'package:manjha/screens/charchascreens/charchadetailpage.dart';
import 'package:manjha/services/apiconst.dart';
import 'package:manjha/widget/textstyle.dart';
import 'package:share_plus/share_plus.dart';
import '../../localconst.dart';
import 'charchaadd.dart';

class CharchaScreen extends StatefulWidget {
  ForumType forumType = ForumType.Forum;
  CharchaScreen(this.forumType);

  @override
  _CharchaScreenState createState() => _CharchaScreenState();
}

enum ForumType { Forum, Article }

class ForumTypeLabel {
  ForumType forumType = ForumType.Forum;
  late String forumPageTitle;
  late String forumAddButtonTitle;
  late String forumAddAnswerTitle;
  late String myPageTitle;
  late String myAddButtonTitle;
  late String myPageSubHeading;
  late String addPageTitle;
  late String addTextTitle;
  late String addTextDescription;

  late String detailPageTitle;
  late String detailTextHeading;
  late String detailTextAnswer;
  late String detailTextAnswerHint;

  String profilePhoto = '';
  bool hasProfilePhoto() {
    return (profilePhoto.isNotEmpty);
  }

  setProfilePhoto(String photo) {
    profilePhoto = photo;
  }

  String getProfilePhoto() {
    return profilePhoto;
  }

  bool isForum() {
    return forumType == ForumType.Forum;
  }

  bool isArticle() {
    return forumType == ForumType.Article;
  }

  ForumTypeLabel(this.forumType) {
    switch (forumType) {
      case ForumType.Forum:
        forumPageTitle = 'Sawal Jawab';
        forumAddButtonTitle = 'Ask Your Question (सवाल पूछें)';
        forumAddAnswerTitle = 'Write your answer';

        myPageTitle = 'Profile';
        myAddButtonTitle = 'Ask Your Question';
        myPageSubHeading = 'My Posts';

        addPageTitle = 'Apna Sawal Pooche';
        addTextTitle = 'Title';
        addTextDescription = 'Write your question';

        detailPageTitle = 'Sawal Jawab';
        detailTextHeading = 'Sawal Jawab';
        detailTextAnswer = 'Answer';
        detailTextAnswerHint = 'Write your answer';
        break;

      case ForumType.Article:
      default:
        forumPageTitle = 'Matsya Gyan';
        forumAddButtonTitle = 'Apka Matsya Gyan Sajha Karain';
        forumAddAnswerTitle = 'Comment here';

        myPageTitle = 'Profile';
        myAddButtonTitle = 'Apka Matsya Gyan Sajha Karain';
        myPageSubHeading = 'My Articles';

        addPageTitle = 'Apka Matsya Gyan Sajha Karain';
        addTextTitle = 'Title of article';
        addTextDescription = 'Write something here...';

        detailPageTitle = 'Matsya Gyan';
        detailTextHeading = 'Matsya Gyan';
        detailTextAnswer = 'Comment';
        detailTextAnswerHint = 'Write your comment';
        break;
    }
  }
}

class _CharchaScreenState extends State<CharchaScreen>
    with SingleTickerProviderStateMixin {
  CharchaController charCha = Get.put(CharchaController());
  ForumTypeLabel label = ForumTypeLabel(ForumType.Forum);

  @override
  void initState() {
    label = ForumTypeLabel(widget.forumType);
    if (charCha.charChaCall.isFalse) {
      charCha.getcharchaApiCall();
    }
    // this._fetchData();
    super.initState();
    // Common.analytics.setCurrentScreen(screenName: 'CharchaScreen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFE6E6E6),
        appBar: AppBar(
          backgroundColor: kheader,
          automaticallyImplyLeading: false,
          // iconTheme: IconThemeData(color: kblack),
          title: NormalText(label.forumPageTitle, kwhite, 25),
          centerTitle: true,
          elevation: 4.0,
          actions: [
            (label.hasProfilePhoto())
                ? GestureDetector(
                    onTap: () async {
                      // bool blnResult = await Navigator.push(context,
                      //     MaterialPageRoute(builder: (_) {
                      //   return ForumMy(this.label);
                      // }));
                      // if (blnResult != null && blnResult) {
                      //   _fetchData();
                      // }
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: kwhite,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const [
                            BoxShadow(color: Colors.grey, blurRadius: 2)
                          ]),
                      child: ClipOval(
                          child: Image.network(
                        label.getProfilePhoto(),
                        fit: BoxFit.cover,
                        height: 30.0,
                        width: 35.0,
                      )),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: TextButton.icon(
          // elevation: 0,
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => Colors.white),
              shape: MaterialStateProperty.resolveWith(
                (states) => RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                    side: BorderSide(color: kheader)),
              )),
          // height: 50,
          // minWidth: 350,
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(6),
          //     side: BorderSide(color: kheader)),
          onPressed: () async {
            Get.to(ForumAdd(label));
            // bool blnResult =
            // await Navigator.push(context, MaterialPageRoute(builder: (_) {
            //   return ForumAdd(this.label);
            // }));
            // if (blnResult != null && blnResult) this._fetchData();
          },
          label: Text(label.forumAddButtonTitle,
              style: TextStyle(
                  fontSize: 16, color: kblack)), //Apka Matsya Gyan Sajha Karain
          icon: Icon(
            Icons.edit,
            color: kblack,
          ),
        ),
        body: GetBuilder<CharchaController>(
          builder: (charCha) => charCha.charChaCall.isFalse
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : //SingleChildScrollView(
              //child: Padding(
              //padding: EdgeInsets.only(bottom: 73),
              // child: Column(
              //     children: list.map((forumItem) {
              //   return populateItem(forumItem);
              // }).toList()),
              ListView.builder(
                  itemCount: charCha.forumList.length,
                  itemBuilder: (context, index) {
                    return populateItem(charCha.forumList[index]);
                  },
                ),
        ));
  }

  Padding populateItem(Forum forumItem) {
    return Padding(
      padding:
          const EdgeInsets.fromLTRB(0, 8, 0, 4), //const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          Get.to(ForumDetailPage(forumItem,label));
        },
        child: Container(
          //height: 100,
          width: double.infinity,
          child: Card(
            margin: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0)), //15
            elevation: 0.5,
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
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 250,
                              child: BoldText(
                                  forumItem.customerName ?? "", 16, kblack,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            NormalText(
                                forumItem.getFormattedDate(), kgreyDark, 14),
                          ],
                        ),
                        const Spacer(),
                        Visibility(
                          visible: saveUser()?.data?.id !=
                              forumItem.customerId, // USER ARE DIFFERENT
                          child: PopupMenuButton(
                              icon: const Icon(Icons.more_vert),
                              onSelected: (value) {
                                if (value == 'report') {
                                  showReportAbuse(forumItem.id);
                                  // EasyLoading.showToast(
                                  //     'Report has been submitted successfully.');
                                } else if (value == 'block') {
                                  // this._fetchDelete(forumDetailItem.id);
                                  charCha.getblock(
                                      customerid:
                                          forumItem.customerId.toString());
                                  // this._fetchForumBlocked(
                                  //     forumItem.customer_id);
                                  // EasyLoading.showToast(
                                  //     'User has been blocked.');
                                }
                              },
                              itemBuilder: (context) => [
                                    const PopupMenuItem<String>(
                                      value: 'report',
                                      child: Text('Report'),
                                    ),
                                    const PopupMenuItem<String>(
                                      value: 'block',
                                      child: Text('Block User'),
                                    ),
                                  ]),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    // BoldText(forumItem.question, 18.0, kblack),
                    label.isArticle()
                        ? Text(forumItem.question ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: kblack, fontSize: 16.0))
                        : Text(forumItem.question ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: kgreyDark, fontSize: 16.0)),
                    forumItem.hasDescription()
                        ? Text(forumItem.description ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: kgreyDark, fontSize: 16.0))
                        : Container(),
                    forumItem.hasImage()
                        ? Container(
                            height: 180,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    image:
                                        NetworkImage(forumItem.getImageURL())),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0))),
                            // child: Image(
                            //     image: NetworkImage(
                            //         'https://manjha.in/public/news/1621076362.png')),
                          )
                        : Container(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(children: [
                          IconButton(
                            visualDensity: VisualDensity.compact,
                            icon: Icon(
                                forumItem.isLiked()
                                    ? FontAwesomeIcons.solidThumbsUp
                                    : FontAwesomeIcons.thumbsUp,
                                color: forumItem.isLiked()
                                    ? kheader
                                    : kheader //kgreyDark
                                ),
                            onPressed: () {
                              charCha.getlikedislike(
                                  questionsid: forumItem.id.toString());
                            },
                          ),
                          GestureDetector(
                              // onTap: () =>
                              //     this._fetchLikeUnLike(forumItem.id),
                              child: Container(
                            child:
                                NormalText(forumItem.getLikes(), kheader, 12),
                          )),
                        ]),
                        Row(children: [
                          IconButton(
                            visualDensity: VisualDensity.compact,
                            icon:
                                Icon(FontAwesomeIcons.comment, color: kheader),
                            onPressed: () async {
                              Get.to(ForumDetailPage(forumItem,label));
                            },
                          ),
                          NormalText(forumItem.getComments(), kheader, 12),
                        ]),
                        Row(children: [
                          IconButton(
                            visualDensity: VisualDensity.compact,
                            icon:
                                Icon(FontAwesomeIcons.shareAlt, color: kheader),
                            onPressed: () async {
                              EasyLoading.show();
                              await Share.share(forumItem
                                  .getShareLink(forumItem.customerName ?? ""));
                              EasyLoading.dismiss();
                            },
                          ),
                          GestureDetector(
                              onTap: () async {},
                              child: NormalText('Share', kgreyDark, 12)),
                        ],
                        ),
                      ],
                    ),
                    Visibility(
                        visible: forumItem.comments!.length > 0,
                        child: Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: kgreyFill,
                            borderRadius: BorderRadius.circular(8),
                            // border: Border(
                            //     top: BorderSide(color: kgreyFill))
                          ),
                          child: ListView.separated(
                              itemCount: forumItem.comments?.length ?? 0,
                              shrinkWrap: true,
                              primary: false,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fitWidth,
                                              image: NetworkImage(forumItem
                                                      .comments?[index]
                                                      .getCustomerPhoto() ??
                                                  "")),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BoldText(
                                            forumItem.comments?[index]
                                                .getName(),
                                            14,
                                            kblack,
                                            overflow: TextOverflow.visible),
                                        Text(
                                            forumItem.comments?[index].answer ??
                                                "",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: kgreyDark,
                                                fontSize: 16.0)),
                                      ],
                                    )),
                                  ],
                                );
                              }),
                        ))
                    // NormalText("28, Nov at 15:30 pm", kdarkBlue, 12),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  List<String> listReportReason = [
    'Spam or Fruad',
    'Harmful Activity',
    'Irrelevant or annoying',
    'Racism, Discrimination or Hate speech',
    'Misinformation',
    'Violations of privacy'
  ];
  showReportAbuse(forumId) async {
    final result = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: true,
        isDismissible: true,
        useRootNavigator: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        ),
        builder: (BuildContext context) {
          // return object of type Dialog
          return ListView.builder(
            shrinkWrap: true,
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            itemCount: listReportReason.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(listReportReason[index]),
                onTap: () {
                  Navigator.of(context).pop();
                  charCha.getreportreason(
                      reason: listReportReason[index],
                      questionsid: forumId.toString());
                },
              );
            },
          );
        });

    // SELECTED AREA
    if (result == null) return;

    setState(() {});
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("Sorting by $result")));

    // TODO: FILTER DATA AS PER SELECTION
  }

  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
