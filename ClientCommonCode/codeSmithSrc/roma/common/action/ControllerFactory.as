/**
* 生成时间 1 
*/
package roma.common.action
{
	import framework.socket.CaesaryClient;

	public class ControllerFactory
	{
		private static var _instance:ControllerFactory = new ControllerFactory();

		public var client:CaesaryClient;

		private var allianceController:AllianceController = new AllianceController();
		private var allianceManagementController:AllianceManagementController = new AllianceManagementController();
		private var outOfAllianceController:OutOfAllianceController = new OutOfAllianceController();
		private var armyController:ArmyController = new ArmyController();
		private var buildingController:BuildingController = new BuildingController();
		private var cityController:CityController = new CityController();
		private var chatAdminController:ChatAdminController = new ChatAdminController();
		private var chatController:ChatController = new ChatController();
		private var commonController:CommonController = new CommonController();
		private var debugController:DebugController = new DebugController();
		private var equipController:EquipController = new EquipController();
		private var fortificationsController:FortificationsController = new FortificationsController();
		private var friendsController:FriendsController = new FriendsController();
		private var heroController:HeroController = new HeroController();
		private var letterController:LetterController = new LetterController();
		private var playerController:PlayerController = new PlayerController();
		private var taskController:TaskController = new TaskController();
		private var rankController:RankController = new RankController();
		private var reportController:ReportController = new ReportController();
		private var shopController:ShopController = new ShopController();
		private var techController:TechController = new TechController();
		private var campController:CampController = new CampController();
		private var tradeController:TradeController = new TradeController();
		private var troopController:TroopController = new TroopController();
		private var userController:UserController = new UserController();
		private var workerController:WorkerController = new WorkerController();
		

		public function getTotalEvents():int {
			return 244;
		}

		public static function getInstance():ControllerFactory {
			return _instance;
		}

		public function getAllianceController():AllianceController{
			return this.allianceController;
		}
		public function getAllianceManagementController():AllianceManagementController{
			return this.allianceManagementController;
		}
		public function getOutOfAllianceController():OutOfAllianceController{
			return this.outOfAllianceController;
		}
		public function getArmyController():ArmyController{
			return this.armyController;
		}
		public function getBuildingController():BuildingController{
			return this.buildingController;
		}
		public function getCityController():CityController{
			return this.cityController;
		}
		public function getChatAdminController():ChatAdminController{
			return this.chatAdminController;
		}
		public function getChatController():ChatController{
			return this.chatController;
		}
		public function getCommonController():CommonController{
			return this.commonController;
		}
		public function getDebugController():DebugController{
			return this.debugController;
		}
		public function getEquipController():EquipController{
			return this.equipController;
		}
		public function getFortificationsController():FortificationsController{
			return this.fortificationsController;
		}
		public function getFriendsController():FriendsController{
			return this.friendsController;
		}
		public function getHeroController():HeroController{
			return this.heroController;
		}
		public function getLetterController():LetterController{
			return this.letterController;
		}
		public function getPlayerController():PlayerController{
			return this.playerController;
		}
		public function getTaskController():TaskController{
			return this.taskController;
		}
		public function getRankController():RankController{
			return this.rankController;
		}
		public function getReportController():ReportController{
			return this.reportController;
		}
		public function getShopController():ShopController{
			return this.shopController;
		}
		public function getTechController():TechController{
			return this.techController;
		}
		public function getCampController():CampController{
			return this.campController;
		}
		public function getTradeController():TradeController{
			return this.tradeController;
		}
		public function getTroopController():TroopController{
			return this.troopController;
		}
		public function getUserController():UserController{
			return this.userController;
		}
		public function getWorkerController():WorkerController{
			return this.workerController;
		}
	}
}