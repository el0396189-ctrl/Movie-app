import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Screen extends StatefulWidget {
const Screen({super.key});

@override
State<Screen> createState() => _State();
}

class _State extends State<Screen> {
var newList = [];

@override
void initState() {
super.initState();
fetchMovies();
}

fetchMovies() async {
final repo = await http.get(
Uri.parse(
'https://www.omdbapi.com/?s=Batman&apikey=f0491f9f',
),
);

final data = repo.body;
final moviesData = jsonDecode(data);

final movies = moviesData['Search'];

setState(() {
newList = movies ?? [];
});
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xFF10121A),
appBar: AppBar(
title: const Text(
'Movies App',
style: TextStyle(
fontWeight: FontWeight.bold,
fontSize: 24,
),
),
centerTitle: true,
backgroundColor: const Color(0xFF10121A),
foregroundColor: Colors.white,
elevation: 0,
),
body: ListView.separated(
padding: const EdgeInsets.all(16),
itemBuilder: (context, index) {
return Card(
color: const Color(0xFF202330),
elevation: 4,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(16),
),
clipBehavior: Clip.antiAlias,
child: Padding(
padding: const EdgeInsets.all(12),
child: Row(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
ClipRRect(
borderRadius: BorderRadius.circular(10),
child: Image.network(
newList[index]['Poster'] ?? '',
width: 110,
height: 155,
fit: BoxFit.cover,
errorBuilder: (context, error, stackTrace) {
return Container(
width: 110,
height: 155,
color: Colors.black26,
child: const Icon(
Icons.movie,
color: Colors.white54,
size: 40,
),
);
},
),
),
const SizedBox(width: 15),
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
newList[index]['Title'] ??
'Title not available',
style: const TextStyle(
color: Colors.white,
fontSize: 18,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 12),
Row(
children: [
const Icon(
Icons.calendar_month,
color: Colors.amber,
size: 20,
),
const SizedBox(width: 6),
Text(
newList[index]['Year'] ?? 'Unknown',
style: const TextStyle(
color: Colors.white70,
fontSize: 14,
),
),
],
),
const SizedBox(height: 12),
Container(
padding: const EdgeInsets.symmetric(
horizontal: 10,
vertical: 6,
),
decoration: BoxDecoration(
color: Colors.amber.withOpacity(0.15),
borderRadius: BorderRadius.circular(8),
),
child: Text(
(newList[index]['Type'] ?? 'movie')
    .toString()
    .toUpperCase(),
style: const TextStyle(
color: Colors.amber,
fontSize: 12,
fontWeight: FontWeight.bold,
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
},
separatorBuilder: (context, index) {
return const SizedBox(height: 14);
},
itemCount: newList.length,
),
);
}
}
