package views.windows.buildings.townHall.production
{
	import mx.controls.Label;

	public class ThroughputLabel extends Label
	{
		public var origin:Number =0;	
		public function ThroughputLabel()
		{
			super();
			this.height = 22;
		}
		
		
		public function set workerEfficiency(per:Number):void {
			if (per>0) {
				this.text = String((this.origin * per)) ;
			} else {
				this.text = "0";
			}
		}
	}
}