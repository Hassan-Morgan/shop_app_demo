import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:shop_app/modules/login_page/login.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

class PageViewModel {
  late final String image;
  late final String title;
  late final String description;

  PageViewModel({
    required this.image,
    required this.title,
    required this.description,
  });
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();

  List<PageViewModel> pages = [
    PageViewModel(
        image: 'assets/images/onboarding page 1.png',
        title: 'Choose Your Product',
        description:
            'there is more than 10000 products that you can choose between '),
    PageViewModel(
        image: 'assets/images/onboarding page 2.png',
        title: 'Add to cart',
        description:
            'Selected Items  can be found in the cart , you can buy them with home delivery '),
    PageViewModel(
        image: 'assets/images/onboarding page 3.png',
        title: 'Pay by card',
        description:
            'your order can be paid by the credit card or by cash at the time of delivery'),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              CashHelper.saveData(key: 'onBoarding', value: true).then((value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LogInPage()),
                        (route) => false);
              });
            },
            child: const Text('SKIP'),
          ),
        ],
      ),
      body: PageIndicatorContainer(
        indicatorSpace: 15,
        child: PageView.builder(
          onPageChanged: (index) {
            if (index == pages.length - 1) {
              setState(() {
                isLast = true;
              });
            } else {
              setState(() {
                isLast = false;
              });
            }
            ;
          },
          itemBuilder: (context, index) {
            return _pageViewBuilder(model: pages[index], index: index);
          },
          itemCount: pages.length,
          physics: const BouncingScrollPhysics(),
          controller: _pageController,
        ),
        align: IndicatorAlign.top,
        length: pages.length,
        padding: const EdgeInsets.all(20),
        shape: IndicatorShape.defaultCircle,
        indicatorColor: Colors.black54,
        indicatorSelectorColor: defaultAppColor,
      ),
    );
  }

  Widget _pageViewBuilder({
    required PageViewModel model,
    required int index,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Image(image: AssetImage(model.image))),
          Text(
            model.title,
            style: TextStyle(
              color: defaultAppColor,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            model.description,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          ),
          defaultButton(
              buttonName: isLast ? 'FINISH' : 'NEXT',
              onPress: () {
                if (isLast) {
                  CashHelper.saveData(key: 'onBoarding', value: true).then((value)
                  { Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LogInPage()),
                          (route) => false);});

                } else {
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);
                }
              },
              ),
        ],
      ),
    );
  }
}
