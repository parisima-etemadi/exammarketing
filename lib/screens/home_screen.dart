import 'package:flutter/material.dart';
import '../widgets/subject_card.dart';
import '../utils/app_data.dart';
import '../utils/constants.dart';
import 'topic_detail_screen.dart';
import 'quiz/comprehensive_quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final topics = AppData.getStudyTopics();
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [AppColors.primary, AppColors.secondary],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 30),
              // App Header
              Container(
                padding: EdgeInsets.all(25),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(Icons.school, size: 50, color: AppColors.primary),
                    SizedBox(height: 15),
                    Text(
                      'مطالعه امتحان جامع',
                      style: AppStyles.heading,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'موتورهای جستجو و بازاریابی الکترونیک',
                      style: AppStyles.caption,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              
              // Topics List
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Study Topics
                      Expanded(
                        child: ListView.builder(
                          itemCount: topics.length,
                          itemBuilder: (context, index) {
                            final topic = topics[index];
                            return SubjectCard(
                              title: topic.title,
                              subtitle: topic.subtitle,
                              description: topic.description,
                              icon: topic.icon,
                              color: topic.color,
                              sectionsCount: topic.sections.length,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TopicDetailScreen(topic: topic),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      
                      // Comprehensive Quiz Button
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: ElevatedButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ComprehensiveQuizScreen(),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.quiz,
                            padding: EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            textDirection: TextDirection.rtl,
                            children: [
                              Icon(Icons.quiz, color: Colors.white, size: 24),
                              SizedBox(width: 10),
                              Text(
                                'آزمون جامع (تمام مباحث)',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
