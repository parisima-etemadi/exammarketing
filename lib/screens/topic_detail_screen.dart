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
      body: Column(
        children: [
          // Progress Indicator
          Container(
            padding: EdgeInsets.all(20),
            color: widget.topic.color.withOpacity(0.1),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(widget.topic.sections.length, (index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: currentPage == index ? widget.topic.color : Colors.grey[300],
                        borderRadius: BorderRadius.circular(6),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 10),
                Text(
                  'بخش ${currentPage + 1} از ${widget.topic.sections.length}',
                  style: TextStyle(
                    fontSize: 14,
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
            padding: EdgeInsets.all(20),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentPage < widget.topic.sections.length - 1)
                  ElevatedButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.topic.color,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text('بعدی', style: TextStyle(color: Colors.white)),
                  ),
                
                if (currentPage == widget.topic.sections.length - 1)
                  ElevatedButton(
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text('تکمیل مطالعه', style: TextStyle(color: Colors.white)),
                  ),
                
                if (currentPage > 0)
                  ElevatedButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[600],
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text('قبلی', style: TextStyle(color: Colors.white)),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
