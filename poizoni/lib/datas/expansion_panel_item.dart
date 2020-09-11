class ExpansionPanelItem {
  ExpansionPanelItem({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
    this.details = "",
    this.showMore = false
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
  String details;
  bool showMore;
}