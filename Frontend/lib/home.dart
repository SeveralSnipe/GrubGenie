import 'package:flutter/material.dart';
import 'package:grub_genie/login.dart';
import 'package:grub_genie/registration.dart';
import 'package:google_fonts/google_fonts.dart';

class NewHome extends StatefulWidget {
  const NewHome({Key? key}) : super(key: key);

  @override
  State<NewHome> createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            color: Colors.lightBlue, // Set the background color here
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 50.0), // Adjust top padding as needed
                  child: Text(
                    "GrubGenie",
                    style:
                        GoogleFonts.oswald(color: Colors.black, fontSize: 40),
                  ),
                ),
                const SizedBox(height: 30),
                _buildSlider(),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    children: [
                      _buildPage(const Login()),
                      _buildPage(const Registration()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(StatefulWidget page) {
    return page;
  }

  Widget _buildSlider() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIndicator(0),
          const SizedBox(width: 10),
          _buildIndicator(1),
        ],
      ),
    );
  }

  Widget _buildIndicator(int pageIndex) {
    return Container(
      width: 10.0,
      height: 10.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        shape: BoxShape.circle,
        color: pageIndex == _currentPage
            ? const Color(0xffb8e4fc)
            : Colors.transparent,
      ),
    );
  }
}
