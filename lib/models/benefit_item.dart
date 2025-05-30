class BenefitItem {
  final String title;
  final String? expandedTitle;
  final List<BenefitDetail>? details;
  final String? example;

  BenefitItem({
    required this.title,
    this.expandedTitle,
    this.details,
    this.example,
  });
}

class BenefitDetail {
  final String title;
  final String description;

  BenefitDetail({
    required this.title,
    required this.description,
  });
}