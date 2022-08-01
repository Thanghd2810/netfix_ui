import 'package:flutter/material.dart';
import 'package:netfix_ui/models/content_model.dart';
import 'package:netfix_ui/widgets/widgets.dart';
import 'package:video_player/video_player.dart';

class ContentHeader extends StatefulWidget {
  const ContentHeader({Key? key, required this.futuredContent})
      : super(key: key);
  final Content futuredContent;

  @override
  State<ContentHeader> createState() => _ContentHeaderState();
}

class _ContentHeaderState extends State<ContentHeader> {
  late VideoPlayerController _videoController;
  bool _isMute = true;
  @override
  void initState() {
    // TODO: implement initState
    _videoController =
        VideoPlayerController.network(widget.futuredContent.videoUrl!)
          ..initialize().then((value) {
            setState(() {});
          })
          ..setVolume(0)
          ..play();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _videoController.value.isPlaying
          ? _videoController.pause()
          : _videoController.play(),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: 400,
            child: AspectRatio(
              aspectRatio: _videoController.value.isInitialized
                  ? _videoController.value.aspectRatio
                  : 2.344,
              child: _videoController.value.isInitialized
                  ? VideoPlayer(_videoController)
                  : Image.asset(
                      widget.futuredContent.imageUrl,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          // Container(
          //   height: 500,
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage(widget.futuredContent.imageUrl),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          Container(
            height: 500,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Positioned(
            left: 60,
            right: 60,
            bottom: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250,
                  child: Image.asset(widget.futuredContent.titleImageUrl!),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  widget.futuredContent.description!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(2, 4),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              _PlayButton(onTap: () {
                _videoController.value.isPlaying
                    ? _videoController.pause()
                    : _videoController.play();
              }),
              const SizedBox(
                width: 16,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // Background color
                ),
                onPressed: () {},
                icon: const Icon(
                  Icons.info_outline,
                  size: 30,
                  color: Colors.black,
                ),
                label: const Text(
                  "More Info",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              if (_videoController.value.isInitialized)
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isMute
                          ? _videoController.setVolume(100)
                          : _videoController.setVolume(0);
                      _isMute = _videoController.value.volume == 0;
                    });
                  },
                  icon: Icon(
                    _isMute ? Icons.volume_off : Icons.volume_down,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
            ],
          ),
          // Positioned(
          //   bottom: 110,
          //   child: SizedBox(
          //     width: 250,
          //     child: Image.asset(widget.futuredContent.titleImageUrl!),
          //   ),
          // ),
          // Positioned(
          //   left: 0,
          //   right: 0,
          //   bottom: 40,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       VerticalIconButton(
          //         icon: Icons.add,
          //         title: "List",
          //         onTap: () {},
          //       ),
          //       _PlayButton(),
          //       VerticalIconButton(
          //         icon: Icons.info_outline,
          //         title: "Info",
          //         onTap: () {},
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({Key? key, required this.onTap}) : super(key: key);
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: Colors.white, // Background color
      ),
      onPressed: onTap,
      icon: const Icon(
        Icons.play_arrow,
        size: 30,
        color: Colors.black,
      ),
      label: const Text(
        "Play",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
