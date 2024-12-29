import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({super.key});

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool isStopped = true;
  Duration duration = Duration();
  Duration position = Duration();

  void playAudio() async {
    try {
      await audioPlayer.play(AssetSource('assets/audio/sample_audio.mp3'));
      setState(() {
        isPlaying = true;
        isStopped = false;
      });
    } catch (e) {
      print("Error playing audio: $e");
      // Display error to the user
    }
  }

  void pauseAudio() async {
    await audioPlayer.pause();
    setState(() {
      isPlaying = false;
    });
  }

  void stopAudio() async {
    await audioPlayer.stop();
    setState(() {
      isPlaying = false;
      isStopped = true;
      position = Duration();
    });
  }

  void onAudioPositionChanged(Duration position) {
    setState(() {
      this.position = position;
    });
  }

  void onAudioDurationChanged(Duration duration) {
    setState(() {
      this.duration = duration;
    });
  }

  @override
  void initState() {
    super.initState();
    audioPlayer.onPositionChanged.listen(onAudioPositionChanged);
    audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.completed) {
        setState(() {
          isPlaying = false;
          isStopped = true;
          position = Duration();
        });
      }
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: isPlaying ? pauseAudio : playAudio,
          child: Text(isPlaying ? 'Pause' : 'Play'),
        ),
        ElevatedButton(
          onPressed: stopAudio,
          child: Text('Stop'),
        ),
        if (!isStopped) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: LinearProgressIndicator(
              value: position.inMilliseconds / duration.inMilliseconds,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
          Text('${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')} / ${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}'),
        ],
      ],
    );
  }
}
