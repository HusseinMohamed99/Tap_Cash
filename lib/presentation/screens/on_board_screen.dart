import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tap_cash/core/app_color/app_color.dart';
import 'package:tap_cash/core/network/cache_helper.dart';
import 'package:tap_cash/core/size_config/size_config.dart';
import 'package:tap_cash/generated/assets.dart';
import 'package:tap_cash/model/on_board/on_board_model.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: Assets.imagesOnBoard1,
      title:
          '"Take control of your finances\nwith our user-friendly\ndashboard and savings plans."',
    ),
    BoardingModel(
      image: Assets.imagesOnBoard2,
      title:
          '"Get a bird\'s-eye view of your\naccounts and transactions with\nour dashboard."',
    ),
    BoardingModel(
      image: Assets.imagesOnBoard3,
      title: '"Simplify your finances with\nour smart and secure e-wallet."',
    ),
    BoardingModel(
      image: Assets.imagesOnBoard4,
      title:
          '"Pay with ease and security\nusing our smart card for\nonline and in-store purchases."',
    ),
    BoardingModel(
      image: Assets.imagesOnBoard5,
      title:
          '"Teach your kids financial\nresponsibility with our smart\nkids\' card and parental\ncontrols."',
    ),
  ];
  bool isLast = false;

  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return const Text('data');
        }), (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  submit();
                },
                child: Text(
                  isLast ? '' : 'skip',
                  style: GoogleFonts.poppins(
                    color: AppColors.primaryColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),

                  // style: TextStyle(

                  // ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      onPageChanged: (int index) {
                        if (index == boarding.length - 1) {
                          setState(() {
                            isLast = true;
                          });
                        } else {
                          setState(() {
                            isLast = false;
                          });
                        }
                      },
                      controller: pageController,
                      itemBuilder: (context, index) =>
                          buildBoardingItem(boarding[index]),
                      itemCount: boarding.length,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          if (isLast) {
                            submit();
                          } else {
                            pageController.nextPage(
                              duration: const Duration(
                                milliseconds: 780,
                              ),
                              curve: Curves.ease,
                            );
                          }
                        },
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 35, vertical: 12),
                            width: 163,
                            height: 48,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: AppColors.primaryColor,
                            ),
                            child: Text(
                              isLast ? "Get Started" : 'Next',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 58,
                      ),
                      SmoothPageIndicator(
                        textDirection: TextDirection.ltr,
                        controller: pageController,
                        count: boarding.length,
                        effect: const ExpandingDotsEffect(
                          dotWidth: 12.0,
                          dotHeight: 12.0,
                          dotColor: AppColors.greyColor,
                          activeDotColor: AppColors.primaryColor,
                          radius: 20.0,
                          spacing: 17,
                          expansionFactor: 1.01,
                        ),
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        children: [
          SizedBox(
            height: 340,
            width: 340,
            child: SvgPicture.asset(model.image),
          ),
          const SizedBox(height: 39),
          Text(
            model.title,
            style: GoogleFonts.poppins(
              fontSize: 22.sp,
              color: AppColors.titleColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
}
