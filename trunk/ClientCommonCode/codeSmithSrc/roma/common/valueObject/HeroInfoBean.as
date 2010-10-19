/**
* 生成时间 1 
*/

package roma.common.valueObject
{
	import mx.collections.ArrayCollection;
	import framework.util.CopyAryUtil;
	import roma.common.valueObject.*;
	import flash.utils.ByteArray;

	[Bindable]
	public class HeroInfoBean
	{
		public function HeroInfoBean(data:Object=null)
		{
			if (data!=null){
				if (data.arriveTime!=null) {
					this.arriveTime = data.arriveTime;
				}
				if (data.exp!=null) {
					this.exp = data.exp;
				}
				if (data.growthEndTime!=null) {
					this.growthEndTime = data.growthEndTime;
				}
				if (data.growthLastHours!=null) {
					this.growthLastHours = data.growthLastHours;
				}
				if (data.growthType!=null) {
					this.growthType = data.growthType;
				}
				if (data.id!=null) {
					this.id = data.id;
				}
				if (data.level!=null) {
					this.level = data.level;
				}
				if (data.logoUrl!=null) {
					this.logoUrl = data.logoUrl;
				}
				if (data.loyalties!=null) {
					this.loyalties = data.loyalties;
				}
				if (data.manages!=null) {
					this.manages = data.manages;
				}
				if (data.managesAdd!=null) {
					this.managesAdd = data.managesAdd;
				}
				if (data.mission!=null) {
					this.mission = data.mission;
				}
				if (data.name!=null) {
					this.name = data.name;
				}
				if (data.potentiality!=null) {
					this.potentiality = data.potentiality;
				}
				if (data.powers!=null) {
					this.powers = data.powers;
				}
				if (data.powersAdd!=null) {
					this.powersAdd = data.powersAdd;
				}
				if (data.remains!=null) {
					this.remains = data.remains;
				}
				if (data.sort!=null) {
					this.sort = data.sort;
				}
				if (data.startTime!=null) {
					this.startTime = data.startTime;
				}
				if (data.status!=null) {
					this.status = data.status;
				}
				if (data.stratagems!=null) {
					this.stratagems = data.stratagems;
				}
				if (data.stratagemsAdd!=null) {
					this.stratagemsAdd = data.stratagemsAdd;
				}
				if (data.strengthPoint!=null) {
					this.strengthPoint = data.strengthPoint;
				}
				if (data.targetFieldId!=null) {
					this.targetFieldId = data.targetFieldId;
				}
				if (data.targetFieldName!=null) {
					this.targetFieldName = data.targetFieldName;
				}
				if (data.targetFieldType!=null) {
					this.targetFieldType = data.targetFieldType;
				}
				if (data.battleFieldLeader!=null) {
					this.battleFieldLeader = data.battleFieldLeader;
				}
				if (data.callBackable!=null) {
					this.callBackable = data.callBackable;
				}
				if (data.canAssign!=null) {
					this.canAssign = data.canAssign;
				}
				if (data.canGoOut!=null) {
					this.canGoOut = data.canGoOut;
				}
			}
		}
		

		public var arriveTime:Number;
		public var exp:int;
		public var growthEndTime:Number;
		public var growthLastHours:int;
		public var growthType:int;
		public var id:int;
		public var level:int;
		public var logoUrl:String;
		public var loyalties:int;
		public var manages:int;
		public var managesAdd:int;
		public var mission:int;
		public var name:String;
		public var potentiality:int;
		public var powers:int;
		public var powersAdd:int;
		public var remains:int;
		public var sort:int;
		public var startTime:Number;
		public var status:int;
		public var stratagems:int;
		public var stratagemsAdd:int;
		public var strengthPoint:int;
		public var targetFieldId:int;
		public var targetFieldName:String;
		public var targetFieldType:int;
		public var battleFieldLeader:Boolean;
		public var callBackable:Boolean;
		public var canAssign:Boolean;
		public var canGoOut:Boolean;

		public function copyToBe(target:HeroInfoBean):void {
			target.arriveTime = this.arriveTime 
			target.exp = this.exp 
			target.growthEndTime = this.growthEndTime 
			target.growthLastHours = this.growthLastHours 
			target.growthType = this.growthType 
			target.id = this.id 
			target.level = this.level 
			target.logoUrl = this.logoUrl 
			target.loyalties = this.loyalties 
			target.manages = this.manages 
			target.managesAdd = this.managesAdd 
			target.mission = this.mission 
			target.name = this.name 
			target.potentiality = this.potentiality 
			target.powers = this.powers 
			target.powersAdd = this.powersAdd 
			target.remains = this.remains 
			target.sort = this.sort 
			target.startTime = this.startTime 
			target.status = this.status 
			target.stratagems = this.stratagems 
			target.stratagemsAdd = this.stratagemsAdd 
			target.strengthPoint = this.strengthPoint 
			target.targetFieldId = this.targetFieldId 
			target.targetFieldName = this.targetFieldName 
			target.targetFieldType = this.targetFieldType 
			target.battleFieldLeader = this.battleFieldLeader 
			target.callBackable = this.callBackable 
			target.canAssign = this.canAssign 
			target.canGoOut = this.canGoOut 
		}
		
		public function toBeObject():Object {
			var obj:Object = new Object();
			obj.arriveTime = this.arriveTime;
			obj.exp = this.exp;
			obj.growthEndTime = this.growthEndTime;
			obj.growthLastHours = this.growthLastHours;
			obj.growthType = this.growthType;
			obj.id = this.id;
			obj.level = this.level;
			obj.logoUrl = this.logoUrl;
			obj.loyalties = this.loyalties;
			obj.manages = this.manages;
			obj.managesAdd = this.managesAdd;
			obj.mission = this.mission;
			obj.name = this.name;
			obj.potentiality = this.potentiality;
			obj.powers = this.powers;
			obj.powersAdd = this.powersAdd;
			obj.remains = this.remains;
			obj.sort = this.sort;
			obj.startTime = this.startTime;
			obj.status = this.status;
			obj.stratagems = this.stratagems;
			obj.stratagemsAdd = this.stratagemsAdd;
			obj.strengthPoint = this.strengthPoint;
			obj.targetFieldId = this.targetFieldId;
			obj.targetFieldName = this.targetFieldName;
			obj.targetFieldType = this.targetFieldType;
			obj.battleFieldLeader = this.battleFieldLeader;
			obj.callBackable = this.callBackable;
			obj.canAssign = this.canAssign;
			obj.canGoOut = this.canGoOut;
			return obj;
		}

		public function toBeString(pre:String=""):String {
			var str:String = "";
			str += pre + "arriveTime = " + this.arriveTime + "\n" ;
			str += pre + "exp = " + this.exp + "\n" ;
			str += pre + "growthEndTime = " + this.growthEndTime + "\n" ;
			str += pre + "growthLastHours = " + this.growthLastHours + "\n" ;
			str += pre + "growthType = " + this.growthType + "\n" ;
			str += pre + "id = " + this.id + "\n" ;
			str += pre + "level = " + this.level + "\n" ;
			str += pre + "logoUrl = " + this.logoUrl + "\n" ;
			str += pre + "loyalties = " + this.loyalties + "\n" ;
			str += pre + "manages = " + this.manages + "\n" ;
			str += pre + "managesAdd = " + this.managesAdd + "\n" ;
			str += pre + "mission = " + this.mission + "\n" ;
			str += pre + "name = " + this.name + "\n" ;
			str += pre + "potentiality = " + this.potentiality + "\n" ;
			str += pre + "powers = " + this.powers + "\n" ;
			str += pre + "powersAdd = " + this.powersAdd + "\n" ;
			str += pre + "remains = " + this.remains + "\n" ;
			str += pre + "sort = " + this.sort + "\n" ;
			str += pre + "startTime = " + this.startTime + "\n" ;
			str += pre + "status = " + this.status + "\n" ;
			str += pre + "stratagems = " + this.stratagems + "\n" ;
			str += pre + "stratagemsAdd = " + this.stratagemsAdd + "\n" ;
			str += pre + "strengthPoint = " + this.strengthPoint + "\n" ;
			str += pre + "targetFieldId = " + this.targetFieldId + "\n" ;
			str += pre + "targetFieldName = " + this.targetFieldName + "\n" ;
			str += pre + "targetFieldType = " + this.targetFieldType + "\n" ;
			str += pre + "battleFieldLeader = " + this.battleFieldLeader + "\n" ;
			str += pre + "callBackable = " + this.callBackable + "\n" ;
			str += pre + "canAssign = " + this.canAssign + "\n" ;
			str += pre + "canGoOut = " + this.canGoOut + "\n" ;

			return str;  
		}
	}
}