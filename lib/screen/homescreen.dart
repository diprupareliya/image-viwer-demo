import 'package:flutter/material.dart';
import 'package:gallery_app/controller/home_controller.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import '../widget/gridimage_view.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  _HomeScreenViewState createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  final ScrollController _scrollController = ScrollController();
  HomeController homeController = Get.put(HomeController());
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    homeController.fetchData(query: "car");
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200,
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(100, 100, 100, 0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search for all images',
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 30.0, right: 20),
                          child: Icon(Icons.search),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      homeController.page.value = 1;
                      Future.delayed(
                          const Duration(milliseconds: 500),
                          () => homeController.fetchData(
                              query: searchController.text));
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.black, width: 0.5),
                      ),
                      child: const Text("Search"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(
            () => Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  controller: _scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    crossAxisCount: 4,
                  ),
                  itemCount: homeController.imageData.length + 1,
                  // Add 1 for the loading indicator
                  itemBuilder: (context, index) {
                    if (index < homeController.imageData.length) {
                      return GridViewImage(imageData: homeController.imageData[index],);
                    } else {
                      if (homeController.isLoading.value) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _scrollListener() {
    if (!_isEndOfList() || homeController.isLoading.value) return;
    homeController.fetchData(query: searchController.text); // Fetch new data
  }

  bool _isEndOfList() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= maxScroll;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
