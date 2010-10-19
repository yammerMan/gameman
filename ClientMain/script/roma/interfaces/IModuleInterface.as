package roma.interfaces
{
	public interface IModuleInterface
	{
		/**
		 * 当界面弹开时候调用此方法，刷新数据
		 */ 
		function refresh():void;
		
		/**
		 * 当界面隐藏时调用此方法，停止每帧动画或定时器等
		 */ 
		function destroy():void;
		
		/**
		 * 更新数据
		 */
		function update():void;
	}
}