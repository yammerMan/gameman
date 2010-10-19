package roma.war.resource
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.xml.XMLDocument;
	
	import roma.war.util.SimpleXMLDecoder;
	
	public class ResourceLoader extends EventDispatcher
	{
		public var totalSize:Number = 1000;
		
		private var _ul:URLLoader;
		
		public function get loader():URLLoader{
			return _ul;
		}
				
		public function ResourceLoader(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function dispose():void{
			if(_ul){
				try{
				_ul.close();
				}catch(e:Error){trace(this,e)}
				
				_ul.removeEventListener(Event.COMPLETE,ServerResourceComplete);
				_ul.removeEventListener(Event.COMPLETE,reportComplete);
				//_ul.removeEventListener(Event.COMPLETE,embedComplete);
				_ul.removeEventListener(Event.COMPLETE,configComplete);
				_ul.removeEventListener(IOErrorEvent.IO_ERROR,allErrorEventHandler);
				_ul.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,allErrorEventHandler);
				_ul = null;
			}
		}
		
		/**
		 * 加载语言
		 */  
		public function loadLang(path:String):void{
			if(!_ul){
				_ul = new URLLoader();
			}
			_ul.dataFormat = URLLoaderDataFormat.TEXT;
			_ul.addEventListener(Event.COMPLETE,langComplete);
			_ul.addEventListener(IOErrorEvent.IO_ERROR,allErrorEventHandler);
			_ul.addEventListener(SecurityErrorEvent.SECURITY_ERROR,allErrorEventHandler);
			
			_ul.load(new URLRequest(path));
			
			function langComplete(event:Event):void{
				_ul.removeEventListener(Event.COMPLETE,langComplete);
				_ul.removeEventListener(IOErrorEvent.IO_ERROR,allErrorEventHandler);
				_ul.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,allErrorEventHandler);
				
				var obj:Object = {};
				var rs:String = new String(_ul.data);
				/* var rx:XMLDocument = new XMLDocument(rs);
				rx.ignoreWhite = true;
				var decoder:SimpleXMLDecoder = new SimpleXMLDecoder(true);
        		obj = decoder.decodeXML(rx); */
        		
				try{
					_ul.close();
				}catch(e:Error){trace(this,e);}
				
				dispatchEvent(new ResourceEvent(ResourceEvent.LANG_COMPLETE,rs));
			}
		}
		
		/**
		 * 
		 * load Outside Resource
		 * 
		 **/
		public function loadServerResource(path:String):void{
			_path = path;
			
			if(!_ul){
				_ul = new URLLoader();
			}
			_ul.dataFormat = URLLoaderDataFormat.BINARY;
			_ul.addEventListener(Event.COMPLETE,ServerResourceComplete);
			_ul.addEventListener(IOErrorEvent.IO_ERROR,allErrorEventHandler);
			_ul.addEventListener(SecurityErrorEvent.SECURITY_ERROR,allErrorEventHandler);
			
			_ul.load(new URLRequest(_path));
		}
		private function ServerResourceComplete(event:Event):void{
			_ul.removeEventListener(Event.COMPLETE,ServerResourceComplete);
			_ul.removeEventListener(IOErrorEvent.IO_ERROR,allErrorEventHandler);
			_ul.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,allErrorEventHandler);
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loaderLoaded);
			loader.loadBytes(ByteArray(_ul.data));
			function loaderLoaded(event:Event):void{
				var bmp:BitmapData = Bitmap(loader.content).bitmapData.clone()
				Bitmap(loader.content).bitmapData.dispose();
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loaderLoaded);
				loader.unload();
				dispatchEvent(new ResourceEvent(ResourceEvent.OUTSIDE_COMPLETE,bmp));
			}
			
			try{
				_ul.close();
			}catch(e:Error){trace(this,e);}
			
		}
		
		
		/**
		 *
		 * load report 
		 * 
		 **/
		 public function loadReportResource(path:String):void{
			_path = path;
			
			if(!_ul){
				_ul = new URLLoader();
			}
			_ul.dataFormat = URLLoaderDataFormat.TEXT;
			_ul.addEventListener(Event.COMPLETE,reportComplete);
			_ul.addEventListener(IOErrorEvent.IO_ERROR,allErrorEventHandler);
			_ul.addEventListener(SecurityErrorEvent.SECURITY_ERROR,allErrorEventHandler);
			
			_ul.load(new URLRequest(_path));
		}
		 private function reportComplete(event:Event):void{
			_ul.removeEventListener(Event.COMPLETE,reportComplete);
			_ul.removeEventListener(IOErrorEvent.IO_ERROR,allErrorEventHandler);
			_ul.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,allErrorEventHandler);
			
			var rs:String = new String(_ul.data);
			try{
				_ul.close();
			}catch(e:Error){trace(this,e);}
			
			dispatchEvent(new ResourceEvent(ResourceEvent.REPORT_COMPLETE,rs));
		}
		
		/**
		 *
		 * load embed resource 
		 * 
		 **/
		public function loadEmbedResource():void{
			EmbedResource.instance.load();
			embedComplete();
		}
		
		private function embedComplete(event:Event = null):void{
			dispatchEvent(new ResourceEvent(ResourceEvent.EMBED_COMPLETE));
		}
		
		/**
		 *
		 * load wareplayer settings at first time
		 * 
		 **/
		private var _path:String;
		public function loadSettings(path:String):void{
			_path = path;
			
			if(!_ul){
				_ul = new URLLoader();
			}
			_ul.dataFormat = URLLoaderDataFormat.TEXT;
			_ul.addEventListener(Event.COMPLETE,configComplete);
			_ul.addEventListener(IOErrorEvent.IO_ERROR,allErrorEventHandler);
			_ul.addEventListener(SecurityErrorEvent.SECURITY_ERROR,allErrorEventHandler);
			
			_ul.load(new URLRequest(_path));
		}
		
		private function configComplete(event:Event):void{
			_ul.removeEventListener(Event.COMPLETE,configComplete);
			_ul.removeEventListener(IOErrorEvent.IO_ERROR,allErrorEventHandler);
			_ul.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,allErrorEventHandler);
			
			var rs:String = new String(_ul.data);
			try{
				_ul.close();
			}catch(e:Error){trace(this,e);}
			
			dispatchEvent(new ResourceEvent(ResourceEvent.SETTINGS_COMPLETE,rs));
		}
		
		private function allErrorEventHandler(event:ErrorEvent):void{
			trace(this,event);
		}
		
	}
}