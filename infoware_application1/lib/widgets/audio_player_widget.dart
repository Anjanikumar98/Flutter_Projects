import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerWidget extends StatefulWidget {
  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;

  void playAudio() async {
    try {
      // Use `Source.asset` to load the audio file
      await audioPlayer.play(AssetSource('audio/sample_audio.mp3'));
      setState(() {
        isPlaying = true;
      });
    } catch (e) {
      print("Error playing audio: $e");
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
    });
  }

  @override
  void dispose() {
    // Dispose of the audio player to free resources
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
      ],
    );
  }
}
