import 'package:flutter/material.dart';
import '../models/benefit_item.dart';
import '../utils/constants.dart';

class ExpandableBenefitCard extends StatefulWidget {
  final List<BenefitItem> benefits;
  final Color color;

  ExpandableBenefitCard({
    required this.benefits,
    required this.color,
  });

  @override
  _ExpandableBenefitCardState createState() => _ExpandableBenefitCardState();
}

class _ExpandableBenefitCardState extends State<ExpandableBenefitCard> {
  List<bool> _expandedItems = [];

  @override
  void initState() {
    super.initState();
    _expandedItems = List.filled(widget.benefits.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // Title
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [widget.color.withOpacity(0.1), widget.color.withOpacity(0.05)],
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              'فوائد بازاریابی الکترونیک',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: widget.color,
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
          ),
          
          SizedBox(height: 20),
          
          // Content
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: widget.color.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: widget.color.withOpacity(0.2)),
            ),
            child: Text(
              'پنج مزیت اصلی که بازاریابی الکترونیک ارائه می‌دهد',
              style: AppStyles.body.copyWith(
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.justify,
              textDirection: TextDirection.rtl,
            ),
          ),
          
          SizedBox(height: 20),
          
          // Expandable Benefits List
          Expanded(
            child: ListView.builder(
              itemCount: widget.benefits.length,
              itemBuilder: (context, index) {
                final benefit = widget.benefits[index];
                final isExpanded = _expandedItems[index];
                
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 6),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _expandedItems[index] = !_expandedItems[index];
                      });
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: isExpanded ? widget.color.withOpacity(0.1) : Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border(
                          right: BorderSide(
                            color: widget.color, 
                            width: isExpanded ? 6 : 4,
                          ),
                          top: BorderSide(
                            color: isExpanded ? widget.color.withOpacity(0.3) : Colors.transparent,
                            width: 1,
                          ),
                          bottom: BorderSide(
                            color: isExpanded ? widget.color.withOpacity(0.3) : Colors.transparent,
                            width: 1,
                          ),
                          left: BorderSide(
                            color: isExpanded ? widget.color.withOpacity(0.3) : Colors.transparent,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Title Row
                          Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              Expanded(
                                child: Text(
                                  benefit.title,
                                  style: AppStyles.body.copyWith(
                                    fontWeight: isExpanded ? FontWeight.bold : FontWeight.normal,
                                    color: isExpanded ? widget.color : AppColors.dark,
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                              Icon(
                                isExpanded ? Icons.expand_less : Icons.expand_more,
                                color: widget.color,
                              ),
                            ],
                          ),
                          
                          // Expanded Content
                          if (isExpanded) ...[
                            SizedBox(height: 15),
                            
                            // Expanded Title
                            if (benefit.expandedTitle != null)
                              Container(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  benefit.expandedTitle!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.dark,
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                            
                            // Details
                            if (benefit.details != null)
                              Column(
                                children: benefit.details!.map((detail) {
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 8),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      textDirection: TextDirection.rtl,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 6,
                                          height: 6,
                                          margin: EdgeInsets.only(top: 6, left: 8),
                                          decoration: BoxDecoration(
                                            color: widget.color,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                detail.title,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: widget.color,
                                                ),
                                                textDirection: TextDirection.rtl,
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                detail.description,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[700],
                                                ),
                                                textDirection: TextDirection.rtl,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            
                            // Example
                            if (benefit.example != null) ...[
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.info.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppColors.info.withOpacity(0.3),
                                  ),
                                ),
                                child: Row(
                                  textDirection: TextDirection.rtl,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.lightbulb_outline,
                                      color: AppColors.info,
                                      size: 20,
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'مثال عملی:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.info,
                                            ),
                                            textDirection: TextDirection.rtl,
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            benefit.example!,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: AppColors.dark,
                                            ),
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ],
                      ),
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
}