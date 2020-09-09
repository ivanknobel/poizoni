class ExpansionPanelItem {
  ExpansionPanelItem({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
    this.details = "",
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
  String details;
}