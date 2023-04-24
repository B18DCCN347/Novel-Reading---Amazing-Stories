import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_novel/app/global/controller.dart';
import 'package:love_novel/data/models/public/download_package.dart';
import 'package:love_novel/data/repositories/book.dart';
import 'package:love_novel/ui/components/app_menu_bar.dart';
import 'package:love_novel/ui/components/app_scaffold.dart';
import 'package:love_novel/ui/components/download_chapters_box.dart';
import 'package:love_novel/ui/components/texts.dart';
import 'package:love_novel/ui/pages/book/controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/global/hivebox_controller.dart';

class DownloadController extends GetxController {
  static DownloadController get instance =>
      Get.isRegistered<DownloadController>()
          ? Get.find()
          : Get.put(DownloadController());
  var packages = Rxn<List<DownloadPackage>>();
  final bookController = BookController.instance;
  final hiveBoxController = HiveBoxController.instance;
  static int numberLoaded = 0;
  static int test = 2;
  @override
  void onInit() async {
    super.onInit();
    // WidgetsBinding.instance.addPostFrameCallback((timer) async {
    await loadDownloadPackages();
    await check();
    // });
  }

  loadDownloadPackages() async {
    var bookId = BookController.currentBook.value?.uuid ?? "";
    if (bookId.isNotEmpty) {
      if (AppController.hasConnection) {
        var rp = await BookRepository().fetchDownloadPackages(bookId);
        packages.value = rp?.data ?? [];
        packages.refresh();
      } else {
        packages.value = [];
        packages.refresh();
      }
    }
  }

  check() async {
    if (packages.value!.isNotEmpty) {
      for (var e in packages.value!) {
        var existItem = await hiveBoxController.getDownloadPackage(e.id ?? "");
        if (existItem?.id != null) numberLoaded++;
        if (numberLoaded >= 3) {
          var prefs = await SharedPreferences.getInstance();
          var bookId = BookController.currentBook.value?.uuid ?? "";

          // await prefs.setInt('numLoaded__' + bookId.toString(), numberLoaded);
          // var numLoaded1 = await prefs.getInt('numLoaded__${bookId}');
          // print(numLoaded1.toString() + "__________sdsdgsdgsdfg");
          break;
        }
      }
    }
  }
}

class DownloadPage extends StatefulWidget {
  DownloadPage({Key? key}) : super(key: key);
  static const route = '/download';

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  var controller = DownloadController.instance;

  // var numberLoaded = 0;

  final hiveBoxController = HiveBoxController.instance;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    DownloadController.numberLoaded = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return AppScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppMenuBar(
            title: "Download",
            showBackButton: true,
          ),
          Expanded(
            child: Obx(() {
              if (controller.packages.value == null) {
                return Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 8,
                ));
              } else {
                if (controller.packages.value!.isNotEmpty) {
                  // if (controller.packages.value!.isNotEmpty) {
                  //   for (var e in controller.packages.value!) {
                  //     var existItem =
                  //         hiveBoxController.getDownloadPackage(e.id ?? "");
                  //     if (existItem == null) numberLoaded++;
                  //     if (numberLoaded >= 2) break;
                  //   }
                  // }

                  return GridView.count(
                      padding: const EdgeInsets.all(8),
                      crossAxisCount: 2,
                      childAspectRatio: 2.4,
                      controller: new ScrollController(keepScrollOffset: false),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: controller.packages.value!.map((data) {
                        return DownloadChapterBox(
                          data,
                        );
                      }).toList());
                } else {
                  return Container(
                    height: 200,
                    child: Center(child: DisabledText("No data found")),
                  );
                }
              }
            }),
          )
        ],
      ),
    );
  }
}
