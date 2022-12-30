import 'package:get/get.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/interaction/apis/inbox_tab_related_api.dart';
import 'package:m_skool_flutter/student/interaction/model/inbox_model.dart';

class InboxController extends GetxController {
  RxList<GetinboxmsgValue> inboxList = <GetinboxmsgValue>[].obs;
  RxList<GetinboxmsgValue> unReadList = <GetinboxmsgValue>[].obs;
  RxList<GetinboxmsgReadflgValue> messageFlagList =
      <GetinboxmsgReadflgValue>[].obs;
  RxBool isInboxLoading = RxBool(false);

  void isInboxloading(bool loading) async {
    isInboxLoading.value = loading;
  }

  RxBool isUnreadLoading = RxBool(false);

  void isUnreadloading(bool loading) async {
    isUnreadLoading.value = loading;
  }

  Future<bool> getInboxList({
    required int miId,
    required int amstId,
    required int asmayId,
    required int userId,
    required String base,
  }) async {
    try {
      InboxDataModel? inboxDataModel = await getInboxData(
          miId: miId,
          amstId: amstId,
          asmayId: asmayId,
          userId: userId,
          base: base);
      if (inboxDataModel!.getinboxmsg != null ||
          inboxDataModel.getinboxmsg!.values != null) {
        inboxList.clear();
        logger.d(inboxDataModel.getinboxmsg!.values!.length.toString());
        for (var i = 0; i < inboxDataModel.getinboxmsg!.values!.length; i++) {
          inboxList.add(inboxDataModel.getinboxmsg!.values!.elementAt(i));
        }
        return true;
      }
      return false;
    } catch (e) {
      logger.e(e.toString());
      return false;
    }
  }

  Future<bool> getUnread({
    required int miId,
    required int amstId,
    required int asmayId,
    required int userId,
    required String base,
  }) async {
    try {
      InboxDataModel? inboxDataModel = await getInboxData(
          miId: miId,
          amstId: amstId,
          asmayId: asmayId,
          userId: userId,
          base: base);
      if (inboxDataModel!.getinboxmsg != null ||
          inboxDataModel.getinboxmsg!.values != null) {
        unReadList.clear();
        logger.d(inboxDataModel.getinboxmsg!.values!.length.toString());
        for (var i = 0; i < inboxDataModel.getinboxmsg!.values!.length; i++) {
          if (inboxDataModel.getinboxmsg!.values!.elementAt(i).istintReadFlg ==
              0) {
            unReadList.add(inboxDataModel.getinboxmsg!.values!.elementAt(i));
          }
        }
        return true;
      }
      return false;
    } catch (e) {
      logger.e(e.toString());
      return false;
    }
  }
}
