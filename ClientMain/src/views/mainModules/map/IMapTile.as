package views.mainModules.map
{
	import roma.common.valueObject.SimpleMapCastleBean;
	
	public interface IMapTile
	{
		function getFieldX():int;
		function getFieldY():int;
		function getFieldType():int;
		function getFieldLevel():int;
		function getMapCityBean():SimpleMapCastleBean;
	}
}