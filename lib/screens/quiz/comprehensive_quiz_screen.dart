import 'package:flutter/material.dart';
import '../../models/quiz_question.dart';
import '../../utils/app_data.dart';
import '../../utils/constants.dart';

class ComprehensiveQuizScreen extends StatefulWidget {
  @override
  _ComprehensiveQuizScreenState createState() => _ComprehensiveQuizScreenState();
}

class _ComprehensiveQuizScreenState extends State<ComprehensiveQuizScreen> {
  int currentQuestion = 0;
  int score = 0;
  bool showResult = false;
  List<int> userAnswers = [];
  List<QuizQuestion> questions = [];

  @override
  void initState() {
    super.initState();
    questions = AppData.getAllQuizQuestions();
    questions.shuffle(); // Randomize question order
    userAnswers = List.filled(questions.length, -1);
  }

  void answerQuestion(int selectedAnswer) {
    userAnswers[currentQuestion] = selectedAnswer;
    
    if (selectedAnswer == questions[currentQuestion].correctAnswer) {
      score++;
    }

    setState(() {
      if (currentQuestion < questions.length - 1) {
        currentQuestion++;
      } else {
        showResult = true;
      }
    });
  }

  void resetQuiz() {
    setState(() {
      currentQuestion = 0;
      score = 0;
      showResult = false;
      userAnswers = List.filled(questions.length, -1);
      questions.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'آزمون جامع',
          textDirection: TextDirection.rtl,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.quiz,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Determine screen size categories
          final isLargeScreen = constraints.maxWidth > 600;
          final isExtraLargeScreen = constraints.maxWidth > 1200;
          
          return Center(
            child: Container(
              // Limit max width for larger screens
              constraints: BoxConstraints(
                maxWidth: isExtraLargeScreen ? 1200 : 
                         isLargeScreen ? 800 : double.infinity,
              ),
              child: showResult 
                ? _buildResultScreen(isLargeScreen, constraints.maxWidth) 
                : _buildQuizScreen(isLargeScreen, constraints.maxWidth),
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuizScreen(bool isLargeScreen, double screenWidth) {
    final question = questions[currentQuestion];
    
    return Container(
      padding: EdgeInsets.all(isLargeScreen ? 30 : 20),
      child: Column(
        children: [
          // Progress Header
          Container(
            padding: EdgeInsets.all(isLargeScreen ? 30 : 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.quiz.withOpacity(0.1), AppColors.quiz.withOpacity(0.05)],
              ),
              borderRadius: BorderRadius.circular(isLargeScreen ? 20 : 15),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'سوال ${currentQuestion + 1} از ${questions.length}',
                      style: TextStyle(
                        fontSize: isLargeScreen ? 20 : 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.quiz,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    Text(
                      'امتیاز: $score',
                      style: TextStyle(
                        fontSize: isLargeScreen ? 20 : 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.quiz,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
                SizedBox(height: isLargeScreen ? 15 : 10),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isLargeScreen ? 16 : 12, 
                    vertical: isLargeScreen ? 10 : 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.quiz.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(isLargeScreen ? 15 : 12),
                  ),
                  child: Text(
                    'دسته: ${question.category}',
                    style: TextStyle(
                      fontSize: isLargeScreen ? 16 : 12,
                      color: AppColors.quiz,
                      fontWeight: FontWeight.bold,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: isLargeScreen ? 40 : 30),
          
          // Question Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(isLargeScreen ? 35 : 25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(isLargeScreen ? 25 : 20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: isLargeScreen ? 20 : 15,
                  offset: Offset(0, isLargeScreen ? 12 : 8),
                ),
              ],
            ),
            child: Text(
              question.question,
              style: TextStyle(
                fontSize: isLargeScreen ? 24 : 20,
                fontWeight: FontWeight.bold,
                color: AppColors.dark,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
          ),
          
          SizedBox(height: isLargeScreen ? 40 : 30),
          
          // Options
          Expanded(
            child: ListView.builder(
              itemCount: question.options.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: isLargeScreen ? 12 : 8),
                  child: ElevatedButton(
                    onPressed: () => answerQuestion(index),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.dark,
                      padding: EdgeInsets.all(isLargeScreen ? 25 : 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(isLargeScreen ? 20 : 15),
                        side: BorderSide(
                          color: AppColors.quiz, 
                          width: isLargeScreen ? 3 : 2,
                        ),
                      ),
                      elevation: isLargeScreen ? 8 : 5,
                    ),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Container(
                          width: isLargeScreen ? 40 : 30,
                          height: isLargeScreen ? 40 : 30,
                          decoration: BoxDecoration(
                            color: AppColors.quiz.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(isLargeScreen ? 20 : 15),
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.quiz,
                                fontSize: isLargeScreen ? 18 : 14,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: isLargeScreen ? 20 : 15),
                        Expanded(
                          child: Text(
                            question.options[index],
                            style: TextStyle(fontSize: isLargeScreen ? 18 : 16),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultScreen(bool isLargeScreen, double screenWidth) {
    double percentage = (score / questions.length) * 100;
    String resultMessage;
    Color resultColor;
    IconData resultIcon;

    if (percentage >= 90) {
      resultMessage = 'فوق‌العاده! شما استاد این مباحث هستید! 🎉';
      resultColor = AppColors.success;
      resultIcon = Icons.emoji_events;
    } else if (percentage >= 75) {
      resultMessage = 'عالی! خیلی خوب یاد گرفتید! 👏';
      resultColor = AppColors.success;
      resultIcon = Icons.star;
    } else if (percentage >= 60) {
      resultMessage = 'خوب است! کمی مرور کنید 👍';
      resultColor = AppColors.warning;
      resultIcon = Icons.thumb_up;
    } else {
      resultMessage = 'نیاز به مطالعه بیشتر دارید 📚';
      resultColor = AppColors.danger;
      resultIcon = Icons.school;
    }

    return Container(
      padding: EdgeInsets.all(isLargeScreen ? 30 : 20),
      child: Column(
        children: [
          // Result Card
          Expanded(
            child: Container(
              padding: EdgeInsets.all(isLargeScreen ? 40 : 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(isLargeScreen ? 25 : 20),
                boxShadow: [
                  BoxShadow(
                    color: resultColor.withOpacity(0.3),
                    blurRadius: isLargeScreen ? 20 : 15,
                    offset: Offset(0, isLargeScreen ? 12 : 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(isLargeScreen ? 30 : 20),
                    decoration: BoxDecoration(
                      color: resultColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(isLargeScreen ? 60 : 50),
                    ),
                    child: Icon(
                      resultIcon,
                      size: isLargeScreen ? 100 : 80,
                      color: resultColor,
                    ),
                  ),
                  
                  SizedBox(height: isLargeScreen ? 40 : 30),
                  
                  Text(
                    resultMessage,
                    style: TextStyle(
                      fontSize: isLargeScreen ? 28 : 24,
                      fontWeight: FontWeight.bold,
                      color: resultColor,
                    ),
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  ),
                  
                  SizedBox(height: isLargeScreen ? 40 : 30),
                  
                  // Score Display
                  Container(
                    padding: EdgeInsets.all(isLargeScreen ? 25 : 20),
                    decoration: BoxDecoration(
                      color: resultColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(isLargeScreen ? 20 : 15),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'نمره شما',
                          style: TextStyle(
                            fontSize: isLargeScreen ? 20 : 16,
                            color: AppColors.dark,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(height: isLargeScreen ? 15 : 10),
                        Text(
                          '$score از ${questions.length}',
                          style: TextStyle(
                            fontSize: isLargeScreen ? 40 : 32,
                            fontWeight: FontWeight.bold,
                            color: resultColor,
                          ),
                        ),
                        Text(
                          '${percentage.toStringAsFixed(1)}%',
                          style: TextStyle(
                            fontSize: isLargeScreen ? 24 : 20,
                            fontWeight: FontWeight.bold,
                            color: resultColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: isLargeScreen ? 40 : 30),
                  
                  // Detailed Results
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(isLargeScreen ? 20 : 15),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(isLargeScreen ? 20 : 15),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'جزئیات نتایج',
                            style: TextStyle(
                              fontSize: isLargeScreen ? 20 : 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.dark,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                          SizedBox(height: isLargeScreen ? 20 : 15),
                          Expanded(
                            child: ListView.builder(
                              itemCount: questions.length,
                              itemBuilder: (context, index) {
                                final question = questions[index];
                                final isCorrect = userAnswers[index] == question.correctAnswer;
                                
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: isLargeScreen ? 6 : 4),
                                  padding: EdgeInsets.all(isLargeScreen ? 16 : 12),
                                  decoration: BoxDecoration(
                                    color: isCorrect ? AppColors.success.withOpacity(0.1) : AppColors.danger.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(isLargeScreen ? 15 : 10),
                                    border: Border.all(
                                      color: isCorrect ? AppColors.success : AppColors.danger,
                                      width: isLargeScreen ? 2 : 1,
                                    ),
                                  ),
                                  child: Row(
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      Icon(
                                        isCorrect ? Icons.check_circle : Icons.cancel,
                                        color: isCorrect ? AppColors.success : AppColors.danger,
                                        size: isLargeScreen ? 24 : 20,
                                      ),
                                      SizedBox(width: isLargeScreen ? 15 : 10),
                                      Expanded(
                                        child: Text(
                                          'سوال ${index + 1}: ${question.category}',
                                          style: TextStyle(
                                            fontSize: isLargeScreen ? 16 : 14,
                                            color: AppColors.dark,
                                          ),
                                          textDirection: TextDirection.rtl,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
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
          
          SizedBox(height: isLargeScreen ? 30 : 20),
          
          // Action Buttons
          _buildActionButtons(isLargeScreen, screenWidth),
        ],
      ),
    );
  }

  Widget _buildActionButtons(bool isLargeScreen, double screenWidth) {
    // Stack buttons vertically on very small screens
    final shouldStack = screenWidth < 400;
    
    if (shouldStack) {
      return Column(
        children: [
          _buildActionButton(
            text: 'آزمون دوباره',
            color: AppColors.quiz,
            onPressed: resetQuiz,
            isLargeScreen: isLargeScreen,
            width: double.infinity,
          ),
          SizedBox(height: 10),
          _buildActionButton(
            text: 'صفحه اصلی',
            color: AppColors.primary,
            onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
            isLargeScreen: isLargeScreen,
            width: double.infinity,
          ),
        ],
      );
    }
    
    // Default horizontal layout
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            text: 'آزمون دوباره',
            color: AppColors.quiz,
            onPressed: resetQuiz,
            isLargeScreen: isLargeScreen,
          ),
        ),
        SizedBox(width: isLargeScreen ? 20 : 15),
        Expanded(
          child: _buildActionButton(
            text: 'صفحه اصلی',
            color: AppColors.primary,
            onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
            isLargeScreen: isLargeScreen,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String text,
    required Color color,
    required VoidCallback onPressed,
    required bool isLargeScreen,
    double? width,
  }) {
    return Container(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: isLargeScreen ? 18 : 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isLargeScreen ? 20 : 15),
          ),
          elevation: isLargeScreen ? 8 : 5,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: isLargeScreen ? 18 : 16, 
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
