import 'package:contacts_app/constants/themes.dart';
import 'package:contacts_app/screens/contacts_list_screen.dart';
import 'package:contacts_app/slider_data.dart';
import 'package:contacts_app/widgets/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 1);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 50),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 6.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.pink,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                // Color(0xFF3594DD),
                Color(0xFFF3F5F7),
                Color(0xFFD8ECF1),
                Color(0xFF3EBACE).withOpacity(0.1),
                Color(0xFF009688).withOpacity(0.1)
              ],
            ),
          ),
          child: Padding(
            padding:
                EdgeInsets.only(top: 60.0, bottom: 10, left: 20, right: 20),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      // ignore: deprecated_member_use
                      child: Text(
                        'Welcome,',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 23.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    _currentPage != _numPages - 1
                        ? Align(
                            // alignment: Alignment.bottomRight,
                            // ignore: deprecated_member_use
                            child: Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50.0),
                                splashColor: Colors.grey,
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (_) => ContactListScreen()));
                                },
                                child: Text(
                                  'Skip',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Text(''),
                  ],
                ),
                Expanded(
                  flex: 6,
                  child: PageView.builder(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemCount: sliders.length,
                    itemBuilder: (context, index) {
                      final SliderData sliderData = sliders[index];
                      return SliderWidget(
                        img: sliderData.imageUrl,
                        overlayText: "${sliderData.title} Contact",
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40, bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildPageIndicator(),
                  ),
                ),
                // SizedBox(
                //   height: 30,
                // ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: 50.0,
              width: double.infinity,
              // color: Theme.of(context).scaffoldBackgroundColor,
              color: Colors.white,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => ContactListScreen())),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 1.0),
                    child: Text(
                      'Add New Contact',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }
}
