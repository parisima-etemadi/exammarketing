import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/study_topic.dart';
import '../utils/constants.dart';

class StudyCard extends StatefulWidget {
  final ContentSection section;
  final Color color;

  StudyCard({required this.section, required this.color});

  @override
  _StudyCardState createState() => _StudyCardState();
}

class _StudyCardState extends State<StudyCard> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

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
    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
    _animationController.forward();
  }

  String? _getSvgIcon() {
    String title = widget.section.title.toLowerCase();
    
    if (title.contains('اسپایدر') || title.contains('جستجوی اسپایدرها')) {
      return 'assets/svg/spider.svg';
    } else if (title.contains('ایندکس') || title.contains('ایندکس کردن')) {
      return 'assets/svg/index.svg';
    } else if (title.contains('جستجوی کاربر') || title.contains('کاربر')) {
      return 'assets/svg/user_search.svg';
    } else if (title.contains('رتبه') || title.contains('رتبه‌بندی')) {
      return 'assets/svg/ranking.svg';
    }
    
    // Return null if no icon matches
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final iconPath = _getSvgIcon();
    
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(0.3),
                blurRadius: 15,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Section Title with Icon (only if icon exists)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [widget.color.withOpacity(0.1), widget.color.withOpacity(0.05)],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: iconPath != null 
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      textDirection: TextDirection.rtl,
                      children: [
                        // Title Text - flexible and centered
                        Flexible(
                          child: Text(
                            widget.section.title,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: widget.color,
                            ),
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 8),
                        // SVG Icon (fixed size)
                        SvgPicture.asset(
                          iconPath,
                          width: 28,
                          height: 28,
                        ),
                      ],
                    )
                  : Text(
                      widget.section.title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: widget.color,
                      ),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
              
              SizedBox(height: 20),
              
              // Section Content
              if (widget.section.content.isNotEmpty) ...[
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: widget.color.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: widget.color.withOpacity(0.2)),
                  ),
                  child: Text(
                    widget.section.content,
                    style: AppStyles.body.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.rtl,
                  ),
                ),
                SizedBox(height: 20),
              ],
              
              // Section Points
              Expanded(
                child: ListView.builder(
                  itemCount: widget.section.points.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border(
                          right: BorderSide(color: widget.color, width: 4),
                        ),
                      ),
                      child: Text(
                        widget.section.points[index],
                        style: AppStyles.body,
                        textDirection: TextDirection.rtl,
                      ),
                    );
                  },
                ),
              ),
              
              // Note if exists
              if (widget.section.note != null) ...[
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.warning.withOpacity(0.3)),
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Icon(Icons.info_outline, color: AppColors.warning, size: 20),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'نکته: ${widget.section.note}',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.warning,
                            fontWeight: FontWeight.bold,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
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
