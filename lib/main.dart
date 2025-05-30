import 'package:flutter/material.dart';

void main() {
  runApp(SearchEngineApp());
}

class SearchEngineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مطالعه موتورهای جستجو',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Vazir',
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 60),
              // App Title
              Container(
                padding: EdgeInsets.all(20),
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
                    Icon(Icons.search, size: 50, color: Color(0xFF667eea)),
                    SizedBox(height: 10),
                    Text(
                      'موتورهای جستجو چطور عمل می‌کنند؟',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2c3e50),
                      ),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              // Menu Options
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      MenuCard(
                        title: 'مطالعه مراحل',
                        subtitle: 'یادگیری ۴ مرحله اصلی',
                        icon: Icons.school,
                        color: Color(0xFFFF6B6B),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => StudyScreen()),
                        ),
                      ),
                      SizedBox(height: 20),
                      MenuCard(
                        title: 'آزمون خودت',
                        subtitle: 'تست حافظه و یادگیری',
                        icon: Icons.quiz,
                        color: Color(0xFF4ECDC4),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => QuizScreen()),
                        ),
                      ),
                      SizedBox(height: 20),
                      MenuCard(
                        title: 'مرور سریع',
                        subtitle: 'نگاه کلی به تمام مراحل',
                        icon: Icons.visibility,
                        color: Color(0xFFFFB74D),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OverviewScreen()),
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

class MenuCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  MenuCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2c3e50),
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_back_ios, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}

class StudyScreen extends StatefulWidget {
  @override
  _StudyScreenState createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  PageController _pageController = PageController();
  int currentPage = 0;

  final List<StudyStep> steps = [
    StudyStep(
      number: '۱',
      title: 'جستجوی اسپایدرها',
      icon: '🕷️',
      color: Color(0xFFFF6B6B),
      points: [
        'در وب می‌چرخند و مستندات جدید پیدا می‌کنند',
        'عموماً از هایپرلینک‌هایی شروع می‌کنند که قبلاً در پایگاه داده آنها وجود داشته است',
      ],
    ),
    StudyStep(
      number: '۲',
      title: 'ایندکس کردن',
      icon: '📚',
      color: Color(0xFF4ECDC4),
      points: [
        'محتویات را به صورت متن و کد ایندکس می‌کنند',
        'سپس آنها را به پایگاه داده خود اضافه می‌کنند',
        'سپس به شکل دوره‌ای این اطلاعات را به روزرسانی می‌کنند',
      ],
    ),
    StudyStep(
      number: '۳',
      title: 'جستجوی کاربر',
      icon: '🔎',
      color: Color(0xFF45B7D1),
      points: [
        'در درون دیتابیس خود می‌گردند',
        'هنگامی که یک کاربر اصطلاحی را برای جستجو وارد می‌کند',
        'اطلاعات مورد نظر خود را بیابد',
      ],
    ),
    StudyStep(
      number: '۴',
      title: 'رتبه‌بندی',
      icon: '📊',
      color: Color(0xFFFFA726),
      points: [
        'اسناد یافت شده را رتبه‌بندی می‌کنند',
        'از الگوریتم‌ها که فرمول‌های ریاضی هستند استفاده می‌کنند',
        'به آنها وزن و رتبه تخصیص می‌دهند',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مطالعه مراحل', textDirection: TextDirection.rtl),
        backgroundColor: Color(0xFF667eea),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(steps.length, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: currentPage == index ? Color(0xFF667eea) : Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                );
              }),
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
              itemCount: steps.length,
              itemBuilder: (context, index) {
                return StudyCard(step: steps[index]);
              },
            ),
          ),
          // Navigation
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentPage < steps.length - 1)
                  ElevatedButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF667eea),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                    child: Text('بعدی', style: TextStyle(color: Colors.white)),
                  ),
                if (currentPage == steps.length - 1)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => QuizScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4ECDC4),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                    child: Text('شروع آزمون', style: TextStyle(color: Colors.white)),
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

class StudyCard extends StatefulWidget {
  final StudyStep step;

  StudyCard({required this.step});

  @override
  _StudyCardState createState() => _StudyCardState();
}

class _StudyCardState extends State<StudyCard> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: widget.step.color.withOpacity(0.3),
              blurRadius: 15,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            // Step Header
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: widget.step.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text(
                    widget.step.icon,
                    style: TextStyle(fontSize: 50),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'مرحله ${widget.step.number}',
                    style: TextStyle(
                      fontSize: 16,
                      color: widget.step.color,
                      fontWeight: FontWeight.bold,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.step.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2c3e50),
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            // Step Points
            Expanded(
              child: ListView.builder(
                itemCount: widget.step.points.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: widget.step.color.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border(
                        right: BorderSide(color: widget.step.color, width: 4),
                      ),
                    ),
                    child: Text(
                      widget.step.points[index],
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Color(0xFF2c3e50),
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class StudyStep {
  final String number;
  final String title;
  final String icon;
  final Color color;
  final List<String> points;

  StudyStep({
    required this.number,
    required this.title,
    required this.icon,
    required this.color,
    required this.points,
  });
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 0;
  int score = 0;
  bool showResult = false;

  final List<QuizQuestion> questions = [
    QuizQuestion(
      question: 'مرحله اول موتورهای جستجو چیست؟',
      options: ['ایندکس کردن', 'جستجوی اسپایدرها', 'رتبه‌بندی', 'نمایش نتایج'],
      correctAnswer: 1,
    ),
    QuizQuestion(
      question: 'اسپایدرها معمولاً از کجا شروع می‌کنند؟',
      options: ['از وب‌سایت‌های جدید', 'از هایپرلینک‌های موجود در پایگاه داده', 'از جستجوی کاربران', 'از الگوریتم‌ها'],
      correctAnswer: 1,
    ),
    QuizQuestion(
      question: 'در مرحله ایندکس کردن چه اتفاقی می‌افتد؟',
      options: ['محتویات پاک می‌شوند', 'محتویات به متن و کد تبدیل می‌شوند', 'رتبه‌بندی انجام می‌شود', 'نتایج نمایش داده می‌شوند'],
      correctAnswer: 1,
    ),
    QuizQuestion(
      question: 'برای رتبه‌بندی از چه استفاده می‌شود؟',
      options: ['فقط متن', 'الگوریتم‌ها و فرمول‌های ریاضی', 'نظرات کاربران', 'تاریخ انتشار'],
      correctAnswer: 1,
    ),
  ];

  void answerQuestion(int selectedAnswer) {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('آزمون خودت', textDirection: TextDirection.rtl),
        backgroundColor: Color(0xFF4ECDC4),
        elevation: 0,
      ),
      body: showResult ? _buildResultScreen() : _buildQuizScreen(),
    );
  }

  Widget _buildQuizScreen() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          // Progress
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Color(0xFF4ECDC4).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'سوال ${currentQuestion + 1} از ${questions.length}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4ECDC4),
                  ),
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  'امتیاز: $score',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4ECDC4),
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          // Question
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Text(
              questions[currentQuestion].question,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2c3e50),
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
          ),
          SizedBox(height: 30),
          // Options
          Expanded(
            child: ListView.builder(
              itemCount: questions[currentQuestion].options.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ElevatedButton(
                    onPressed: () => answerQuestion(index),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFF2c3e50),
                      padding: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Color(0xFF4ECDC4), width: 2),
                      ),
                    ),
                    child: Text(
                      questions[currentQuestion].options[index],
                      style: TextStyle(fontSize: 16),
                      textDirection: TextDirection.rtl,
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

    if (percentage >= 80) {
      resultMessage = 'عالی! شما به خوبی یاد گرفتید! 🎉';
      resultColor = Color(0xFF4CAF50);
    } else if (percentage >= 60) {
      resultMessage = 'خوب است! کمی بیشتر تمرین کنید 👍';
      resultColor = Color(0xFFFF9800);
    } else {
      resultMessage = 'نیاز به مطالعه بیشتر دارید 📚';
      resultColor = Color(0xFFF44336);
    }

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: resultColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Icon(
                  percentage >= 80 ? Icons.emoji_events : 
                  percentage >= 60 ? Icons.thumb_up : Icons.school,
                  size: 80,
                  color: resultColor,
                ),
                SizedBox(height: 20),
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
                SizedBox(height: 20),
                Text(
                  'نمره شما: $score از ${questions.length}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF2c3e50),
                  ),
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  '${percentage.toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: resultColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: resetQuiz,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4ECDC4),
                    padding: EdgeInsets.symmetric(vertical: 15),
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
                    backgroundColor: Color(0xFF667eea),
                    padding: EdgeInsets.symmetric(vertical: 15),
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

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswer;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}

class OverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مرور سریع', textDirection: TextDirection.rtl),
        backgroundColor: Color(0xFFFFB74D),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Process Flow
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'فرآیند کار موتورهای جستجو',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2c3e50),
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildFlowStep('🕷️', 'جستجو'),
                      Icon(Icons.arrow_back, color: Color(0xFFFFB74D)),
                      _buildFlowStep('📚', 'ایندکس'),
                      Icon(Icons.arrow_back, color: Color(0xFFFFB74D)),
                      _buildFlowStep('🔎', 'جستجوی کاربر'),
                      Icon(Icons.arrow_back, color: Color(0xFFFFB74D)),
                      _buildFlowStep('📊', 'رتبه‌بندی'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Quick Summary
            Expanded(
              child: ListView(
                children: [
                  _buildSummaryCard(
                    '🕷️ اسپایدرها',
                    'در وب چرخیده و مستندات جدید پیدا می‌کنند',
                    Color(0xFFFF6B6B),
                  ),
                  _buildSummaryCard(
                    '📚 ایندکس کردن',
                    'محتویات را تبدیل و ذخیره می‌کنند',
                    Color(0xFF4ECDC4),
                  ),
                  _buildSummaryCard(
                    '🔎 جستجو',
                    'در دیتابیس دنبال اطلاعات می‌گردند',
                    Color(0xFF45B7D1),
                  ),
                  _buildSummaryCard(
                    '📊 رتبه‌بندی',
                    'با الگوریتم‌ها نتایج را مرتب می‌کنند',
                    Color(0xFFFFA726),
                  ),
                ],
              ),
            ),
            // Action Buttons
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StudyScreen()),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF667eea),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        'مطالعه دقیق',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QuizScreen()),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4ECDC4),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        'شروع آزمون',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlowStep(String emoji, String title) {
    return Column(
      children: [
        Text(emoji, style: TextStyle(fontSize: 24)),
        SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2c3e50),
          ),
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String description, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(right: BorderSide(color: color, width: 4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textDirection: TextDirection.rtl,
          ),
          SizedBox(height: 5),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF2c3e50),
            ),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }
}