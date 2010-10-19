// ActionScript file
			import roma.util.MultiLang;
			import mx.events.ItemClickEvent;

			public static const WINDOW_SHOW:String = "wareHouseWin.show";
			[Bindable]			
			private var buttonTitle:Array=new Array(MultiLang.msg("wareHouse.manager"),MultiLang.msg("upgradingWin.upgradeRequest"));
			
			/**
			 *每次界面弹出调用，刷新数据
			 */ 
			override public function refresh():void{
				if(this.initialized){
					if(this.buttonBar.selectedIndex ==this.buttonTitle.length-1){
						this.buttonBar.selectedIndex = this.buttonTitle.length-1;
						this.myViewstack.selectedChild = this.upgradingWin;
						this.upgradingWin.refresh();
					}else{
						this.myViewstack.selectedIndex=this.buttonBar.selectedIndex=0;
						this.wareHouseControlWin.refresh();
					}
				}
			}
			
			override public function update():void{
				if(this.buildingObj.level<1){
					this.buttonBar.selectedIndex = this.buttonTitle.length-1;
					this.myViewstack.selectedChild = this.upgradingWin;
					this.buttonBar.enabled = false;
				}else{
					if(!this.buttonBar.enabled){
						this.buttonBar.enabled = true;
					}
				}
			}
			
			/**
			 * 界面隐藏调用，停止当前窗体一切相关动画等
			 */ 
			override public function destroy():void{
			
			}
			
			private function btnHandler(event:ItemClickEvent):void{
				switch(event.index){
					case 0:
						myViewstack.selectedChild=this.wareHouseControlWin;
						this.wareHouseControlWin.refresh();
						break;
					case 1:
						myViewstack.selectedChild=this.upgradingWin;
						this.upgradingWin.refresh();
						break;
					default:
				}
			}
			
			