package views.windows.buildings.townHall.production
{
	import mx.controls.Label;

	public class NumberLabel extends Label
	{
		public var origin:Number =0;
		
		public function NumberLabel()
		{
			super();
			this.height = 22;
		}
		
		
		public function set addPercent(per:int):void {
			if (per>=0) {
				this.text = String(int(this.origin * per/100)) ;
				this.styleName='';
			} else {
				this.text = "0";
				this.styleName='NoticeLabel';
			}
		}
		
		public function set num(num:Number):void {
			if (num>=0) {
				this.text = String(int(num));
				this.styleName='';
			} else {
				this.text = "0";
				this.styleName='NoticeLabel';
			}
		}
	}
}