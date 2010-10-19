package views.windows.functionWins.military
{
	import roma.common.constants.TroopForConstants;
	import roma.logic.object.hero.HeroObj;
	
	public class AssignHelper 
	{
		
		public static var instance:AssignHelper = new AssignHelper();
		
		public var hasSecond:Boolean = false;
		
		public var troopInCastleArray:Array = new Array();
		
		public var firstArray:Array = new Array();
		public var secondArray:Array = new Array();
		
		public var dragUIAry:Array = new Array;
		
		public var dragObj:BaseTroopAtAssign;
		
		public var betweenHero:BetweenHeroAndHero = new BetweenHeroAndHero();
		public var betweenCastleAndHero:BetweenHeroAndCastle = new BetweenHeroAndCastle();
		
		public function AssignHelper() {
			this.addTroopInCastle(TroopForConstants.T_TRIARII);
			this.addTroopInCastle(TroopForConstants.T_CAVALRY);
			this.addTroopInCastle(TroopForConstants.T_URBAN_COHORT);
			this.addTroopInCastle(TroopForConstants.T_ARCHERS);
			this.addTroopInCastle(TroopForConstants.T_BALLISTAS);
			this.addTroopInCastle(TroopForConstants.T_ONAGERS);
			
			for (var i:int=0; i<6; i++ ) {
				this.firstArray.push(new TroopInHero());
				
				var ui:TroopInHero = new TroopInHero();
				ui.isSecond = true;
				this.secondArray.push(ui);
			}
			
			for(var d:int = 0;d<18;d++){
				var dragUI:DragUIComponent = new DragUIComponent();
				this.dragUIAry.push(dragUI);		
			}
		}
		
		private function addTroopInHero():void {
			var ui:TroopInHero = new TroopInHero();
			
		}
		
		private function addTroopInCastle(type:int):void {
			var ui:TroopInCastle = new TroopInCastle();
			ui.troop = type;
			this.troopInCastleArray.push(ui);
		}
		
		public function reset(hero:HeroObj):void {
			for each (var troopInCastle:TroopInCastle in this.troopInCastleArray) {
				troopInCastle.refresh(hero);
			}
			
			for (var i:int=0; i<6; i++ ) {
				var troopInHero:TroopInHero = this.firstArray[i];
				troopInHero.setTroop(hero,i);
			}
		}
		
		public function setSecondHero(hero:HeroObj):void {
			for (var i:int=0; i<6; i++ ) {
				var troopInHero:TroopInHero = this.secondArray[i];
				troopInHero.setTroop(hero,i);
			}
		}
		
		public function startDrag(obj:BaseTroopAtAssign):void {
			this.dragObj = obj;
			
			for each (var tc:TroopInCastle in this.troopInCastleArray) {
				tc.onStartDrag(obj);
			}
			
			for each (var th1:TroopInHero in this.firstArray) {
				th1.onStartDrag(obj);
			}
			
			if (this.hasSecond) {
				for each (var th2:TroopInHero in this.secondArray) {
					th2.onStartDrag(obj);
				}
			}
			
			for each(var dargUI:DragUIComponent in this.dragUIAry){
				if(!dargUI.isDraging()){
					dargUI.visible = false;
				}else{
					dargUI.visible = true;
				}
			}
		}
		
		public function isDragCanEnter(drag:DragUIComponent):Boolean{
			for each (var tc:TroopInCastle in this.troopInCastleArray) {
				if(tc.isHitTest(drag)){
					return true;
				}
			}
			
			for each (var th1:TroopInHero in this.firstArray) {
				if(th1.isHitTest(drag)){
					return true;				
				}
			}
			
			if (this.hasSecond) {
				for each (var th2:TroopInHero in this.secondArray) {
					if(th2.isHitTest(drag)){
						return true;					
					}
				}
			}
			
			return false;
		}
		
		public function dragComplete(drag:DragUIComponent):void {
			for each (var tc:TroopInCastle in this.troopInCastleArray) {
				tc.onDragComplete(drag);
			}
			
			for each (var th1:TroopInHero in this.firstArray) {
				th1.onDragComplete(drag);
			}
			
			if (this.hasSecond) {
				for each (var th2:TroopInHero in this.secondArray) {
					th2.onDragComplete(drag);
				}
			}

			for each(var dargUI:DragUIComponent in this.dragUIAry){
				dargUI.visible = true;
			}
		}
	}
}