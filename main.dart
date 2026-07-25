import 'package:flutter/material.dart';

void main() {
  runApp(const KukusmartApp());
}

class KukusmartApp extends StatelessWidget {
  const KukusmartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kukusmart',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const KukusmartHomeScreen(),
    );
  }
}

class KukusmartHomeScreen extends StatefulWidget {
  const KukusmartHomeScreen({super.key});

  @override
  State<KukusmartHomeScreen> createState() => _KukusmartHomeScreenState();
}

class _KukusmartHomeScreenState extends State<KukusmartHomeScreen> {
  // Master list of symptoms
  final List<String> _symptoms = [
    'Bloody / watery droppings',
    'Swollen face or eyes',
    'Twisted neck / paralysis',
    'Wart-like scabs on comb',
    'Difficulty breathing / gasping',
    'Lethargy / ruffled feathers',
  ];

  final Set<String> _selectedSymptoms = {};

  // Diagnosis logic for Kukusmart
  Map<String, String> _getDiagnosis() {
    if (_selectedSymptoms.contains('Bloody / watery droppings')) {
      return {
        'disease': 'Coccidiosis',
        'type': 'Parasitic Infection',
        'action': 'Isolate sick birds immediately. Clean and dry the bedding/litter. Administer vet-approved anticoccidial treatment in drinking water.',
      };
    } else if (_selectedSymptoms.contains('Twisted neck / paralysis') ||
        _selectedSymptoms.contains('Difficulty breathing / gasping')) {
      return {
        'disease': 'Newcastle Disease',
        'type': 'Viral Infection',
        'action': 'Quarantine affected birds. Newcastle spreads rapidly. Contact a local vet and enforce strict biosecurity (disinfect footwear and entryways).',
      };
    } else if (_selectedSymptoms.contains('Wart-like scabs on comb')) {
      return {
        'disease': 'Fowl Pox',
        'type': 'Viral Infection',
        'action': 'Apply antiseptic ointment to dry scabs. Control mosquitoes around the coop, as they transmit the virus.',
      };
    } else if (_selectedSymptoms.contains('Swollen face or eyes')) {
      return {
        'disease': 'Infectious Coryza',
        'type': 'Bacterial Infection',
        'action': 'Isolate affected birds. Improve ventilation without drafts. Consult a vet for antibiotic treatment.',
      };
    } else if (_selectedSymptoms.isEmpty) {
      return {
        'disease': 'No symptoms selected',
        'type': 'Select symptoms above',
        'action': 'Tap one or more symptoms observed in your flock to view potential matches and treatment advice.',
      };
    }
    return {
      'disease': 'Multiple Symptoms Detected',
      'type': 'General Assessment',
      'action': 'Symptoms suggest possible mixed infection or stress. Ensure clean water with electrolytes and consult a veterinarian for precise diagnosis.',
    };
  }

  @override
  Widget build(BuildContext context) {
    final diagnosis = _getDiagnosis();

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.pets, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Kukusmart',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.green[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Header Card
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.health_and_safety, size: 36, color: Colors.green),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Smart Health Assistant\nSelect observed symptoms to evaluate flock health.',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Observed Symptoms:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            
            // Symptom Selection List
            Expanded(
              child: ListView.builder(
                itemCount: _symptoms.length,
                itemBuilder: (context, index) {
                  final symptom = _symptoms[index];
                  final isSelected = _selectedSymptoms.contains(symptom);
                  return CheckboxListTile(
                    activeColor: Colors.green[700],
                    title: Text(symptom, style: const TextStyle(fontSize: 15)),
                    value: isSelected,
                    onChanged: (bool? checked) {
                      setState(() {
                        if (checked == true) {
                          _selectedSymptoms.add(symptom);
                        } else {
                          _selectedSymptoms.remove(symptom);
                        }
                      });
                    },
                  );
                },
              ),
            ),

            // Assessment Result Card
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.green[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      diagnosis['disease']!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[900],
                      ),
                    ),
                    Text(
                      'Category: ${diagnosis['type']!}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                    const Divider(),
                    Text(
                      diagnosis['action']!,
                      style: const TextStyle(fontSize: 14, height: 1.3),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
