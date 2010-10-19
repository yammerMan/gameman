package views.windows.functionWins.task
{
	import mx.containers.HBox;
	import mx.controls.Image;
	import mx.controls.Label;
	import mx.controls.Spacer;
	
	import roma.resource.ImgManager;

	public class LabelWithIcon extends HBox
	{
		private var img:Image = new Image;
		private var lab:Label = new Label;
		private var sp:Spacer= new Spacer;

		public function LabelWithIcon()
		{
			super();
			this.addChild(img);
			lab.styleName = "taskSubLabel";
			this.addChild(lab);
			sp.width=1;
			this.addChild(sp);
		}
		
		public function set iconSource(icon:String):void{
			this.img.source = ImgManager.clazz(icon);
		}
		
		public function set textStr(str:String):void{
			lab.text = str;
		}
	}
}