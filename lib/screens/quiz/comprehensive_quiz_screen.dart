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
      body: showResult ? _buildResultScreen() : _buildQuizScreen(),
    );
  }

  Widget _buildQuizScreen() {
    final question = questions[currentQuestion];
    
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          // Progress Header
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.quiz.withOpacity(0.1), AppColors.quiz.withOpacity(0.05)],
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'سوال ${currentQuestion + 1} از ${questions.length}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.quiz,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    Text(
                      'امتیاز: $score',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.quiz,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.quiz.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'دسته: ${question.category}',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.quiz,
                      fontWeight: FontWeight.bold,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 30),
          
          // Question Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Text(
              question.question,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.dark,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
          ),
          
          SizedBox(height: 30),
          
          // Options
          Expanded(
            child: ListView.builder(
              itemCount: question.options.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ElevatedButton(
                    onPressed: () => answerQuestion(index),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.dark,
                      padding: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: AppColors.quiz, width: 2),
                      ),
                      elevation: 5,
                    ),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: AppColors.quiz.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.quiz,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            question.options[index],
                            style: TextStyle(fontSize: 16),
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

  Widget _buildResultScreen() {
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
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          // Result Card
          Expanded(
            child: Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: resultColor.withOpacity(0.3),
                    blurRadius: 15,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: resultColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      resultIcon,
                      size: 80,
                      color: resultColor,
                    ),
                  ),
                  
                  SizedBox(height: 30),
                  
                  Text(
                    resultMessage,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: resultColor,
                    ),
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  ),
                  
                  SizedBox(height: 30),
                  
                  // Score Display
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: resultColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'نمره شما',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.dark,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(height: 10),
                        Text(
                          '$score از ${questions.length}',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: resultColor,
                          ),
                        ),
                        Text(
                          '${percentage.toStringAsFixed(1)}%',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: resultColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 30),
                  
                  // Detailed Results
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'جزئیات نتایج',
                            style: AppStyles.subheading,
                            textDirection: TextDirection.rtl,
                          ),
                          SizedBox(height: 15),
                          Expanded(
                            child: ListView.builder(
                              itemCount: questions.length,
                              itemBuilder: (context, index) {
                                final question = questions[index];
                                final isCorrect = userAnswers[index] == question.correctAnswer;
                                
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 4),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: isCorrect ? AppColors.success.withOpacity(0.1) : AppColors.danger.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: isCorrect ? AppColors.success : AppColors.danger,
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      Icon(
                                        isCorrect ? Icons.check_circle : Icons.cancel,
                                        color: isCorrect ? AppColors.success : AppColors.danger,
                                        size: 20,
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          'سوال ${index + 1}: ${question.category}',
                                          style: TextStyle(
                                            fontSize: 14,
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
          
          SizedBox(height: 20),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: resetQuiz,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.quiz,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'آزمون دوباره',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'صفحه اصلی',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
