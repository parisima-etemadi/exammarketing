import 'package:flutter/material.dart';
import '../models/study_topic.dart';
import '../utils/constants.dart';
import '../widgets/study_card.dart';

class TopicDetailScreen extends StatefulWidget {
  final StudyTopic topic;

  TopicDetailScreen({required this.topic});

  @override
  _TopicDetailScreenState createState() => _TopicDetailScreenState();
}

class _TopicDetailScreenState extends State<TopicDetailScreen> {
  PageController _pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.topic.title,
          textDirection: TextDirection.rtl,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: widget.topic.color,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Determine screen size categories
          final isLargeScreen = constraints.maxWidth > 600;
          final isExtraLargeScreen = constraints.maxWidth > 1200;
          final screenWidth = constraints.maxWidth;
          
          return Center(
            child: Container(
              // Limit max width for larger screens
              constraints: BoxConstraints(
                maxWidth: isExtraLargeScreen ? 1200 : 
                         isLargeScreen ? 800 : double.infinity,
              ),
              child: Column(
                children: [
                  // Progress Indicator
                  Container(
                    padding: EdgeInsets.all(isLargeScreen ? 30 : 20),
                    color: widget.topic.color.withOpacity(0.1),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(widget.topic.sections.length, (index) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: isLargeScreen ? 6 : 4,
                              ),
                              width: isLargeScreen ? 16 : 12,
                              height: isLargeScreen ? 16 : 12,
                              decoration: BoxDecoration(
                                color: currentPage == index ? widget.topic.color : Colors.grey[300],
                                borderRadius: BorderRadius.circular(isLargeScreen ? 8 : 6),
                              ),
                            );
                          }),
                        ),
                        SizedBox(height: isLargeScreen ? 15 : 10),
                        Text(
                          'بخش ${currentPage + 1} از ${widget.topic.sections.length}',
                          style: TextStyle(
                            fontSize: isLargeScreen ? 18 : 14,
                            color: widget.topic.color,
                            fontWeight: FontWeight.bold,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),
                  
                  // Content
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (page) {
                        setState(() {
                          currentPage = page;
                        });
                      },
                      itemCount: widget.topic.sections.length,
                      itemBuilder: (context, index) {
                        return StudyCard(
                          section: widget.topic.sections[index],
                          color: widget.topic.color,
                        );
                      },
                    ),
                  ),
                  
                  // Navigation
                  Container(
                    padding: EdgeInsets.all(isLargeScreen ? 30 : 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, -5),
                        ),
                      ],
                    ),
                    child: _buildNavigationButtons(isLargeScreen, screenWidth),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavigationButtons(bool isLargeScreen, double screenWidth) {
    // Determine if we should stack buttons vertically on very small screens
    final shouldStack = screenWidth < 400 && 
                       (currentPage > 0 && currentPage < widget.topic.sections.length - 1);
    
    if (shouldStack) {
      return Column(
        children: [
          // Next or Complete button
          if (currentPage < widget.topic.sections.length - 1)
            _buildButton(
              text: 'بعدی',
              icon: Icons.arrow_right,
              color: widget.topic.color,
              onPressed: () {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              isLargeScreen: isLargeScreen,
              width: double.infinity,
            ),
          
          if (currentPage == widget.topic.sections.length - 1)
            _buildButton(
              text: 'تکمیل مطالعه',
              icon: Icons.check_circle,
              color: AppColors.success,
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'مطالعه ${widget.topic.title} تکمیل شد! ✅',
                      textDirection: TextDirection.rtl,
                    ),
                    backgroundColor: AppColors.success,
                  ),
                );
              },
              isLargeScreen: isLargeScreen,
              width: double.infinity,
            ),
          
          // Previous button
          if (currentPage > 0) ...[
            SizedBox(height: 10),
            _buildButton(
              text: 'قبلی',
              icon: Icons.arrow_forward,
              color: Colors.grey[600]!,
              onPressed: () {
                _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              isLargeScreen: isLargeScreen,
              width: double.infinity,
              iconFirst: true,
            ),
          ],
        ],
      );
    }
    
    // Default horizontal layout
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textDirection: TextDirection.ltr,
      children: [
        if (currentPage < widget.topic.sections.length - 1)
          _buildButton(
            text: 'بعدی',
            icon: Icons.arrow_back,
            color: widget.topic.color,
            onPressed: () {
              _pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            isLargeScreen: isLargeScreen,
          ),
        
        if (currentPage == widget.topic.sections.length - 1)
          _buildButton(
            text: 'تکمیل مطالعه',
            icon: Icons.check_circle,
            color: AppColors.success,
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'مطالعه ${widget.topic.title} تکمیل شد! ✅',
                    textDirection: TextDirection.rtl,
                  ),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            isLargeScreen: isLargeScreen,
          ),
        
        if (currentPage > 0)
          _buildButton(
            text: 'قبلی',
            icon: Icons.arrow_forward,
            color: Colors.grey[600]!,
            onPressed: () {
              _pageController.previousPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            isLargeScreen: isLargeScreen,
            iconFirst: true,
          ),
      ],
    );
  }

  Widget _buildButton({
    required String text,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
    required bool isLargeScreen,
    double? width,
    bool iconFirst = false,
  }) {
    final buttonPadding = EdgeInsets.symmetric(
      horizontal: isLargeScreen ? 40 : 30,
      vertical: isLargeScreen ? 18 : 15,
    );
    
    final fontSize = isLargeScreen ? 16.0 : 14.0;
    final iconSize = isLargeScreen ? 20.0 : 18.0;
    
    final buttonChild = Row(
      mainAxisSize: width != null ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: width != null ? MainAxisAlignment.center : MainAxisAlignment.start,
      textDirection: TextDirection.rtl,
      children: iconFirst
        ? [
            Icon(icon, color: Colors.white, size: iconSize),
            SizedBox(width: 5),
            Text(text, style: TextStyle(color: Colors.white, fontSize: fontSize)),
          ]
        : [
            Text(text, style: TextStyle(color: Colors.white, fontSize: fontSize)),
            SizedBox(width: 5),
            Icon(icon, color: Colors.white, size: iconSize),
          ],
    );

    return Container(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: buttonPadding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isLargeScreen ? 30 : 25),
          ),
          elevation: isLargeScreen ? 8 : 5,
        ),
        child: buttonChild,
      ),
    );
  }
}
