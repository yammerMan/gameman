package skins
{

import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.display.Shape;
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.geom.Rectangle;
import flash.net.URLRequest;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
import flash.utils.getDefinitionByName;

import mx.core.EdgeMetrics;
import mx.core.FlexLoader;
import mx.core.FlexShape;
import mx.core.IChildList;
import mx.core.IContainer;
import mx.core.IRawChildrenContainer;
import mx.core.IRectangularBorder;
import mx.core.mx_internal;
import mx.resources.IResourceManager;
import mx.resources.ResourceManager;
import mx.skins.Border;
import mx.styles.ISimpleStyleClient;

use namespace mx_internal;

[ResourceBundle("skins")]


	public class RecBorder extends Border implements IRectangularBorder{
	
	    public function RecBorder()
	    {
	        super();
	        
	        addEventListener(Event.REMOVED, removedEventHandler);
	    }
	
	    private var bgImageStyle:Object
	
	    private var bgImageWidth:Number;
	
	    private var bgImageHeight:Number;
	
	    private var resManager:IResourceManager =ResourceManager.getInstance();
	
	
	    private var backgroundContainer:DisplayObject;
	
	    public function get hasBackgroundImage():Boolean
	    {
	        return backgroundContainer != null;
	    }
	
	    private var _thisBackgroundImageBounds:Rectangle;
	
	    public function get backgroundImageBounds():Rectangle
	    {
	        return _thisBackgroundImageBounds;
	    }
	
	    public function set backgroundImageBounds(v:Rectangle):void
	    {
	        _thisBackgroundImageBounds = v;
	
	        invalidateDisplayList();
	    }
	
	    override protected function updateDisplayList(unscaledWidth:Number,unscaledHeight:Number):void
	    {
	        if (!parent)
	            return;
	            
	        var newStyle:Object = getStyle("backgroundImage");
	        if (newStyle != bgImageStyle)
	        {
	            removedEventHandler(null);
	            
	            bgImageStyle = newStyle;
	
	            var cls:Class;
	
	            if (newStyle && newStyle as Class)
	            {
	
	                cls = Class(newStyle);
	                initBGImage(new cls());
	            }
	            else if (newStyle && newStyle is String)
	            {
	                try
	                {
	                    cls = Class(getDefinitionByName(String(newStyle)));
	                }
	                catch(e:Error)
	                {
	
	                }
	
	                if (cls)
	                {
	                    var newStyleObj:DisplayObject = new cls();
	                    initBGImage(newStyleObj);
	                }
	                else
	                {
	                    const loader:Loader = new FlexLoader();
	                    loader.contentLoaderInfo.addEventListener(
	                        Event.COMPLETE, completedHandler);
	                    loader.contentLoaderInfo.addEventListener(
	                        IOErrorEvent.IO_ERROR, errorHandler);
	                    loader.contentLoaderInfo.addEventListener(
	                        ErrorEvent.ERROR, errorHandler);
	                    var loaderContext:LoaderContext = new LoaderContext();
	                    loaderContext.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
	                    loader.load(new URLRequest(String(newStyle)), loaderContext);       
	                }
	            }
	            else if (newStyle) 
	            {
	                var message:String = resManager.getString(
	                    "skins", "notLoaded", [ newStyle ]);
	                throw new Error(message);
	            }
	        }
	        
	        if (backgroundContainer)
	            layoutBackgroundImage();
	    }
	
	    private function initBGImage(image:DisplayObject):void
	    {
	        backgroundContainer = image;
	        
	        if (image is Loader)
	        {
	            bgImageWidth = Loader(image).contentLoaderInfo.width;
	            bgImageHeight = Loader(image).contentLoaderInfo.height;
	        }
	        else
	        {
	            bgImageWidth = backgroundContainer.width;
	            bgImageHeight = backgroundContainer.height;
	            
	            if (image is ISimpleStyleClient)
	            {
	                ISimpleStyleClient(image).styleName = styleName;
	            }
	        }
	        var childrenList:IChildList = parent is IRawChildrenContainer ?
	                                         IRawChildrenContainer(parent).rawChildren :
	                                         IChildList(parent);
	
	        const backgroundMask:Shape = new FlexShape();
	        backgroundMask.name = "backgroundMask";
	        backgroundMask.x = 0;
	        backgroundMask.y = 0;
	        childrenList.addChild(backgroundMask);
	
	        var myIndex:int = childrenList.getChildIndex(this);
	        childrenList.addChildAt(backgroundContainer, myIndex + 1);                  
	        
	        backgroundContainer.mask = backgroundMask;
	    }
	    public function layoutBackgroundImage():void 
	    {
	        var container:DisplayObject = parent;
	        
	        var em:EdgeMetrics = container is IContainer ?
	                             IContainer(container).viewMetrics :
	                             borderMetrics;
	        
	        var allowScroll:Boolean =
	            getStyle("backgroundAttachment") != "fixed";
	
	        var scrollW:Number,
	            scrollH:Number;
	        if (_thisBackgroundImageBounds)
	        {
	            scrollW = _thisBackgroundImageBounds.width;
	            scrollH = _thisBackgroundImageBounds.height;
	        }
	        else
	        {
	            scrollW = width - em.left - em.right;
	            scrollH = height - em.top - em.bottom;
	        }
	
	        var pTage:Number = getBGSize();
	
	        var scrollX:Number,
	            scrollY:Number;
	        if (isNaN(pTage))
	        {
	            scrollX = 1.0;
	            scrollY = 1.0;
	        }
	        else
	        {
	            var scaleValue:Number = pTage * 0.01;
	            scrollX = scaleValue * scrollW / bgImageWidth;
	            scrollY = scaleValue * scrollH / bgImageHeight;
	        }
	        backgroundContainer.scaleX = scrollX;
	        backgroundContainer.scaleY = scrollY;
	
	        var oX:Number =
	                Math.round(0.5 * (scrollW - bgImageWidth * scrollX));
	        var oY:Number =
	                Math.round(0.5 * (scrollH - bgImageHeight * scrollY));
	
	        backgroundContainer.x = em.left;
	        backgroundContainer.y = em.top;
	
	        const bgMask:Shape = Shape(backgroundContainer.mask);
	        bgMask.x = em.left;
	        bgMask.y = em.top;
	
	        if (allowScroll && container is IContainer)
	        {
	            oX -= IContainer(container).horizontalScrollPosition;
	            oY -= IContainer(container).verticalScrollPosition;
	        }
	
	        backgroundContainer.alpha = getStyle("backgroundAlpha");
	        
	        backgroundContainer.x += oX;
	        backgroundContainer.y += oY;
	
	        backgroundContainer.x = 0;
	        backgroundContainer.y = 0;
	
	        var maskW:Number = width - em.left - em.right;
	        var maskH:Number = height - em.top - em.bottom; 
	        if (bgMask.width != maskW ||
	            bgMask.height != maskH)
	        {
	            var graphics:Graphics = bgMask.graphics;
	            graphics.clear();
	            graphics.beginFill(0xFFFFFF);
	            graphics.drawRect(0, 0, maskW, maskH);
	            graphics.endFill();
	        }
	    }
	
	    private function getBGSize():Number
	    {   
	        var pTage:Number = NaN;
	        var backgroundSize:Object = getStyle("backgroundSize");
	
	        if (backgroundSize && backgroundSize is String)
	        {
	            var index:int = backgroundSize.indexOf("%");
	            if (index != -1)
	                pTage = Number(backgroundSize.substr(0, index));
	        }
	        
	        return pTage;
	    }
	
	    private function errorHandler(event:Event):void 
	    {
	   
	    }
	    
	    /**
	     *  @private
	     */
	    private function completedHandler(event:Event):void 
	    {
	        if (!parent)
	            return;
	            
	        var target:DisplayObject = DisplayObject(LoaderInfo(event.target).loader);
	        initBGImage(target);
	        layoutBackgroundImage();
	        dispatchEvent(event.clone());
	    }
	
	    private function removedEventHandler(event:Event):void
	    {
	        if (backgroundContainer)
	        {
	            var childList:IChildList = parent is IRawChildrenContainer ?
	                                             IRawChildrenContainer(parent).rawChildren :
	                                             IChildList(parent);
	                                             
	            childList.removeChild(backgroundContainer.mask);
	            childList.removeChild(backgroundContainer);
	            backgroundContainer = null;
	        }
	    }
	}
}
