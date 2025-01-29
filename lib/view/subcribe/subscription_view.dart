import 'package:flutter/material.dart';

class SubscriptionView extends StatefulWidget {
  @override
  State<SubscriptionView> createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView> {
  final List<Map<String, dynamic>> plans = [
    {
      'name': 'Starter',
      'price': '\$10',
      'features': [
        '100 Coins',
        '1 Coin = 1 Minute of Expert Call',
        'Basic Support'
      ],
    },
    {
      'name': 'Professional',
      'price': '\$25',
      'features': [
        '300 Coins',
        '1 Coin = 1 Minute of Expert Call',
        'Priority Support'
      ],
    },
    {
      'name': 'Elite',
      'price': '\$50',
      'features': [
        '700 Coins',
        '1 Coin = 1 Minute of Expert Call',
        'Dedicated Support'
      ],
    },
  ];

  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CloudxTro'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: plans.length,
          itemBuilder: (context, index) {
            final plan = plans[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  expandedIndex = expandedIndex == index ? null : index;
                });
              },
              child: SubscriptionCard(
                name: plan['name'],
                price: plan['price'],
                features: plan['features'],
                isExpanded: expandedIndex == index,
              ),
            );
          },
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  final String name;
  final String price;
  final List<String> features;
  final bool isExpanded;

  const SubscriptionCard({
    required this.name,
    required this.price,
    required this.features,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.purpleAccent,
                  ),
                ),
              ],
            ),
            if (isExpanded) ...[
              SizedBox(height: 10),
              ...features.map((feature) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.purpleAccent,
                          size: 20,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            feature,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: Text('Subscribe!'),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
