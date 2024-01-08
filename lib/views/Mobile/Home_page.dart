import 'dart:math';
import 'package:api_project/components/Blog_widget.dart';
import 'package:api_project/components/Colors.dart';
import 'package:api_project/components/Drop_Down_Menu.dart';
import 'package:api_project/components/Features_products_widget.dart';
import 'package:api_project/components/Get_in_Touch.dart';
import 'package:api_project/components/Latest_products_widget.dart';
import 'package:api_project/components/My_Drawer.dart';
import 'package:api_project/data/Responces/Status.dart';
import 'package:api_project/model/Blog_model.dart';
import 'package:api_project/model/Items_model.dart';
import 'package:api_project/model/Store_Model.dart';
import 'package:api_project/provider/All_Deparments.dart';
import 'package:api_project/services/Home_View_model.dart';
import 'package:api_project/utils/Constants.dart';
import 'package:api_project/utils/RoutName.dart';
import 'package:api_project/views/Mobile/Blog_Detail.dart';
import 'package:api_project/views/Mobile/Category/Category_Detail_page.dart.dart';
import 'package:api_project/views/Mobile/Deatils_page.dart';
import 'package:api_project/views/User_View_Model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SwiperController _swiperController;
  final ScrollController _scrollController = ScrollController();
  HomeViewModel homeviewmodel = HomeViewModel();

  String appbartitle = "";
  @override
  void initState() {
    super.initState();
    _swiperController = SwiperController();
    homeviewmodel.fetchData();
    loadTitleFromSharedPreferences();
  }

  Future<void> loadTitleFromSharedPreferences() async {
    final userViewModel = context.read<User_view_Model>();
    final user = await userViewModel.getUser();

    if (user != null) {
      setState(() {
        appbartitle = user.storetitle!; // Assuming storeLogo contains the title
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appbartitle),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(FontAwesomeIcons.magnifyingGlass),
          )
        ],
      ),
      //MY DRAWER
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Scroll to the top when FloatingActionButton is pressed
          _scrollController.animateTo(0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        },
        child: const Icon(
          Icons.arrow_upward,
          color: AppColors.primaryColor,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Implement the logic to refresh data here
          // await homeviewmodel.storeApi();
          // await homeviewmodel.itemApi();
          // await homeviewmodel.blogsApi();
          await homeviewmodel.fetchData();
        },
        child: ChangeNotifierProvider<HomeViewModel>(
          create: (BuildContext context) => homeviewmodel,
          child: Consumer<HomeViewModel>(
            builder: (context, value, child) {
              if (value.storelist.status == Status.LOADING ||
                  value.itemlist.status == Status.LOADING ||
                  value.blogsList.status == Status.LOADING) {
                return const Center(
                    child: SpinKitThreeBounce(
                  color: AppColors.primaryColor,
                  size: 30,
                ));
              } else if (value.storelist.status == Status.ERROR ||
                  value.itemlist.status == Status.ERROR ||
                  value.blogsList.status == Status.ERROR) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/404error.json', // Replace with your Lottie animation file
                        width: 200,
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                AppColors.purple, // Set the background color
                          ),
                          onPressed: () async {
                            // await homeviewmodel.storeApi();
                            // await homeviewmodel.itemApi();
                            // await homeviewmodel.blogsApi();
                            homeviewmodel.fetchData();
                          },
                          child: const Text(
                            "Reload",
                            style: TextStyle(color: AppColors.white),
                          )),
                    ],
                  ),
                );
              } else if (value.storelist.status == Status.COMPLETED &&
                  value.itemlist.status == Status.COMPLETED &&
                  value.blogsList.status == Status.COMPLETED) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: buildStoreList(
                        storelist: value.storelist.data!,
                        itemList: value.itemlist.data!,
                        blogList: value.blogsList.data!,
                      ),
                    ),
                  ],
                );
              } else {
                return Container(); // Handle other cases as needed
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildStoreList({
    required Stores storelist,
    required List<Items_data> itemList,
    required List<Blogs_data> blogList,
  }) {
    final provider = Provider.of<ProviderController>(context, listen: false);
    Future.delayed(Duration.zero, () {
      final userViewModel = context.read<User_view_Model>();
      userViewModel.saveStoreLogo(storelist);
    });

    final Random random = Random();
    int numberOfRandomProducts =
        5; // Change this to the number of random products you want
    // Generate a list of unique random indices
    List<int> randomIndices = List.generate(
      numberOfRandomProducts,
      (index) => random.nextInt(itemList.length),
    );
    // Define itemPhoto1List here
    List<String> itemPhoto1List =
        itemList.map((product) => product.itemPhoto1 ?? "").toList();
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        // You can add more conditions if needed
        if (scrollNotification is ScrollEndNotification) {
          // Perform actions when scrolling ends
        }
        return false;
      },
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const Gutter(),
                SizedBox(
                  height: 100,
                  width: 300,
                  child: CachedNetworkImage(
                    imageUrl: imagespath + (storelist.drWeblogo ?? ""),
                  ),
                ),

                const Gutter(),

                //DROP DOWN MENU
                CustomDropdownButton(
                  ontap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        // Extract unique item types from the itemList
                        List<String> uniqueItemTypes = itemList
                            .map((item) => item.itemType ?? "")
                            .toSet()
                            .toList();

                        return ListView.builder(
                          itemCount: uniqueItemTypes.length,
                          itemBuilder: (context, index) {
                            final uniqueItemType = uniqueItemTypes[index];

                            return ListTile(
                              title: Text(uniqueItemType),
                              onTap: () {
                                // Filter items based on the selected item type
                                List<Items_data> filteredItems = itemList
                                    .where((item) =>
                                        item.itemType == uniqueItemType)
                                    .toList();

                                if (filteredItems.isNotEmpty) {
                                  provider.setSelectedItem(filteredItems.first);
                                  Navigator.pop(context);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Category_details_page(
                                        store: storelist,
                                        itemList: itemList,
                                        selectedItem: filteredItems.first,
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                  color: provider.getColorFromName(storelist.s66 ?? ""),
                ),

                const SizedBox(width: 8.0),

                ////////////////////////////////////////////////////////////////////////
                const Gutter(),
                ListTile(
                  leading: const Icon(
                    FontAwesomeIcons.whatsapp,
                    color: AppColors.accentColor,
                  ),
                  title: GestureDetector(
                    onTap: () async {
                      await provider.launchwhatsappURL();
                    },
                    child: Text(
                      storelist.s10 ?? " ",
                      style: TextStyle(
                          color: provider.getColorFromName(storelist.s66 ?? ""),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  subtitle: const Text(
                    "Support 24/7 Time",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                const Gutter(),
                Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: constraints.maxWidth > 600 ? 400 : 250,
                      child: CachedNetworkImage(
                        imageUrl: imagespath + (storelist.s38 ?? ""),
                        width: MediaQuery.of(context).size.width,
                        height: 500,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      top: 20, // Adjust the position based on your layout
                      bottom: 10,
                      left: 10,
                      right: 130, // Adjust the position based on your layout
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(
                              0.7), // Adjust the background color and opacity
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          children: [
                            Text(
                              storelist.s35 ?? "",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize:
                                      constraints.maxWidth > 600 ? 400 : 13,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              storelist.s36 ?? "",
                              style: const TextStyle(color: AppColors.grey),
                            ),
                            ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: AppColors.white,
                                  backgroundColor: provider.getColorFromName(
                                      storelist.s66 ??
                                          ""), // Set the text color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Set the border radius to 0
                                  ),
                                ),
                                child: const Text(
                                  "Order Now",
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const Gutter(),
                SizedBox(
                  height: constraints.maxWidth > 600 ? 400 : 200,
                  child: Swiper(
                    controller: _swiperController,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          // Image
                          CachedNetworkImage(
                            imageUrl: imagespath + itemPhoto1List[index],
                            width: MediaQuery.of(context).size.width,
                            height: 500,
                            fit: BoxFit.cover,
                          ),
                          // Positioned widget for text (product item name)
                          Positioned.fill(
                            child: Center(
                              child: Text(
                                itemList[index].itemName ??
                                    "", // Use the actual property for item name
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                    itemCount: 20,
                    itemWidth: MediaQuery.of(context).size.width * 0.8,
                    layout: SwiperLayout.DEFAULT,
                    autoplay: true,
                    pagination: const SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                        activeColor: Colors.blue,
                        color: AppColors.layout,
                        space: 1,
                      ),
                    ),
                    control: const SwiperControl(),
                  ),
                ),

                const Gutter(),
                const Center(
                  child: Text(
                    "Latest Products",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                Divider(
                  thickness: 4,
                  color: provider.getColorFromName(storelist.s66 ?? ''),
                  endIndent: 140,
                  indent: 140,
                ),
                const Gutter(),

                //LATEST PRODUCT WIDGET
                Container(
                  color: AppColors.white,
                  height: 400,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          right: 8.0,
                        ), // Adjust the right padding as needed
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to the details page and pass data
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Details_page(
                                  store: storelist,
                                  item:
                                      itemList[index], // Pass the selected item
                                ),
                              ),
                            );
                          },
                          child: Latest_Products(
                              imagepath: imagespath +
                                  (itemList[index].itemPhoto1 ?? ""),
                              title: itemList[index].itemName ?? "",
                              price: itemList[index].itemPrice ?? "",
                              currancy: itemList[index].itemCurrency ?? "",
                              color: provider
                                  .getColorFromName(storelist.s66 ?? "")),
                        ),
                      );
                    },
                  ),
                ),

                ///////////////////////////////////////////////////////////////////
                const Gutter(),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: constraints.maxWidth > 600 ? 120 : 60),
                    child: Text(
                      "Feature Products",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: constraints.maxWidth > 600 ? 30 : 20),
                    ),
                  ),
                ),
                const Gutter(),
                Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        final item = itemList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Details_page(
                                  store: storelist,
                                  item:
                                      itemList[index], // Pass the selected item
                                ),
                              ),
                            );
                          },
                          child: ProductWidget(
                            discount: item.itemDiscount ?? "",
                            currency: item.itemCurrency ?? "",
                            imagePath: imagespath + (item.itemPhoto1 ?? ""),
                            productName: item.itemName ?? "",
                            productPrice: item.itemPrice ?? "",
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const Gutter(),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: constraints.maxWidth > 600 ? 120 : 60),
                    child: Text(
                      "Top_Rated Products",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: constraints.maxWidth > 600 ? 30 : 20),
                    ),
                  ),
                ),
                const Gutter(),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: numberOfRandomProducts,
                  itemBuilder: (context, index) {
                    var product = itemList[randomIndices[index]];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Details_page(
                              store: storelist,
                              item: itemList[index], // Pass the selected item
                            ),
                          ),
                        );
                      },
                      child: ProductWidget(
                        discount: product.itemDiscount ?? "",
                        currency: product.itemCurrency ?? "",
                        imagePath: imagespath + (product.itemPhoto1 ?? ""),
                        productName: product.itemName ?? "",
                        productPrice: product.itemPrice ?? "",
                      ),
                    );
                  },
                ),
                const Gutter(),

                //REVIEW PRODUCT SECTION
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: constraints.maxWidth > 600 ? 120 : 60),
                    child: Text(
                      "Review Products",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: constraints.maxWidth > 600 ? 30 : 20),
                    ),
                  ),
                ),
                const Gutter(),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    var product = itemList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Details_page(
                              store: storelist,
                              item: itemList[index], // Pass the selected item
                            ),
                          ),
                        );
                      },
                      child: ProductWidget(
                        discount: product.itemDiscount ?? "",
                        currency: product.itemCurrency ?? "",
                        imagePath: imagespath + (product.itemPhoto1 ?? ""),
                        productName: product.itemName ?? "",
                        productPrice: product.itemPrice ?? "",
                      ),
                    );
                  },
                ),

                const Gutter(),

                //FROM THE BLOG SECTION
                Center(
                  child: Text(
                    "From The Blog",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: constraints.maxWidth > 600 ? 400 : 30),
                  ),
                ),

                Divider(
                  thickness: 4,
                  color: provider.getColorFromName(storelist.s66 ?? ""),
                  endIndent: 140,
                  indent: 140,
                ),
                const Gutter(),

                //BLOG WIDGET SECTION

                Container(
                  color: AppColors.white,
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: blogList.length,
                    itemBuilder: (context, index) {
                      final item = blogList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Blog_detail(
                                      store: storelist,
                                      blogList:
                                          item, // Pass the blogList to Blog_detail
                                      selectedIndex:
                                          index, // Pass the selected index to identify the tapped blog
                                    )),
                          );
                        },
                        child: Blog_widget(
                          imagepath: imagespath + (item.postPhotos ?? ""),
                          time: item.postDate ?? "",
                          chat: item.postComments ?? "",
                          title: item.postTitle ?? "",
                        ),
                      );
                    },
                  ),
                ),

                const Gutter(),
                // GET IN TOUCH SECTION
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Get In Touch",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: constraints.maxWidth > 600 ? 24 : 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Contact for any query",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: constraints.maxWidth > 600 ? 24 : 16,
                    ),
                  ),
                ),
                GetInTouch(
                  fotter: storelist.s9 ?? " ",
                  imageAssetPath: imagespath + (storelist.drWeblogo ?? ""),
                  description: storelist.s29 ?? "",
                  phone: storelist.s10 ?? " ",
                  email: storelist.s12 ?? "",
                  address: storelist.s46 ?? " ",
                  linkTitles: const [
                    'Home',
                    'About',
                    'Contact',
                    'Blog',
                    'Jobs'
                  ],
                  linkCallbacks: [
                    () {},
                    () {
                      Navigator.pushNamed(context, Routesname.About_Us);
                    },
                    () {
                      Navigator.pushNamed(context, Routesname.Contact);
                    },
                    () {
                      Navigator.pushNamed(context, Routesname.Blogs);
                    },
                    () {
                      // Handle Link 3 click jobs
                    },
                  ],
                ),
                const Gutter(),
              ],
            ),
          );
        },
      ),
    );
  }
}
