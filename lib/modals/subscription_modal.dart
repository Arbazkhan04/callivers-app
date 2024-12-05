class SubscriptionItemModalClass {
  final String label;
  final String planName;
  final String price;
  bool isSelected;
  final List<String> features; // Renamed to 'features'

  SubscriptionItemModalClass({
    required this.label,
    required this.planName,
    required this.price,
    this.isSelected = false, // Default value set to false
    this.features = const [], // Default empty list
  });

  // Factory method to create an instance from a Map
  factory SubscriptionItemModalClass.fromMap(Map<String, dynamic> map) {
    return SubscriptionItemModalClass(
      label: map['label'] ?? '',
      planName: map['planName'] ?? '',
      price: map['price'] ?? '',
      isSelected: map['isSelected'] ?? false,
      features: List<String>.from(map['features'] ?? []),
    );
  }

  // Method to convert an instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'planName': planName,
      'price': price,
      'isSelected': isSelected,
      'features': features,
    };
  }
}
