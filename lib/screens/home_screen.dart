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
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Determine if we're on a larger screen
              final isLargeScreen = constraints.maxWidth > 600;
              final isExtraLargeScreen = constraints.maxWidth > 1200;
              
              return Center(
                child: Container(
                  // Limit max width for larger screens
                  constraints: BoxConstraints(
                    maxWidth: isExtraLargeScreen ? 1200 : 
                             isLargeScreen ? 800 : double.infinity,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: isLargeScreen ? 40 : 20),
                      
                      // App Header
                      Container(
                        padding: EdgeInsets.all(isLargeScreen ? 35 : 25),
                        margin: EdgeInsets.symmetric(
                          horizontal: isLargeScreen ? 40 : 20,
                        ),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.school, 
                              size: isLargeScreen ? 70 : 50, 
                              color: AppColors.primary
                            ),
                            SizedBox(height: 15),
                            Text(
                              'مطالعه امتحان جامع',
                              style: TextStyle(
                                fontSize: isLargeScreen ? 32 : 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.dark,
                              ),
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'موتورهای جستجو و بازاریابی الکترونیک',
                              style: TextStyle(
                                fontSize: isLargeScreen ? 18 : 14,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: isLargeScreen ? 30 : 20),
                      
                      // Topics Grid/List
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isLargeScreen ? 40 : 20,
                          ),
                          child: Column(
                            children: [
                              // Study Topics
                              Expanded(
                                child: isLargeScreen 
                                  ? _buildGridView(topics, constraints)
                                  : _buildListView(topics),
                              ),
                              
                              // Comprehensive Quiz Button
                              Container(
                                width: double.infinity,
                                constraints: BoxConstraints(
                                  maxWidth: isLargeScreen ? 500 : double.infinity,
                                ),
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
                                    padding: EdgeInsets.symmetric(
                                      vertical: isLargeScreen ? 20 : 18,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      Text(
                                        'آزمون جامع (تمام مباحث)',
                                        style: TextStyle(
                                          fontSize: isLargeScreen ? 18 : 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        textDirection: TextDirection.rtl,
                                      ),
                                      SizedBox(width: 10),
                                      Icon(
                                        Icons.quiz, 
                                        color: Colors.white, 
                                        size: isLargeScreen ? 28 : 24,
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
              );
            },
          ),
        ),
      ),
    );
  }
  
  Widget _buildListView(List<dynamic> topics) {
    return ListView.builder(
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
    );
  }
  
  Widget _buildGridView(List<dynamic> topics, BoxConstraints constraints) {
    // Calculate number of columns based on screen width
    final crossAxisCount = constraints.maxWidth > 1000 ? 3 : 2;
    
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 1.5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
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
    );
  }
}