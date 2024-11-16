import 'package:flutter/material.dart';
import 'dart:async'; // For Timer functionality
import 'dart:math'; // For random number generation
import 'package:visibility_detector/visibility_detector.dart';
import '../models/post_model.dart';
import '../services/api_service.dart';
import 'post_detail_screen.dart';

class TimerProvider {
  final ValueNotifier<int> timeNotifier = ValueNotifier<int>(0);
  Timer? _timer;
  int _elapsedTime = 0;

  // Start or resume the timer
  void startTimer() {
    if (_timer == null || !_timer!.isActive) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        _elapsedTime++;
        timeNotifier.value = _elapsedTime;
      });
    }
  }

  // Pause the timer
  void pauseTimer() {
    _timer?.cancel();
  }

  // Reset the timer
  void resetTimer() {
    _elapsedTime = 0;
    timeNotifier.value = _elapsedTime;
  }

  // Dispose of the timer
  void dispose() {
    _timer?.cancel();
  }
}

class PostListScreen extends StatefulWidget {
  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  late Future<List<Post>> _posts;
  final Map<int, TimerProvider> _postTimers = {};
  final Set<int> _readPosts = {}; // Track read posts

  // Function to generate a random timer duration
  int generateRandomDuration() {
    final random = Random();
    return [10, 20, 25][random.nextInt(3)];
  }

  @override
  void initState() {
    super.initState();
    _posts = ApiService().fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
        backgroundColor: Colors.blueAccent, // Update AppBar color
      ),
      body: FutureBuilder<List<Post>>(
        future: _posts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: LinearProgressIndicator()); // Improved loading indicator
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.red)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No posts available.'));
          } else {
            final posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                final postId = post.id;

                if (postId == null) {
                  return ListTile(
                    title: Text('Unknown Post'),
                    subtitle: Text('This post has no ID.'),
                  );
                }

                if (!_postTimers.containsKey(postId)) {
                  _postTimers[postId] = TimerProvider();
                }

                final isRead = _readPosts.contains(postId);
                final randomDuration = generateRandomDuration(); // Random timer duration

                return VisibilityDetector(
                  key: Key(postId.toString()),
                  onVisibilityChanged: (info) {
                    final timer = _postTimers[postId]!;
                    if (info.visibleFraction > 0.5) {
                      timer.startTimer();
                    } else {
                      timer.pauseTimer();
                    }
                  },
                  child: Card( // Added Card widget for better UI
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    color: isRead ? Colors.white : Colors.yellow[100],
                    child: ListTile(
                      contentPadding: EdgeInsets.all(15),
                      title: Text(
                        post.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: ValueListenableBuilder<int>(
                        valueListenable: _postTimers[postId]!.timeNotifier,
                        builder: (_, time, __) => Text(
                          'Time visible: ${time}s',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.timer, color: Colors.blue),
                          SizedBox(width: 5),
                          Text(
                            '${randomDuration}s',
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          _readPosts.add(postId);
                        });
                        final timer = _postTimers[postId];
                        timer?.pauseTimer(); // Pause the timer when the post is tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostDetailScreen(postId: postId),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    // Clean up timers
    _postTimers.values.forEach((timer) => timer.dispose());
    super.dispose();
  }
}
