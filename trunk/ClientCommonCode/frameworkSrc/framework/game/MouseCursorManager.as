package framework.game
{
	import flash.ui.Mouse;
	
	import mx.managers.CursorManager;
	
	public class MouseCursorManager
	{
		private static var _isBusy:Boolean = false;

		public static function setBusy():void {
			if (!_isBusy) {
				try{
					_isBusy = true;
					CursorManager.setBusyCursor();
				}catch(e:Error){
				}
			}
			Mouse.show();
		}
		
		public static function setNormal():void {
			if (_isBusy) {
				try{
					_isBusy = false;
					CursorManager.removeBusyCursor();
				}catch(e:Error){
					Mouse.show();
				}
			}
		}

	}
}