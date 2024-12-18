class GuestPricing {
  static const int minPrice = 189;
  static const int maxPrice = 299;
  static const int maxGuests = 1500;

  static num calculatePrice(int guests) {
    double decrement = (maxPrice - minPrice) / maxGuests;
    return (maxPrice - decrement * guests).clamp(minPrice, maxPrice);
  }
}
