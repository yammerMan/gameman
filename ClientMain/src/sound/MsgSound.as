package sound
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import roma.logic.CaesaryConfig;
	
	public class MsgSound
	{
		private static var log:ILogger = Log.getLogger("roma.sound.MsgSound");
		public static var instance:MsgSound = new MsgSound();
		
		private var completeSound:Sound;

		private var warSound:Sound;
		
		private var bravoSound:Sound;

		private var mapMusic:Sound;
		private var mapMusicPlaying:Boolean = false;
		
		private var bgSound:Sound;

		public function MsgSound(){
			[Embed(source="sound.swf" , symbol="upgradeComplete")]
			var completeSoundClass:Class;
			this.completeSound = new completeSoundClass();

			[Embed(source="sound.swf" , symbol="war")]
			var warSoundClass:Class;
			this.warSound = new warSoundClass();

			[Embed(source="sound.swf" , symbol="mapMusic")]
			var mapMusicClass:Class;
			this.mapMusic = new mapMusicClass();
			
			[Embed(source="sound.swf" , symbol="bravo")]
			var bravoSoundClass:Class;
			this.bravoSound = new bravoSoundClass();
			
/* 			[Embed(source="sound.swf" , symbol="bgSound")]
			var bgs:Class;
			this.bgSound= new bgs();
 */		}

		public function playBraveSound():void {
			if(CaesaryConfig.instance.isPlaySound){
				this.bravoSound.play();
			}
		}

		public function playMsgSound():void {
			if(CaesaryConfig.instance.isPlaySound){
				this.completeSound.play();
			}
		}
	
		public function playWarSound():void {
			if(CaesaryConfig.instance.isPlaySound){
				this.warSound.play();
			}
		}
		
/* 		public function playBgSound():void{
			if(CaesaryConfig.instance.isPlaySound){
				this.bgSound.play(0,10000);
			}
		}
 */		
		public function stopAllSound():void{
			if(mapMusicPlaying){
				mapMusicPlaying = false;
				SoundMixer.stopAll();
			}
		}
	
		public function playMapMusic():void {
			if(CaesaryConfig.instance.isPlaySound){
				if (!this.mapMusicPlaying) {
					var channel:SoundChannel = this.mapMusic.play(0,3);
					log.debug("play map music");
					
					if (channel !=null) {
						this.mapMusicPlaying = true;
						channel.addEventListener(Event.SOUND_COMPLETE, completeHandle);
						
						function completeHandle(event:Event):void {
							log.debug("map music complete");
							mapMusicPlaying = false;
						}
					}
				}
			}
		}
		
	}
}