/**
* 生成时间 1 
*/
package roma.common
{
	import flash.events.EventDispatcher;
	
	import framework.game.BaseResponse;
	import framework.game.MouseCursorManager;
	import framework.game.CommandEvent;

	import mx.logging.ILogger;
	import mx.logging.Log;

	import roma.common.controller.CommonResponse; 
	import roma.common.controller.alliance.AllianceApplyListResponse; 
	import roma.common.controller.alliance.AllianceInfoDataResponse; 
	import roma.common.controller.alliance.AllianceInfoOfOutResponse; 
	import roma.common.controller.alliance.AllianceInviteListResponse; 
	import roma.common.controller.alliance.AllianceMemberListResponse; 
	import roma.common.controller.alliance.AllianceMessageListResponse; 
	import roma.common.controller.alliance.AllianceRelactionResponse; 
	import roma.common.controller.alliance.MilitaryListResponse; 
	import roma.common.controller.alliance.SelfAllianceInfoResponse; 
	import roma.common.controller.army.ArmyExecResponse; 
	import roma.common.controller.army.BattleArmyCountResponse; 
	import roma.common.controller.army.BattleArmysInfoResponse; 
	import roma.common.controller.army.BattleInfoResponse; 
	import roma.common.controller.army.CreateWarFieldResponse; 
	import roma.common.controller.army.FreshBattleFieldResponse; 
	import roma.common.controller.army.ScoutNpcFieldResponse; 
	import roma.common.controller.castle.ConquestResourceResponse; 
	import roma.common.controller.castle.ResourceStaticResponse; 
	import roma.common.controller.chat.PlayerResponse; 
	import roma.common.controller.common.AllianceInfoResponse; 
	import roma.common.controller.common.MapDataResponse; 
	import roma.common.controller.common.MapFieldInfoResponse; 
	import roma.common.controller.common.MapInfo2Response; 
	import roma.common.controller.common.RollTextResponse; 
	import roma.common.controller.common.ZoneInfoDataResponse; 
	import roma.common.controller.debug.EchoResponse; 
	import roma.common.controller.equip.HeroEquipsResponse; 
	import roma.common.controller.equip.PlayerEquipResponse; 
	import roma.common.controller.friends.RelationPlayerInfoResponse; 
	import roma.common.controller.hero.TavernHeroList; 
	import roma.common.controller.mail.LetterListResponse; 
	import roma.common.controller.mail.LetterResponse; 
	import roma.common.controller.player.PlayerCastleResponse; 
	import roma.common.controller.quest.FinishedQuestCountResponse; 
	import roma.common.controller.quest.QuestCategoryResponse; 
	import roma.common.controller.quest.TaskListResponse; 
	import roma.common.controller.quest.TaskResponse; 
	import roma.common.controller.rank.RankCityResponse; 
	import roma.common.controller.rank.RankHeroManResponse; 
	import roma.common.controller.rank.RankLeagueResponse; 
	import roma.common.controller.rank.RankPlayerDataResponse; 
	import roma.common.controller.report.MessageListResponse; 
	import roma.common.controller.report.MessageResponse; 
	import roma.common.controller.shop.PurchaseResourceInfoResponse; 
	import roma.common.controller.shop.UseMaterialResultResponse; 
	import roma.common.controller.shop.UseRoletteResponse; 
	import roma.common.controller.trade.BusenissListResponse; 
	import roma.common.controller.trade.SearchTradeResponse; 
	import roma.common.controller.trade.TransingMaterialListResponse; 
	import roma.common.controller.troop.ManufactureQueueResponse; 
	import roma.common.controller.troop.MayFinishAllResponse; 
	import roma.common.controller.user.EnterResponse; 
	import roma.common.controller.user.GmLoginResponse; 
	import roma.common.events.AllianceRelationEvent; 
	import roma.common.events.ApplyBeConquestedCastleUpdate; 
	import roma.common.events.ApplyHostCastleUdpate; 
	import roma.common.events.BuildingUpdate; 
	import roma.common.events.BusinessUpdate; 
	import roma.common.events.CastleBuffUpdate; 
	import roma.common.events.CastleInfoUpdate; 
	import roma.common.events.CastleMilitaryUpdate; 
	import roma.common.events.CastlePopulationUpdate; 
	import roma.common.events.ChatMsg; 
	import roma.common.events.CityFieldUpdate; 
	import roma.common.events.CityUpdate; 
	import roma.common.events.ConnectLostEvent; 
	import roma.common.events.ConquestCastleUpdate; 
	import roma.common.events.CuredTroopUpdate; 
	import roma.common.events.DebugEvent; 
	import roma.common.events.FieldCollectUpdate; 
	import roma.common.events.FortiUpdate; 
	import roma.common.events.FreeSentenceTimeUpdate; 
	import roma.common.events.FriendRelationUpdate; 
	import roma.common.events.HeroArmyUpdate; 
	import roma.common.events.HeroBuffUpdate; 
	import roma.common.events.HeroInfoUpdate; 
	import roma.common.events.HeroManUpdate; 
	import roma.common.events.HeroTroopUpdate; 
	import roma.common.events.HostCastleUdpate; 
	import roma.common.events.ManufactureQueueUpdate; 
	import roma.common.events.MaterialUpdate; 
	import roma.common.events.NewAnnounce; 
	import roma.common.events.NewBattleMailUpdate; 
	import roma.common.events.NewMailUpdate; 
	import roma.common.events.NewMessageEvent; 
	import roma.common.events.NewQuestFinishedUpdate; 
	import roma.common.events.NewRelatedBattleField; 
	import roma.common.events.OtherArmyLeave; 
	import roma.common.events.OtherArmyStatusUpdate; 
	import roma.common.events.OtherArmyUpdate; 
	import roma.common.events.PlayerBufferUpdate; 
	import roma.common.events.PlayerInfoDataUpdate; 
	import roma.common.events.PostTransportUpdate; 
	import roma.common.events.ResourceMaterialUpdate; 
	import roma.common.events.ScoutPlayerUpdate; 
	import roma.common.events.ScoutUpdate; 
	import roma.common.events.ServerInfoEvent; 
	import roma.common.events.ServerItemEvent; 
	import roma.common.events.TechUpdate; 
	import roma.common.events.TransingBusinessUpdate; 
	import roma.common.events.TransportUpdate; 
	import roma.common.events.TroopManUpdate; 
	import roma.common.events.WorkerTrainningUpdate; 

	import flash.events.EventDispatcher;
	import mx.managers.CursorManager

	public class ResponseEvtDispatcher extends EventDispatcher
	{

		private static var log:ILogger = Log.getLogger("roma.common.ResponseEvtDispatcher");
		
		//consts
		public static const SERVER_ALLIANCE_RELATION_EVENT:String = "server.AllianceRelationEvent";
		public static const SERVER_APPLY_BE_CONQUESTED_CASTLE_UPDATE:String = "server.ApplyBeConquestedCastleUpdate";
		public static const SERVER_APPLY_HOST_CASTLE_UDPATE:String = "server.ApplyHostCastleUdpate";
		public static const SERVER_BUILDING_UPDATE:String = "server.BuildingUpdate";
		public static const SERVER_BUSINESS_UPDATE:String = "server.BusinessUpdate";
		public static const SERVER_CASTLE_BUFF_UPDATE:String = "server.CastleBuffUpdate";
		public static const SERVER_CASTLE_INFO_UPDATE:String = "server.CastleInfoUpdate";
		public static const SERVER_CASTLE_MILITARY_UPDATE:String = "server.CastleMilitaryUpdate";
		public static const SERVER_CASTLE_POPULATION_UPDATE:String = "server.CastlePopulationUpdate";
		public static const SERVER_CHAT_MSG:String = "server.ChatMsg";
		public static const SERVER_CITY_FIELD_UPDATE:String = "server.CityFieldUpdate";
		public static const SERVER_CITY_UPDATE:String = "server.CityUpdate";
		public static const SERVER_CONNECT_LOST_EVENT:String = "server.ConnectLostEvent";
		public static const SERVER_CONQUEST_CASTLE_UPDATE:String = "server.ConquestCastleUpdate";
		public static const SERVER_CURED_TROOP_UPDATE:String = "server.CuredTroopUpdate";
		public static const SERVER_DEBUG_EVENT:String = "server.DebugEvent";
		public static const SERVER_FIELD_COLLECT_UPDATE:String = "server.FieldCollectUpdate";
		public static const SERVER_FORTI_UPDATE:String = "server.FortiUpdate";
		public static const SERVER_FREE_SENTENCE_TIME_UPDATE:String = "server.FreeSentenceTimeUpdate";
		public static const SERVER_FRIEND_RELATION_UPDATE:String = "server.FriendRelationUpdate";
		public static const SERVER_HERO_ARMY_UPDATE:String = "server.HeroArmyUpdate";
		public static const SERVER_HERO_BUFF_UPDATE:String = "server.HeroBuffUpdate";
		public static const SERVER_HERO_INFO_UPDATE:String = "server.HeroInfoUpdate";
		public static const SERVER_HERO_MAN_UPDATE:String = "server.HeroManUpdate";
		public static const SERVER_HERO_TROOP_UPDATE:String = "server.HeroTroopUpdate";
		public static const SERVER_HOST_CASTLE_UDPATE:String = "server.HostCastleUdpate";
		public static const SERVER_MANUFACTURE_QUEUE_UPDATE:String = "server.ManufactureQueueUpdate";
		public static const SERVER_MATERIAL_UPDATE:String = "server.MaterialUpdate";
		public static const SERVER_NEW_ANNOUNCE:String = "server.NewAnnounce";
		public static const SERVER_NEW_BATTLE_MAIL_UPDATE:String = "server.NewBattleMailUpdate";
		public static const SERVER_NEW_MAIL_UPDATE:String = "server.NewMailUpdate";
		public static const SERVER_NEW_MESSAGE_EVENT:String = "server.NewMessageEvent";
		public static const SERVER_NEW_QUEST_FINISHED_UPDATE:String = "server.NewQuestFinishedUpdate";
		public static const SERVER_NEW_RELATED_BATTLE_FIELD:String = "server.NewRelatedBattleField";
		public static const SERVER_OTHER_ARMY_LEAVE:String = "server.OtherArmyLeave";
		public static const SERVER_OTHER_ARMY_STATUS_UPDATE:String = "server.OtherArmyStatusUpdate";
		public static const SERVER_OTHER_ARMY_UPDATE:String = "server.OtherArmyUpdate";
		public static const SERVER_PLAYER_BUFFER_UPDATE:String = "server.PlayerBufferUpdate";
		public static const SERVER_PLAYER_INFO_DATA_UPDATE:String = "server.PlayerInfoDataUpdate";
		public static const SERVER_POST_TRANSPORT_UPDATE:String = "server.PostTransportUpdate";
		public static const SERVER_RESOURCE_MATERIAL_UPDATE:String = "server.ResourceMaterialUpdate";
		public static const SERVER_SCOUT_PLAYER_UPDATE:String = "server.ScoutPlayerUpdate";
		public static const SERVER_SCOUT_UPDATE:String = "server.ScoutUpdate";
		public static const SERVER_SERVER_INFO_EVENT:String = "server.ServerInfoEvent";
		public static const SERVER_SERVER_ITEM_EVENT:String = "server.ServerItemEvent";
		public static const SERVER_TECH_UPDATE:String = "server.TechUpdate";
		public static const SERVER_TRANSING_BUSINESS_UPDATE:String = "server.TransingBusinessUpdate";
		public static const SERVER_TRANSPORT_UPDATE:String = "server.TransportUpdate";
		public static const SERVER_TROOP_MAN_UPDATE:String = "server.TroopManUpdate";
		public static const SERVER_WORKER_TRAINNING_UPDATE:String = "server.WorkerTrainningUpdate";

		private static var _instance:ResponseEvtDispatcher = new ResponseEvtDispatcher();

		public var sending:Boolean=false;

		//服务器端主动发送的事件
		public var onAllianceRelationEvent:Function = null;
		public var onApplyBeConquestedCastleUpdate:Function = null;
		public var onApplyHostCastleUdpate:Function = null;
		public var onBuildingUpdate:Function = null;
		public var onBusinessUpdate:Function = null;
		public var onCastleBuffUpdate:Function = null;
		public var onCastleInfoUpdate:Function = null;
		public var onCastleMilitaryUpdate:Function = null;
		public var onCastlePopulationUpdate:Function = null;
		public var onChatMsg:Function = null;
		public var onCityFieldUpdate:Function = null;
		public var onCityUpdate:Function = null;
		public var onConnectLostEvent:Function = null;
		public var onConquestCastleUpdate:Function = null;
		public var onCuredTroopUpdate:Function = null;
		public var onDebugEvent:Function = null;
		public var onFieldCollectUpdate:Function = null;
		public var onFortiUpdate:Function = null;
		public var onFreeSentenceTimeUpdate:Function = null;
		public var onFriendRelationUpdate:Function = null;
		public var onHeroArmyUpdate:Function = null;
		public var onHeroBuffUpdate:Function = null;
		public var onHeroInfoUpdate:Function = null;
		public var onHeroManUpdate:Function = null;
		public var onHeroTroopUpdate:Function = null;
		public var onHostCastleUdpate:Function = null;
		public var onManufactureQueueUpdate:Function = null;
		public var onMaterialUpdate:Function = null;
		public var onNewAnnounce:Function = null;
		public var onNewBattleMailUpdate:Function = null;
		public var onNewMailUpdate:Function = null;
		public var onNewMessageEvent:Function = null;
		public var onNewQuestFinishedUpdate:Function = null;
		public var onNewRelatedBattleField:Function = null;
		public var onOtherArmyLeave:Function = null;
		public var onOtherArmyStatusUpdate:Function = null;
		public var onOtherArmyUpdate:Function = null;
		public var onPlayerBufferUpdate:Function = null;
		public var onPlayerInfoDataUpdate:Function = null;
		public var onPostTransportUpdate:Function = null;
		public var onResourceMaterialUpdate:Function = null;
		public var onScoutPlayerUpdate:Function = null;
		public var onScoutUpdate:Function = null;
		public var onServerInfoEvent:Function = null;
		public var onServerItemEvent:Function = null;
		public var onTechUpdate:Function = null;
		public var onTransingBusinessUpdate:Function = null;
		public var onTransportUpdate:Function = null;
		public var onTroopManUpdate:Function = null;
		public var onWorkerTrainningUpdate:Function = null;

		//各种方法处理结果的事件
		//AllianceController
		public var _onAllianceControllerAllianceUseItemCallback:Function = null;
		public var _onAllianceControllerChangeAllianceLogoAndNameCallback:Function = null;
		public var _onAllianceControllerContributeItemCallback:Function = null;
		public var _onAllianceControllerContributeResourceCallback:Function = null;
		public var _onAllianceControllerGetAllianceMemberListCallback:Function = null;
		public var _onAllianceControllerGetAllianceRalationCallback:Function = null;
		public var _onAllianceControllerGetLeagueEventListCallback:Function = null;
		public var _onAllianceControllerGetMilitarysCallback:Function = null;
		public var _onAllianceControllerGetSelfAllianceInfoCallback:Function = null;
		public var _onAllianceControllerLevelUp10ByItemCallback:Function = null;
		public var _onAllianceControllerReachLevelCallback:Function = null;

		//AllianceManagementController
		public var _onAllianceManagementControllerAgreeApplyCallback:Function = null;
		public var _onAllianceManagementControllerCancelInviteCallback:Function = null;
		public var _onAllianceManagementControllerDeleteAllianceRelationCallback:Function = null;
		public var _onAllianceManagementControllerGetAppliedPlayerListCallback:Function = null;
		public var _onAllianceManagementControllerGetInvitedPlayerListCallback:Function = null;
		public var _onAllianceManagementControllerInviteToAllianceCallback:Function = null;
		public var _onAllianceManagementControllerKickOutCallback:Function = null;
		public var _onAllianceManagementControllerMessagesForAllCallback:Function = null;
		public var _onAllianceManagementControllerQuitCallback:Function = null;
		public var _onAllianceManagementControllerRefuseApplyCallback:Function = null;
		public var _onAllianceManagementControllerResignCallback:Function = null;
		public var _onAllianceManagementControllerSetAllianceRelationCallback:Function = null;
		public var _onAllianceManagementControllerSetLeagueInfoCallback:Function = null;
		public var _onAllianceManagementControllerSetPowerAllianceCallback:Function = null;

		//OutOfAllianceController
		public var _onOutOfAllianceControllerAcceptInviteCallback:Function = null;
		public var _onOutOfAllianceControllerAllianceInfoOfOutCallback:Function = null;
		public var _onOutOfAllianceControllerApplyCallback:Function = null;
		public var _onOutOfAllianceControllerCacelApplyCallback:Function = null;
		public var _onOutOfAllianceControllerCreateLeagueCallback:Function = null;
		public var _onOutOfAllianceControllerGetLeagueInfoCallback:Function = null;
		public var _onOutOfAllianceControllerRefuseInviteCallback:Function = null;

		//ArmyController
		public var _onArmyControllerCastle2HeroCallback:Function = null;
		public var _onArmyControllerChangeHeroTroopCallback:Function = null;
		public var _onArmyControllerContrTroopForHeroCallback:Function = null;
		public var _onArmyControllerCreateArmyCallback:Function = null;
		public var _onArmyControllerCreateWarFieldCallback:Function = null;
		public var _onArmyControllerCureInjuredsCallback:Function = null;
		public var _onArmyControllerDisbandInjuredsCallback:Function = null;
		public var _onArmyControllerGetBattleArmyCountCallback:Function = null;
		public var _onArmyControllerGetBattleArmysInfoCallback:Function = null;
		public var _onArmyControllerGetFieldBattleInfoCallback:Function = null;
		public var _onArmyControllerGetFreshManBattleFieldCallback:Function = null;
		public var _onArmyControllerGetPlayerBattleInfoCallback:Function = null;
		public var _onArmyControllerHeroTroopChangeNumCallback:Function = null;
		public var _onArmyControllerHeroTroopSwapPositionCallback:Function = null;
		public var _onArmyControllerJoinWarFieldCallback:Function = null;
		public var _onArmyControllerNewScoutCallback:Function = null;
		public var _onArmyControllerReCallArmyCallback:Function = null;
		public var _onArmyControllerScoutNpcFieldCallback:Function = null;
		public var _onArmyControllerSendAllianceBackCallback:Function = null;
		public var _onArmyControllerSetAllowLeagueArmyCallback:Function = null;
		public var _onArmyControllerSetAntiLootCallback:Function = null;
		public var _onArmyControllerTrainArmyCallback:Function = null;
		public var _onArmyControllerUninstallHeroTroopCallback:Function = null;

		//BuildingController
		public var _onBuildingControllerCancleBuildingCallback:Function = null;
		public var _onBuildingControllerConsNewBuildingCallback:Function = null;
		public var _onBuildingControllerDestructDownBuildingCallback:Function = null;
		public var _onBuildingControllerIncreaseConstructLimitCallback:Function = null;
		public var _onBuildingControllerSpeedUpBuildingCallback:Function = null;
		public var _onBuildingControllerUpgradeArchitectureCallback:Function = null;

		//CityController
		public var _onCityControllerAcceptBeConquestedApplyCallback:Function = null;
		public var _onCityControllerAdvTransCastleCallback:Function = null;
		public var _onCityControllerApplyBeConquestedCallback:Function = null;
		public var _onCityControllerConfortPeopleCallback:Function = null;
		public var _onCityControllerConquestResourceCallback:Function = null;
		public var _onCityControllerConstructCityCallback:Function = null;
		public var _onCityControllerExpandCastleCallback:Function = null;
		public var _onCityControllerGiveUpSelfFieldCallback:Function = null;
		public var _onCityControllerGiveupCityCallback:Function = null;
		public var _onCityControllerGiveupConquestedCastleCallback:Function = null;
		public var _onCityControllerIndependentByItemCallback:Function = null;
		public var _onCityControllerIndependentWarCallback:Function = null;
		public var _onCityControllerLevyResourceCallback:Function = null;
		public var _onCityControllerLiberateSelfCastleCallback:Function = null;
		public var _onCityControllerModifyCityNameCallback:Function = null;
		public var _onCityControllerModifyOperRateCallback:Function = null;
		public var _onCityControllerModifyStoreRateCallback:Function = null;
		public var _onCityControllerModifyTaxRateCallback:Function = null;
		public var _onCityControllerMoveCityCallback:Function = null;
		public var _onCityControllerPostTransportCallback:Function = null;
		public var _onCityControllerRefuseBeConquestedApplyCallback:Function = null;
		public var _onCityControllerResourceStaticsCallback:Function = null;
		public var _onCityControllerServerGodCallback:Function = null;

		//ChatAdminController
		public var _onChatAdminControllerCancelNoChatBuffCallback:Function = null;
		public var _onChatAdminControllerGmLoginCallback:Function = null;
		public var _onChatAdminControllerScreenChatCallback:Function = null;
		public var _onChatAdminControllerSearchPlayerByNameCallback:Function = null;
		public var _onChatAdminControllerSendAdminMessageCallback:Function = null;

		//ChatController
		public var _onChatControllerChatCallback:Function = null;
		public var _onChatControllerEnterChannelCallback:Function = null;
		public var _onChatControllerQuitChannelCallback:Function = null;

		//CommonController
		public var _onCommonControllerGetLeagueInfoCallback:Function = null;
		public var _onCommonControllerMapDescCallback:Function = null;
		public var _onCommonControllerMapFieldInfoCallback:Function = null;
		public var _onCommonControllerMapInfo2Callback:Function = null;
		public var _onCommonControllerRollTextCallback:Function = null;
		public var _onCommonControllerZoneInfomationCallback:Function = null;

		//DebugController
		public var _onDebugControllerEchoCallback:Function = null;
		public var _onDebugControllerGoToFutureCallback:Function = null;
		public var _onDebugControllerRefreshResourceCallback:Function = null;

		//EquipController
		public var _onEquipControllerBuyEquipCallback:Function = null;
		public var _onEquipControllerDestroyEquipCallback:Function = null;
		public var _onEquipControllerEquipForHeroCallback:Function = null;
		public var _onEquipControllerGetHeroEquipsCallback:Function = null;
		public var _onEquipControllerGetPlayerEquipsCallback:Function = null;
		public var _onEquipControllerRemoveHeroEquipCallback:Function = null;

		//FortificationsController
		public var _onFortificationsControllerCancelProduceCallback:Function = null;
		public var _onFortificationsControllerDestructFortificationCallback:Function = null;
		public var _onFortificationsControllerProduceFortificationCallback:Function = null;
		public var _onFortificationsControllerSpeedFortificationProduceCallback:Function = null;

		//FriendsController
		public var _onFriendsControllerAddOrUpdatePlayerRelationCallback:Function = null;
		public var _onFriendsControllerDeletePlayerCallback:Function = null;
		public var _onFriendsControllerGetRelationPlayerInfoCallback:Function = null;

		//HeroController
		public var _onHeroControllerAddPointsCallback:Function = null;
		public var _onHeroControllerAwardItemCallback:Function = null;
		public var _onHeroControllerAwardMoneyCallback:Function = null;
		public var _onHeroControllerCancelHeroGrowthCallback:Function = null;
		public var _onHeroControllerDischargeLeaderCallback:Function = null;
		public var _onHeroControllerGetTavernHerosListCallback:Function = null;
		public var _onHeroControllerInnHeroCallback:Function = null;
		public var _onHeroControllerKickHeroCallback:Function = null;
		public var _onHeroControllerPersuadeHeroCallback:Function = null;
		public var _onHeroControllerReNameCallback:Function = null;
		public var _onHeroControllerReachLevelCallback:Function = null;
		public var _onHeroControllerRefreshTavernHerosListCallback:Function = null;
		public var _onHeroControllerResetHeroPointsCallback:Function = null;
		public var _onHeroControllerSendHeroForGrowthCallback:Function = null;
		public var _onHeroControllerSetToChiefCallback:Function = null;
		public var _onHeroControllerSortHeroCallback:Function = null;
		public var _onHeroControllerSpeedUpHeroGrowthCallback:Function = null;
		public var _onHeroControllerTreatSeizedHeroCallback:Function = null;

		//LetterController
		public var _onLetterControllerDeleteMailsCallback:Function = null;
		public var _onLetterControllerMarkAsReadedCallback:Function = null;
		public var _onLetterControllerReadLetterCallback:Function = null;
		public var _onLetterControllerReceiveLetterListCallback:Function = null;
		public var _onLetterControllerSendLetterCallback:Function = null;

		//PlayerController
		public var _onPlayerControllerAddOrUpdateFieldCollectCallback:Function = null;
		public var _onPlayerControllerCancelTruceCallback:Function = null;
		public var _onPlayerControllerChangeFlagCallback:Function = null;
		public var _onPlayerControllerChangeLogoCallback:Function = null;
		public var _onPlayerControllerDeleteFieldCollectCallback:Function = null;
		public var _onPlayerControllerGetPlayerCastlesCallback:Function = null;
		public var _onPlayerControllerModifyPlayerNameCallback:Function = null;
		public var _onPlayerControllerModifyPlayerSignatureCallback:Function = null;
		public var _onPlayerControllerRemoveUiBuffCallback:Function = null;
		public var _onPlayerControllerRestartCallback:Function = null;
		public var _onPlayerControllerSendSpyCallback:Function = null;
		public var _onPlayerControllerTruceCallback:Function = null;

		//TaskController
		public var _onTaskControllerFinishedQuestCountCallback:Function = null;
		public var _onTaskControllerGetAwardCallback:Function = null;
		public var _onTaskControllerGetQuestTypeListCallback:Function = null;
		public var _onTaskControllerGetTaskListCallback:Function = null;

		//RankController
		public var _onRankControllerGetAttackRankCallback:Function = null;
		public var _onRankControllerGetCityRankCallback:Function = null;
		public var _onRankControllerGetDefenceRankCallback:Function = null;
		public var _onRankControllerGetHeroManRankCallback:Function = null;
		public var _onRankControllerGetLeagueRankCallback:Function = null;
		public var _onRankControllerGetPlayerInfoCallback:Function = null;
		public var _onRankControllerGetPlayerRankCallback:Function = null;

		//ReportController
		public var _onReportControllerDeleteReportsCallback:Function = null;
		public var _onReportControllerMarkReadedCallback:Function = null;
		public var _onReportControllerMarkStoreCallback:Function = null;
		public var _onReportControllerReceiveReportsCallback:Function = null;

		//ShopController
		public var _onShopControllerBuyItemCallback:Function = null;
		public var _onShopControllerBuyResourcesCallback:Function = null;
		public var _onShopControllerGetBuyResourceDetailCallback:Function = null;
		public var _onShopControllerUsePlayerItemCallback:Function = null;
		public var _onShopControllerUseRoletteCallback:Function = null;

		//TechController
		public var _onTechControllerCancelTechResearchCallback:Function = null;
		public var _onTechControllerSpeedUpResearchCallback:Function = null;
		public var _onTechControllerStartResearchCallback:Function = null;

		//CampController
		public var _onCampControllerCreateCampCallback:Function = null;
		public var _onCampControllerModifyCampNameCallback:Function = null;
		public var _onCampControllerMoveCampCallback:Function = null;

		//TradeController
		public var _onTradeControllerCancelCityTradeCallback:Function = null;
		public var _onTradeControllerCreateNewTradeCallback:Function = null;
		public var _onTradeControllerFindTradesCallback:Function = null;
		public var _onTradeControllerGetSelfTradesCallback:Function = null;
		public var _onTradeControllerGetTransingTradesCallback:Function = null;
		public var _onTradeControllerSpeedUpTransitCallback:Function = null;
		public var _onTradeControllerSpeedupTransportCallback:Function = null;
		public var _onTradeControllerTransportCallback:Function = null;

		//TroopController
		public var _onTroopControllerCancelProduceCallback:Function = null;
		public var _onTroopControllerDisbandTroopsCallback:Function = null;
		public var _onTroopControllerProduceMoreTroopCallback:Function = null;
		public var _onTroopControllerSpeedTroopProduceCallback:Function = null;

		//UserController
		public var _onUserControllerAutoLoginCallback:Function = null;
		public var _onUserControllerCreatePlayerCallback:Function = null;
		public var _onUserControllerLoginCallback:Function = null;

		//WorkerController
		public var _onWorkerControllerCancelWorkerTrainningCallback:Function = null;
		public var _onWorkerControllerSeveranceWorkerCallback:Function = null;
		public var _onWorkerControllerSpeedUpTrainningCallback:Function = null;
		public var _onWorkerControllerTrainningWorkerCallback:Function = null;

		
		private var controllerArray:Array = new Array();
		
		function ResponseEvtDispatcher(){
			controllerArray[0] = _onAllianceControllerAllianceUseItemHandler;
			controllerArray[1] = _onAllianceControllerChangeAllianceLogoAndNameHandler;
			controllerArray[2] = _onAllianceControllerContributeItemHandler;
			controllerArray[3] = _onAllianceControllerContributeResourceHandler;
			controllerArray[4] = _onAllianceControllerGetAllianceMemberListHandler;
			controllerArray[5] = _onAllianceControllerGetAllianceRalationHandler;
			controllerArray[6] = _onAllianceControllerGetLeagueEventListHandler;
			controllerArray[7] = _onAllianceControllerGetMilitarysHandler;
			controllerArray[8] = _onAllianceControllerGetSelfAllianceInfoHandler;
			controllerArray[9] = _onAllianceControllerLevelUp10ByItemHandler;
			controllerArray[10] = _onAllianceControllerReachLevelHandler;
			controllerArray[11] = _onAllianceManagementControllerAgreeApplyHandler;
			controllerArray[12] = _onAllianceManagementControllerCancelInviteHandler;
			controllerArray[13] = _onAllianceManagementControllerDeleteAllianceRelationHandler;
			controllerArray[14] = _onAllianceManagementControllerGetAppliedPlayerListHandler;
			controllerArray[15] = _onAllianceManagementControllerGetInvitedPlayerListHandler;
			controllerArray[16] = _onAllianceManagementControllerInviteToAllianceHandler;
			controllerArray[17] = _onAllianceManagementControllerKickOutHandler;
			controllerArray[18] = _onAllianceManagementControllerMessagesForAllHandler;
			controllerArray[19] = _onAllianceManagementControllerQuitHandler;
			controllerArray[20] = _onAllianceManagementControllerRefuseApplyHandler;
			controllerArray[21] = _onAllianceManagementControllerResignHandler;
			controllerArray[22] = _onAllianceManagementControllerSetAllianceRelationHandler;
			controllerArray[23] = _onAllianceManagementControllerSetLeagueInfoHandler;
			controllerArray[24] = _onAllianceManagementControllerSetPowerAllianceHandler;
			controllerArray[25] = _onOutOfAllianceControllerAcceptInviteHandler;
			controllerArray[26] = _onOutOfAllianceControllerAllianceInfoOfOutHandler;
			controllerArray[27] = _onOutOfAllianceControllerApplyHandler;
			controllerArray[28] = _onOutOfAllianceControllerCacelApplyHandler;
			controllerArray[29] = _onOutOfAllianceControllerCreateLeagueHandler;
			controllerArray[30] = _onOutOfAllianceControllerGetLeagueInfoHandler;
			controllerArray[31] = _onOutOfAllianceControllerRefuseInviteHandler;
			controllerArray[32] = _onArmyControllerCastle2HeroHandler;
			controllerArray[33] = _onArmyControllerChangeHeroTroopHandler;
			controllerArray[34] = _onArmyControllerContrTroopForHeroHandler;
			controllerArray[35] = _onArmyControllerCreateArmyHandler;
			controllerArray[36] = _onArmyControllerCreateWarFieldHandler;
			controllerArray[37] = _onArmyControllerCureInjuredsHandler;
			controllerArray[38] = _onArmyControllerDisbandInjuredsHandler;
			controllerArray[39] = _onArmyControllerGetBattleArmyCountHandler;
			controllerArray[40] = _onArmyControllerGetBattleArmysInfoHandler;
			controllerArray[41] = _onArmyControllerGetFieldBattleInfoHandler;
			controllerArray[42] = _onArmyControllerGetFreshManBattleFieldHandler;
			controllerArray[43] = _onArmyControllerGetPlayerBattleInfoHandler;
			controllerArray[44] = _onArmyControllerHeroTroopChangeNumHandler;
			controllerArray[45] = _onArmyControllerHeroTroopSwapPositionHandler;
			controllerArray[46] = _onArmyControllerJoinWarFieldHandler;
			controllerArray[47] = _onArmyControllerNewScoutHandler;
			controllerArray[48] = _onArmyControllerReCallArmyHandler;
			controllerArray[49] = _onArmyControllerScoutNpcFieldHandler;
			controllerArray[50] = _onArmyControllerSendAllianceBackHandler;
			controllerArray[51] = _onArmyControllerSetAllowLeagueArmyHandler;
			controllerArray[52] = _onArmyControllerSetAntiLootHandler;
			controllerArray[53] = _onArmyControllerTrainArmyHandler;
			controllerArray[54] = _onArmyControllerUninstallHeroTroopHandler;
			controllerArray[55] = _onBuildingControllerCancleBuildingHandler;
			controllerArray[56] = _onBuildingControllerConsNewBuildingHandler;
			controllerArray[57] = _onBuildingControllerDestructDownBuildingHandler;
			controllerArray[58] = _onBuildingControllerIncreaseConstructLimitHandler;
			controllerArray[59] = _onBuildingControllerSpeedUpBuildingHandler;
			controllerArray[60] = _onBuildingControllerUpgradeArchitectureHandler;
			controllerArray[61] = _onCityControllerAcceptBeConquestedApplyHandler;
			controllerArray[62] = _onCityControllerAdvTransCastleHandler;
			controllerArray[63] = _onCityControllerApplyBeConquestedHandler;
			controllerArray[64] = _onCityControllerConfortPeopleHandler;
			controllerArray[65] = _onCityControllerConquestResourceHandler;
			controllerArray[66] = _onCityControllerConstructCityHandler;
			controllerArray[67] = _onCityControllerExpandCastleHandler;
			controllerArray[68] = _onCityControllerGiveUpSelfFieldHandler;
			controllerArray[69] = _onCityControllerGiveupCityHandler;
			controllerArray[70] = _onCityControllerGiveupConquestedCastleHandler;
			controllerArray[71] = _onCityControllerIndependentByItemHandler;
			controllerArray[72] = _onCityControllerIndependentWarHandler;
			controllerArray[73] = _onCityControllerLevyResourceHandler;
			controllerArray[74] = _onCityControllerLiberateSelfCastleHandler;
			controllerArray[75] = _onCityControllerModifyCityNameHandler;
			controllerArray[76] = _onCityControllerModifyOperRateHandler;
			controllerArray[77] = _onCityControllerModifyStoreRateHandler;
			controllerArray[78] = _onCityControllerModifyTaxRateHandler;
			controllerArray[79] = _onCityControllerMoveCityHandler;
			controllerArray[80] = _onCityControllerPostTransportHandler;
			controllerArray[81] = _onCityControllerRefuseBeConquestedApplyHandler;
			controllerArray[82] = _onCityControllerResourceStaticsHandler;
			controllerArray[83] = _onCityControllerServerGodHandler;
			controllerArray[84] = _onChatAdminControllerCancelNoChatBuffHandler;
			controllerArray[85] = _onChatAdminControllerGmLoginHandler;
			controllerArray[86] = _onChatAdminControllerScreenChatHandler;
			controllerArray[87] = _onChatAdminControllerSearchPlayerByNameHandler;
			controllerArray[88] = _onChatAdminControllerSendAdminMessageHandler;
			controllerArray[89] = _onChatControllerChatHandler;
			controllerArray[90] = _onChatControllerEnterChannelHandler;
			controllerArray[91] = _onChatControllerQuitChannelHandler;
			controllerArray[92] = _onCommonControllerGetLeagueInfoHandler;
			controllerArray[93] = _onCommonControllerMapDescHandler;
			controllerArray[94] = _onCommonControllerMapFieldInfoHandler;
			controllerArray[95] = _onCommonControllerMapInfo2Handler;
			controllerArray[96] = _onCommonControllerRollTextHandler;
			controllerArray[97] = _onCommonControllerZoneInfomationHandler;
			controllerArray[98] = _onDebugControllerEchoHandler;
			controllerArray[99] = _onDebugControllerGoToFutureHandler;
			controllerArray[100] = _onDebugControllerRefreshResourceHandler;
			controllerArray[101] = _onEquipControllerBuyEquipHandler;
			controllerArray[102] = _onEquipControllerDestroyEquipHandler;
			controllerArray[103] = _onEquipControllerEquipForHeroHandler;
			controllerArray[104] = _onEquipControllerGetHeroEquipsHandler;
			controllerArray[105] = _onEquipControllerGetPlayerEquipsHandler;
			controllerArray[106] = _onEquipControllerRemoveHeroEquipHandler;
			controllerArray[107] = _onFortificationsControllerCancelProduceHandler;
			controllerArray[108] = _onFortificationsControllerDestructFortificationHandler;
			controllerArray[109] = _onFortificationsControllerProduceFortificationHandler;
			controllerArray[110] = _onFortificationsControllerSpeedFortificationProduceHandler;
			controllerArray[111] = _onFriendsControllerAddOrUpdatePlayerRelationHandler;
			controllerArray[112] = _onFriendsControllerDeletePlayerHandler;
			controllerArray[113] = _onFriendsControllerGetRelationPlayerInfoHandler;
			controllerArray[114] = _onHeroControllerAddPointsHandler;
			controllerArray[115] = _onHeroControllerAwardItemHandler;
			controllerArray[116] = _onHeroControllerAwardMoneyHandler;
			controllerArray[117] = _onHeroControllerCancelHeroGrowthHandler;
			controllerArray[118] = _onHeroControllerDischargeLeaderHandler;
			controllerArray[119] = _onHeroControllerGetTavernHerosListHandler;
			controllerArray[120] = _onHeroControllerInnHeroHandler;
			controllerArray[121] = _onHeroControllerKickHeroHandler;
			controllerArray[122] = _onHeroControllerPersuadeHeroHandler;
			controllerArray[123] = _onHeroControllerReNameHandler;
			controllerArray[124] = _onHeroControllerReachLevelHandler;
			controllerArray[125] = _onHeroControllerRefreshTavernHerosListHandler;
			controllerArray[126] = _onHeroControllerResetHeroPointsHandler;
			controllerArray[127] = _onHeroControllerSendHeroForGrowthHandler;
			controllerArray[128] = _onHeroControllerSetToChiefHandler;
			controllerArray[129] = _onHeroControllerSortHeroHandler;
			controllerArray[130] = _onHeroControllerSpeedUpHeroGrowthHandler;
			controllerArray[131] = _onHeroControllerTreatSeizedHeroHandler;
			controllerArray[132] = _onLetterControllerDeleteMailsHandler;
			controllerArray[133] = _onLetterControllerMarkAsReadedHandler;
			controllerArray[134] = _onLetterControllerReadLetterHandler;
			controllerArray[135] = _onLetterControllerReceiveLetterListHandler;
			controllerArray[136] = _onLetterControllerSendLetterHandler;
			controllerArray[137] = _onPlayerControllerAddOrUpdateFieldCollectHandler;
			controllerArray[138] = _onPlayerControllerCancelTruceHandler;
			controllerArray[139] = _onPlayerControllerChangeFlagHandler;
			controllerArray[140] = _onPlayerControllerChangeLogoHandler;
			controllerArray[141] = _onPlayerControllerDeleteFieldCollectHandler;
			controllerArray[142] = _onPlayerControllerGetPlayerCastlesHandler;
			controllerArray[143] = _onPlayerControllerModifyPlayerNameHandler;
			controllerArray[144] = _onPlayerControllerModifyPlayerSignatureHandler;
			controllerArray[145] = _onPlayerControllerRemoveUiBuffHandler;
			controllerArray[146] = _onPlayerControllerRestartHandler;
			controllerArray[147] = _onPlayerControllerSendSpyHandler;
			controllerArray[148] = _onPlayerControllerTruceHandler;
			controllerArray[149] = _onTaskControllerFinishedQuestCountHandler;
			controllerArray[150] = _onTaskControllerGetAwardHandler;
			controllerArray[151] = _onTaskControllerGetQuestTypeListHandler;
			controllerArray[152] = _onTaskControllerGetTaskListHandler;
			controllerArray[153] = _onRankControllerGetAttackRankHandler;
			controllerArray[154] = _onRankControllerGetCityRankHandler;
			controllerArray[155] = _onRankControllerGetDefenceRankHandler;
			controllerArray[156] = _onRankControllerGetHeroManRankHandler;
			controllerArray[157] = _onRankControllerGetLeagueRankHandler;
			controllerArray[158] = _onRankControllerGetPlayerInfoHandler;
			controllerArray[159] = _onRankControllerGetPlayerRankHandler;
			controllerArray[160] = _onReportControllerDeleteReportsHandler;
			controllerArray[161] = _onReportControllerMarkReadedHandler;
			controllerArray[162] = _onReportControllerMarkStoreHandler;
			controllerArray[163] = _onReportControllerReceiveReportsHandler;
			controllerArray[164] = _onShopControllerBuyItemHandler;
			controllerArray[165] = _onShopControllerBuyResourcesHandler;
			controllerArray[166] = _onShopControllerGetBuyResourceDetailHandler;
			controllerArray[167] = _onShopControllerUsePlayerItemHandler;
			controllerArray[168] = _onShopControllerUseRoletteHandler;
			controllerArray[169] = _onTechControllerCancelTechResearchHandler;
			controllerArray[170] = _onTechControllerSpeedUpResearchHandler;
			controllerArray[171] = _onTechControllerStartResearchHandler;
			controllerArray[172] = _onCampControllerCreateCampHandler;
			controllerArray[173] = _onCampControllerModifyCampNameHandler;
			controllerArray[174] = _onCampControllerMoveCampHandler;
			controllerArray[175] = _onTradeControllerCancelCityTradeHandler;
			controllerArray[176] = _onTradeControllerCreateNewTradeHandler;
			controllerArray[177] = _onTradeControllerFindTradesHandler;
			controllerArray[178] = _onTradeControllerGetSelfTradesHandler;
			controllerArray[179] = _onTradeControllerGetTransingTradesHandler;
			controllerArray[180] = _onTradeControllerSpeedUpTransitHandler;
			controllerArray[181] = _onTradeControllerSpeedupTransportHandler;
			controllerArray[182] = _onTradeControllerTransportHandler;
			controllerArray[183] = _onTroopControllerCancelProduceHandler;
			controllerArray[184] = _onTroopControllerDisbandTroopsHandler;
			controllerArray[185] = _onTroopControllerProduceMoreTroopHandler;
			controllerArray[186] = _onTroopControllerSpeedTroopProduceHandler;
			controllerArray[187] = _onUserControllerAutoLoginHandler;
			controllerArray[188] = _onUserControllerCreatePlayerHandler;
			controllerArray[189] = _onUserControllerLoginHandler;
			controllerArray[190] = _onWorkerControllerCancelWorkerTrainningHandler;
			controllerArray[191] = _onWorkerControllerSeveranceWorkerHandler;
			controllerArray[192] = _onWorkerControllerSpeedUpTrainningHandler;
			controllerArray[193] = _onWorkerControllerTrainningWorkerHandler;
			controllerArray[194] = _onAllianceRelationEventHandler;
			controllerArray[195] = _onApplyBeConquestedCastleUpdateHandler;
			controllerArray[196] = _onApplyHostCastleUdpateHandler;
			controllerArray[197] = _onBuildingUpdateHandler;
			controllerArray[198] = _onBusinessUpdateHandler;
			controllerArray[199] = _onCastleBuffUpdateHandler;
			controllerArray[200] = _onCastleInfoUpdateHandler;
			controllerArray[201] = _onCastleMilitaryUpdateHandler;
			controllerArray[202] = _onCastlePopulationUpdateHandler;
			controllerArray[203] = _onChatMsgHandler;
			controllerArray[204] = _onCityFieldUpdateHandler;
			controllerArray[205] = _onCityUpdateHandler;
			controllerArray[206] = _onConnectLostEventHandler;
			controllerArray[207] = _onConquestCastleUpdateHandler;
			controllerArray[208] = _onCuredTroopUpdateHandler;
			controllerArray[209] = _onDebugEventHandler;
			controllerArray[210] = _onFieldCollectUpdateHandler;
			controllerArray[211] = _onFortiUpdateHandler;
			controllerArray[212] = _onFreeSentenceTimeUpdateHandler;
			controllerArray[213] = _onFriendRelationUpdateHandler;
			controllerArray[214] = _onHeroArmyUpdateHandler;
			controllerArray[215] = _onHeroBuffUpdateHandler;
			controllerArray[216] = _onHeroInfoUpdateHandler;
			controllerArray[217] = _onHeroManUpdateHandler;
			controllerArray[218] = _onHeroTroopUpdateHandler;
			controllerArray[219] = _onHostCastleUdpateHandler;
			controllerArray[220] = _onManufactureQueueUpdateHandler;
			controllerArray[221] = _onMaterialUpdateHandler;
			controllerArray[222] = _onNewAnnounceHandler;
			controllerArray[223] = _onNewBattleMailUpdateHandler;
			controllerArray[224] = _onNewMailUpdateHandler;
			controllerArray[225] = _onNewMessageEventHandler;
			controllerArray[226] = _onNewQuestFinishedUpdateHandler;
			controllerArray[227] = _onNewRelatedBattleFieldHandler;
			controllerArray[228] = _onOtherArmyLeaveHandler;
			controllerArray[229] = _onOtherArmyStatusUpdateHandler;
			controllerArray[230] = _onOtherArmyUpdateHandler;
			controllerArray[231] = _onPlayerBufferUpdateHandler;
			controllerArray[232] = _onPlayerInfoDataUpdateHandler;
			controllerArray[233] = _onPostTransportUpdateHandler;
			controllerArray[234] = _onResourceMaterialUpdateHandler;
			controllerArray[235] = _onScoutPlayerUpdateHandler;
			controllerArray[236] = _onScoutUpdateHandler;
			controllerArray[237] = _onServerInfoEventHandler;
			controllerArray[238] = _onServerItemEventHandler;
			controllerArray[239] = _onTechUpdateHandler;
			controllerArray[240] = _onTransingBusinessUpdateHandler;
			controllerArray[241] = _onTransportUpdateHandler;
			controllerArray[242] = _onTroopManUpdateHandler;
			controllerArray[243] = _onWorkerTrainningUpdateHandler;
		}
		private function _onAllianceControllerAllianceUseItemHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("alliance.allianceUseItem", data);
			log.debug(event.toBeString());
			if (this._onAllianceControllerAllianceUseItemCallback != null) {
				this._onAllianceControllerAllianceUseItemCallback.apply(this, [event]);
				this._onAllianceControllerAllianceUseItemCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onAllianceControllerChangeAllianceLogoAndNameHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("alliance.changeAllianceLogoAndName", data);
			log.debug(event.toBeString());
			if (this._onAllianceControllerChangeAllianceLogoAndNameCallback != null) {
				this._onAllianceControllerChangeAllianceLogoAndNameCallback.apply(this, [event]);
				this._onAllianceControllerChangeAllianceLogoAndNameCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onAllianceControllerContributeItemHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("alliance.contributeItem", data);
			log.debug(event.toBeString());
			if (this._onAllianceControllerContributeItemCallback != null) {
				this._onAllianceControllerContributeItemCallback.apply(this, [event]);
				this._onAllianceControllerContributeItemCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onAllianceControllerContributeResourceHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("alliance.contributeResource", data);
			log.debug(event.toBeString());
			if (this._onAllianceControllerContributeResourceCallback != null) {
				this._onAllianceControllerContributeResourceCallback.apply(this, [event]);
				this._onAllianceControllerContributeResourceCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onAllianceControllerGetAllianceMemberListHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.alliance.AllianceMemberListResponse("alliance.getAllianceMemberList", data);
			log.debug(event.toBeString());
			if (this._onAllianceControllerGetAllianceMemberListCallback != null) {
				this._onAllianceControllerGetAllianceMemberListCallback.apply(this, [event]);
				this._onAllianceControllerGetAllianceMemberListCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onAllianceControllerGetAllianceRalationHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.alliance.AllianceRelactionResponse("alliance.getAllianceRalation", data);
			log.debug(event.toBeString());
			if (this._onAllianceControllerGetAllianceRalationCallback != null) {
				this._onAllianceControllerGetAllianceRalationCallback.apply(this, [event]);
				this._onAllianceControllerGetAllianceRalationCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onAllianceControllerGetLeagueEventListHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.alliance.AllianceMessageListResponse("alliance.getLeagueEventList", data);
			log.debug(event.toBeString());
			if (this._onAllianceControllerGetLeagueEventListCallback != null) {
				this._onAllianceControllerGetLeagueEventListCallback.apply(this, [event]);
				this._onAllianceControllerGetLeagueEventListCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onAllianceControllerGetMilitarysHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.alliance.MilitaryListResponse("alliance.getMilitarys", data);
			log.debug(event.toBeString());
			if (this._onAllianceControllerGetMilitarysCallback != null) {
				this._onAllianceControllerGetMilitarysCallback.apply(this, [event]);
				this._onAllianceControllerGetMilitarysCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onAllianceControllerGetSelfAllianceInfoHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.alliance.SelfAllianceInfoResponse("alliance.getSelfAllianceInfo", data);
			log.debug(event.toBeString());
			if (this._onAllianceControllerGetSelfAllianceInfoCallback != null) {
				this._onAllianceControllerGetSelfAllianceInfoCallback.apply(this, [event]);
				this._onAllianceControllerGetSelfAllianceInfoCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onAllianceControllerLevelUp10ByItemHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("alliance.levelUp10ByItem", data);
			log.debug(event.toBeString());
			if (this._onAllianceControllerLevelUp10ByItemCallback != null) {
				this._onAllianceControllerLevelUp10ByItemCallback.apply(this, [event]);
				this._onAllianceControllerLevelUp10ByItemCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onAllianceControllerReachLevelHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("alliance.reachLevel", data);
			log.debug(event.toBeString());
			if (this._onAllianceControllerReachLevelCallback != null) {
				this._onAllianceControllerReachLevelCallback.apply(this, [event]);
				this._onAllianceControllerReachLevelCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onAllianceManagementControllerAgreeApplyHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("alliance.agreeApply", data);
			log.debug(event.toBeString());
			if (this._onAllianceManagementControllerAgreeApplyCallback != null) {
				this._onAllianceManagementControllerAgreeApplyCallback.apply(this, [event]);
				this._onAllianceManagementControllerAgreeApplyCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onAllianceManagementControllerCancelInviteHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("alliance.cancelInvite", data);
			log.debug(event.toBeString());
			if (this._onAllianceManagementControllerCancelInviteCallback != null) {
				this._onAllianceManagementControllerCancelInviteCallback.apply(this, [event]);
				this._onAllianceManagementControllerCancelInviteCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onAllianceManagementControllerDeleteAllianceRelationHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("alliance.deleteAllianceRelation", data);
			log.debug(event.toBeString());
			if (this._onAllianceManagementControllerDeleteAllianceRelationCallback != null) {
				this._onAllianceManagementControllerDeleteAllianceRelationCallback.apply(this, [event]);
				this._onAllianceManagementControllerDeleteAllianceRelationCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onAllianceManagementControllerGetAppliedPlayerListHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.alliance.AllianceApplyListResponse("alliance.getAppliedPlayerList", data);
			log.debug(event.toBeString());
			if (this._onAllianceManagementControllerGetAppliedPlayerListCallback != null) {
				this._onAllianceManagementControllerGetAppliedPlayerListCallback.apply(this, [event]);
				this._onAllianceManagementControllerGetAppliedPlayerListCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onAllianceManagementControllerGetInvitedPlayerListHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.alliance.AllianceInviteListResponse("alliance.getInvitedPlayerList", data);
			log.debug(event.toBeString());
			if (this._onAllianceManagementControllerGetInvitedPlayerListCallback != null) {
				this._onAllianceManagementControllerGetInvitedPlayerListCallback.apply(this, [event]);
				this._onAllianceManagementControllerGetInvitedPlayerListCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onAllianceManagementControllerInviteToAllianceHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("alliance.inviteToAlliance", data);
			log.debug(event.toBeString());
			if (this._onAllianceManagementControllerInviteToAllianceCallback != null) {
				this._onAllianceManagementControllerInviteToAllianceCallback.apply(this, [event]);
				this._onAllianceManagementControllerInviteToAllianceCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onAllianceManagementControllerKickOutHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("alliance.kickOut", data);
			log.debug(event.toBeString());
			if (this._onAllianceManagementControllerKickOutCallback != null) {
				this._onAllianceManagementControllerKickOutCallback.apply(this, [event]);
				this._onAllianceManagementControllerKickOutCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onAllianceManagementControllerMessagesForAllHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("alliance.messagesForAll", data);
			log.debug(event.toBeString());
			if (this._onAllianceManagementControllerMessagesForAllCallback != null) {
				this._onAllianceManagementControllerMessagesForAllCallback.apply(this, [event]);
				this._onAllianceManagementControllerMessagesForAllCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onAllianceManagementControllerQuitHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("alliance.quit", data);
			log.debug(event.toBeString());
			if (this._onAllianceManagementControllerQuitCallback != null) {
				this._onAllianceManagementControllerQuitCallback.apply(this, [event]);
				this._onAllianceManagementControllerQuitCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onAllianceManagementControllerRefuseApplyHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("alliance.refuseApply", data);
			log.debug(event.toBeString());
			if (this._onAllianceManagementControllerRefuseApplyCallback != null) {
				this._onAllianceManagementControllerRefuseApplyCallback.apply(this, [event]);
				this._onAllianceManagementControllerRefuseApplyCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onAllianceManagementControllerResignHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("alliance.resign", data);
			log.debug(event.toBeString());
			if (this._onAllianceManagementControllerResignCallback != null) {
				this._onAllianceManagementControllerResignCallback.apply(this, [event]);
				this._onAllianceManagementControllerResignCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onAllianceManagementControllerSetAllianceRelationHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("alliance.setAllianceRelation", data);
			log.debug(event.toBeString());
			if (this._onAllianceManagementControllerSetAllianceRelationCallback != null) {
				this._onAllianceManagementControllerSetAllianceRelationCallback.apply(this, [event]);
				this._onAllianceManagementControllerSetAllianceRelationCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onAllianceManagementControllerSetLeagueInfoHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("alliance.setLeagueInfo", data);
			log.debug(event.toBeString());
			if (this._onAllianceManagementControllerSetLeagueInfoCallback != null) {
				this._onAllianceManagementControllerSetLeagueInfoCallback.apply(this, [event]);
				this._onAllianceManagementControllerSetLeagueInfoCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onAllianceManagementControllerSetPowerAllianceHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("alliance.setPowerAlliance", data);
			log.debug(event.toBeString());
			if (this._onAllianceManagementControllerSetPowerAllianceCallback != null) {
				this._onAllianceManagementControllerSetPowerAllianceCallback.apply(this, [event]);
				this._onAllianceManagementControllerSetPowerAllianceCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onOutOfAllianceControllerAcceptInviteHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("alliance.acceptInvite", data);
			log.debug(event.toBeString());
			if (this._onOutOfAllianceControllerAcceptInviteCallback != null) {
				this._onOutOfAllianceControllerAcceptInviteCallback.apply(this, [event]);
				this._onOutOfAllianceControllerAcceptInviteCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onOutOfAllianceControllerAllianceInfoOfOutHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.alliance.AllianceInfoOfOutResponse("alliance.allianceInfoOfOut", data);
			log.debug(event.toBeString());
			if (this._onOutOfAllianceControllerAllianceInfoOfOutCallback != null) {
				this._onOutOfAllianceControllerAllianceInfoOfOutCallback.apply(this, [event]);
				this._onOutOfAllianceControllerAllianceInfoOfOutCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onOutOfAllianceControllerApplyHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("alliance.apply", data);
			log.debug(event.toBeString());
			if (this._onOutOfAllianceControllerApplyCallback != null) {
				this._onOutOfAllianceControllerApplyCallback.apply(this, [event]);
				this._onOutOfAllianceControllerApplyCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onOutOfAllianceControllerCacelApplyHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("alliance.cacelApply", data);
			log.debug(event.toBeString());
			if (this._onOutOfAllianceControllerCacelApplyCallback != null) {
				this._onOutOfAllianceControllerCacelApplyCallback.apply(this, [event]);
				this._onOutOfAllianceControllerCacelApplyCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onOutOfAllianceControllerCreateLeagueHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.alliance.SelfAllianceInfoResponse("alliance.createLeague", data);
			log.debug(event.toBeString());
			if (this._onOutOfAllianceControllerCreateLeagueCallback != null) {
				this._onOutOfAllianceControllerCreateLeagueCallback.apply(this, [event]);
				this._onOutOfAllianceControllerCreateLeagueCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onOutOfAllianceControllerGetLeagueInfoHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.alliance.AllianceInfoDataResponse("alliance.getLeagueInfo", data);
			log.debug(event.toBeString());
			if (this._onOutOfAllianceControllerGetLeagueInfoCallback != null) {
				this._onOutOfAllianceControllerGetLeagueInfoCallback.apply(this, [event]);
				this._onOutOfAllianceControllerGetLeagueInfoCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onOutOfAllianceControllerRefuseInviteHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("alliance.refuseInvite", data);
			log.debug(event.toBeString());
			if (this._onOutOfAllianceControllerRefuseInviteCallback != null) {
				this._onOutOfAllianceControllerRefuseInviteCallback.apply(this, [event]);
				this._onOutOfAllianceControllerRefuseInviteCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onArmyControllerCastle2HeroHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("army.castle2Hero", data);
			log.debug(event.toBeString());
			if (this._onArmyControllerCastle2HeroCallback != null) {
				this._onArmyControllerCastle2HeroCallback.apply(this, [event]);
				this._onArmyControllerCastle2HeroCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onArmyControllerChangeHeroTroopHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("army.changeHeroTroop", data);
			log.debug(event.toBeString());
			if (this._onArmyControllerChangeHeroTroopCallback != null) {
				this._onArmyControllerChangeHeroTroopCallback.apply(this, [event]);
				this._onArmyControllerChangeHeroTroopCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onArmyControllerContrTroopForHeroHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("army.contrTroopForHero", data);
			log.debug(event.toBeString());
			if (this._onArmyControllerContrTroopForHeroCallback != null) {
				this._onArmyControllerContrTroopForHeroCallback.apply(this, [event]);
				this._onArmyControllerContrTroopForHeroCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onArmyControllerCreateArmyHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("army.createArmy", data);
			log.debug(event.toBeString());
			if (this._onArmyControllerCreateArmyCallback != null) {
				this._onArmyControllerCreateArmyCallback.apply(this, [event]);
				this._onArmyControllerCreateArmyCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onArmyControllerCreateWarFieldHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.army.CreateWarFieldResponse("army.createWarField", data);
			log.debug(event.toBeString());
			if (this._onArmyControllerCreateWarFieldCallback != null) {
				this._onArmyControllerCreateWarFieldCallback.apply(this, [event]);
				this._onArmyControllerCreateWarFieldCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onArmyControllerCureInjuredsHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("army.cureInjureds", data);
			log.debug(event.toBeString());
			if (this._onArmyControllerCureInjuredsCallback != null) {
				this._onArmyControllerCureInjuredsCallback.apply(this, [event]);
				this._onArmyControllerCureInjuredsCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onArmyControllerDisbandInjuredsHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("army.disbandInjureds", data);
			log.debug(event.toBeString());
			if (this._onArmyControllerDisbandInjuredsCallback != null) {
				this._onArmyControllerDisbandInjuredsCallback.apply(this, [event]);
				this._onArmyControllerDisbandInjuredsCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onArmyControllerGetBattleArmyCountHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.army.BattleArmyCountResponse("army.getBattleArmyCount", data);
			log.debug(event.toBeString());
			if (this._onArmyControllerGetBattleArmyCountCallback != null) {
				this._onArmyControllerGetBattleArmyCountCallback.apply(this, [event]);
				this._onArmyControllerGetBattleArmyCountCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onArmyControllerGetBattleArmysInfoHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.army.BattleArmysInfoResponse("army.getBattleArmysInfo", data);
			log.debug(event.toBeString());
			if (this._onArmyControllerGetBattleArmysInfoCallback != null) {
				this._onArmyControllerGetBattleArmysInfoCallback.apply(this, [event]);
				this._onArmyControllerGetBattleArmysInfoCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onArmyControllerGetFieldBattleInfoHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.army.BattleInfoResponse("army.getFieldBattleInfo", data);
			log.debug(event.toBeString());
			if (this._onArmyControllerGetFieldBattleInfoCallback != null) {
				this._onArmyControllerGetFieldBattleInfoCallback.apply(this, [event]);
				this._onArmyControllerGetFieldBattleInfoCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onArmyControllerGetFreshManBattleFieldHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.army.FreshBattleFieldResponse("army.getFreshManBattleField", data);
			log.debug(event.toBeString());
			if (this._onArmyControllerGetFreshManBattleFieldCallback != null) {
				this._onArmyControllerGetFreshManBattleFieldCallback.apply(this, [event]);
				this._onArmyControllerGetFreshManBattleFieldCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onArmyControllerGetPlayerBattleInfoHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.army.BattleInfoResponse("army.getPlayerBattleInfo", data);
			log.debug(event.toBeString());
			if (this._onArmyControllerGetPlayerBattleInfoCallback != null) {
				this._onArmyControllerGetPlayerBattleInfoCallback.apply(this, [event]);
				this._onArmyControllerGetPlayerBattleInfoCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onArmyControllerHeroTroopChangeNumHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("army.heroTroopChangeNum", data);
			log.debug(event.toBeString());
			if (this._onArmyControllerHeroTroopChangeNumCallback != null) {
				this._onArmyControllerHeroTroopChangeNumCallback.apply(this, [event]);
				this._onArmyControllerHeroTroopChangeNumCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onArmyControllerHeroTroopSwapPositionHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("army.heroTroopSwapPosition", data);
			log.debug(event.toBeString());
			if (this._onArmyControllerHeroTroopSwapPositionCallback != null) {
				this._onArmyControllerHeroTroopSwapPositionCallback.apply(this, [event]);
				this._onArmyControllerHeroTroopSwapPositionCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onArmyControllerJoinWarFieldHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("army.joinWarField", data);
			log.debug(event.toBeString());
			if (this._onArmyControllerJoinWarFieldCallback != null) {
				this._onArmyControllerJoinWarFieldCallback.apply(this, [event]);
				this._onArmyControllerJoinWarFieldCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onArmyControllerNewScoutHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("army.newScout", data);
			log.debug(event.toBeString());
			if (this._onArmyControllerNewScoutCallback != null) {
				this._onArmyControllerNewScoutCallback.apply(this, [event]);
				this._onArmyControllerNewScoutCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onArmyControllerReCallArmyHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("army.reCallArmy", data);
			log.debug(event.toBeString());
			if (this._onArmyControllerReCallArmyCallback != null) {
				this._onArmyControllerReCallArmyCallback.apply(this, [event]);
				this._onArmyControllerReCallArmyCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onArmyControllerScoutNpcFieldHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.army.ScoutNpcFieldResponse("army.scoutNpcField", data);
			log.debug(event.toBeString());
			if (this._onArmyControllerScoutNpcFieldCallback != null) {
				this._onArmyControllerScoutNpcFieldCallback.apply(this, [event]);
				this._onArmyControllerScoutNpcFieldCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onArmyControllerSendAllianceBackHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("army.sendAllianceBack", data);
			log.debug(event.toBeString());
			if (this._onArmyControllerSendAllianceBackCallback != null) {
				this._onArmyControllerSendAllianceBackCallback.apply(this, [event]);
				this._onArmyControllerSendAllianceBackCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onArmyControllerSetAllowLeagueArmyHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("army.setAllowLeagueArmy", data);
			log.debug(event.toBeString());
			if (this._onArmyControllerSetAllowLeagueArmyCallback != null) {
				this._onArmyControllerSetAllowLeagueArmyCallback.apply(this, [event]);
				this._onArmyControllerSetAllowLeagueArmyCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onArmyControllerSetAntiLootHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("army.setAntiLoot", data);
			log.debug(event.toBeString());
			if (this._onArmyControllerSetAntiLootCallback != null) {
				this._onArmyControllerSetAntiLootCallback.apply(this, [event]);
				this._onArmyControllerSetAntiLootCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onArmyControllerTrainArmyHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.army.ArmyExecResponse("army.trainArmy", data);
			log.debug(event.toBeString());
			if (this._onArmyControllerTrainArmyCallback != null) {
				this._onArmyControllerTrainArmyCallback.apply(this, [event]);
				this._onArmyControllerTrainArmyCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onArmyControllerUninstallHeroTroopHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("army.uninstallHeroTroop", data);
			log.debug(event.toBeString());
			if (this._onArmyControllerUninstallHeroTroopCallback != null) {
				this._onArmyControllerUninstallHeroTroopCallback.apply(this, [event]);
				this._onArmyControllerUninstallHeroTroopCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onBuildingControllerCancleBuildingHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("building.cancleBuilding", data);
			log.debug(event.toBeString());
			if (this._onBuildingControllerCancleBuildingCallback != null) {
				this._onBuildingControllerCancleBuildingCallback.apply(this, [event]);
				this._onBuildingControllerCancleBuildingCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onBuildingControllerConsNewBuildingHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("building.consNewBuilding", data);
			log.debug(event.toBeString());
			if (this._onBuildingControllerConsNewBuildingCallback != null) {
				this._onBuildingControllerConsNewBuildingCallback.apply(this, [event]);
				this._onBuildingControllerConsNewBuildingCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onBuildingControllerDestructDownBuildingHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("building.destructDownBuilding", data);
			log.debug(event.toBeString());
			if (this._onBuildingControllerDestructDownBuildingCallback != null) {
				this._onBuildingControllerDestructDownBuildingCallback.apply(this, [event]);
				this._onBuildingControllerDestructDownBuildingCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onBuildingControllerIncreaseConstructLimitHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("building.increaseConstructLimit", data);
			log.debug(event.toBeString());
			if (this._onBuildingControllerIncreaseConstructLimitCallback != null) {
				this._onBuildingControllerIncreaseConstructLimitCallback.apply(this, [event]);
				this._onBuildingControllerIncreaseConstructLimitCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onBuildingControllerSpeedUpBuildingHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("building.speedUpBuilding", data);
			log.debug(event.toBeString());
			if (this._onBuildingControllerSpeedUpBuildingCallback != null) {
				this._onBuildingControllerSpeedUpBuildingCallback.apply(this, [event]);
				this._onBuildingControllerSpeedUpBuildingCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onBuildingControllerUpgradeArchitectureHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("building.upgradeArchitecture", data);
			log.debug(event.toBeString());
			if (this._onBuildingControllerUpgradeArchitectureCallback != null) {
				this._onBuildingControllerUpgradeArchitectureCallback.apply(this, [event]);
				this._onBuildingControllerUpgradeArchitectureCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCityControllerAcceptBeConquestedApplyHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("castle.acceptBeConquestedApply", data);
			log.debug(event.toBeString());
			if (this._onCityControllerAcceptBeConquestedApplyCallback != null) {
				this._onCityControllerAcceptBeConquestedApplyCallback.apply(this, [event]);
				this._onCityControllerAcceptBeConquestedApplyCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCityControllerAdvTransCastleHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("castle.advTransCastle", data);
			log.debug(event.toBeString());
			if (this._onCityControllerAdvTransCastleCallback != null) {
				this._onCityControllerAdvTransCastleCallback.apply(this, [event]);
				this._onCityControllerAdvTransCastleCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCityControllerApplyBeConquestedHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("castle.applyBeConquested", data);
			log.debug(event.toBeString());
			if (this._onCityControllerApplyBeConquestedCallback != null) {
				this._onCityControllerApplyBeConquestedCallback.apply(this, [event]);
				this._onCityControllerApplyBeConquestedCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCityControllerConfortPeopleHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("castle.confortPeople", data);
			log.debug(event.toBeString());
			if (this._onCityControllerConfortPeopleCallback != null) {
				this._onCityControllerConfortPeopleCallback.apply(this, [event]);
				this._onCityControllerConfortPeopleCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCityControllerConquestResourceHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.castle.ConquestResourceResponse("castle.conquestResource", data);
			log.debug(event.toBeString());
			if (this._onCityControllerConquestResourceCallback != null) {
				this._onCityControllerConquestResourceCallback.apply(this, [event]);
				this._onCityControllerConquestResourceCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCityControllerConstructCityHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("castle.constructCity", data);
			log.debug(event.toBeString());
			if (this._onCityControllerConstructCityCallback != null) {
				this._onCityControllerConstructCityCallback.apply(this, [event]);
				this._onCityControllerConstructCityCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCityControllerExpandCastleHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("castle.expandCastle", data);
			log.debug(event.toBeString());
			if (this._onCityControllerExpandCastleCallback != null) {
				this._onCityControllerExpandCastleCallback.apply(this, [event]);
				this._onCityControllerExpandCastleCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCityControllerGiveUpSelfFieldHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("castle.giveUpSelfField", data);
			log.debug(event.toBeString());
			if (this._onCityControllerGiveUpSelfFieldCallback != null) {
				this._onCityControllerGiveUpSelfFieldCallback.apply(this, [event]);
				this._onCityControllerGiveUpSelfFieldCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCityControllerGiveupCityHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("castle.giveupCity", data);
			log.debug(event.toBeString());
			if (this._onCityControllerGiveupCityCallback != null) {
				this._onCityControllerGiveupCityCallback.apply(this, [event]);
				this._onCityControllerGiveupCityCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCityControllerGiveupConquestedCastleHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("castle.giveupConquestedCastle", data);
			log.debug(event.toBeString());
			if (this._onCityControllerGiveupConquestedCastleCallback != null) {
				this._onCityControllerGiveupConquestedCastleCallback.apply(this, [event]);
				this._onCityControllerGiveupConquestedCastleCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCityControllerIndependentByItemHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("castle.independentByItem", data);
			log.debug(event.toBeString());
			if (this._onCityControllerIndependentByItemCallback != null) {
				this._onCityControllerIndependentByItemCallback.apply(this, [event]);
				this._onCityControllerIndependentByItemCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCityControllerIndependentWarHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("castle.independentWar", data);
			log.debug(event.toBeString());
			if (this._onCityControllerIndependentWarCallback != null) {
				this._onCityControllerIndependentWarCallback.apply(this, [event]);
				this._onCityControllerIndependentWarCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCityControllerLevyResourceHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("castle.levyResource", data);
			log.debug(event.toBeString());
			if (this._onCityControllerLevyResourceCallback != null) {
				this._onCityControllerLevyResourceCallback.apply(this, [event]);
				this._onCityControllerLevyResourceCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCityControllerLiberateSelfCastleHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("castle.liberateSelfCastle", data);
			log.debug(event.toBeString());
			if (this._onCityControllerLiberateSelfCastleCallback != null) {
				this._onCityControllerLiberateSelfCastleCallback.apply(this, [event]);
				this._onCityControllerLiberateSelfCastleCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCityControllerModifyCityNameHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("castle.modifyCityName", data);
			log.debug(event.toBeString());
			if (this._onCityControllerModifyCityNameCallback != null) {
				this._onCityControllerModifyCityNameCallback.apply(this, [event]);
				this._onCityControllerModifyCityNameCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCityControllerModifyOperRateHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("castle.modifyOperRate", data);
			log.debug(event.toBeString());
			if (this._onCityControllerModifyOperRateCallback != null) {
				this._onCityControllerModifyOperRateCallback.apply(this, [event]);
				this._onCityControllerModifyOperRateCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCityControllerModifyStoreRateHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("castle.modifyStoreRate", data);
			log.debug(event.toBeString());
			if (this._onCityControllerModifyStoreRateCallback != null) {
				this._onCityControllerModifyStoreRateCallback.apply(this, [event]);
				this._onCityControllerModifyStoreRateCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCityControllerModifyTaxRateHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("castle.modifyTaxRate", data);
			log.debug(event.toBeString());
			if (this._onCityControllerModifyTaxRateCallback != null) {
				this._onCityControllerModifyTaxRateCallback.apply(this, [event]);
				this._onCityControllerModifyTaxRateCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCityControllerMoveCityHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("castle.moveCity", data);
			log.debug(event.toBeString());
			if (this._onCityControllerMoveCityCallback != null) {
				this._onCityControllerMoveCityCallback.apply(this, [event]);
				this._onCityControllerMoveCityCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCityControllerPostTransportHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("castle.postTransport", data);
			log.debug(event.toBeString());
			if (this._onCityControllerPostTransportCallback != null) {
				this._onCityControllerPostTransportCallback.apply(this, [event]);
				this._onCityControllerPostTransportCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCityControllerRefuseBeConquestedApplyHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("castle.refuseBeConquestedApply", data);
			log.debug(event.toBeString());
			if (this._onCityControllerRefuseBeConquestedApplyCallback != null) {
				this._onCityControllerRefuseBeConquestedApplyCallback.apply(this, [event]);
				this._onCityControllerRefuseBeConquestedApplyCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCityControllerResourceStaticsHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.castle.ResourceStaticResponse("castle.resourceStatics", data);
			log.debug(event.toBeString());
			if (this._onCityControllerResourceStaticsCallback != null) {
				this._onCityControllerResourceStaticsCallback.apply(this, [event]);
				this._onCityControllerResourceStaticsCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCityControllerServerGodHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("castle.serverGod", data);
			log.debug(event.toBeString());
			if (this._onCityControllerServerGodCallback != null) {
				this._onCityControllerServerGodCallback.apply(this, [event]);
				this._onCityControllerServerGodCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onChatAdminControllerCancelNoChatBuffHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("chat.cancelNoChatBuff", data);
			log.debug(event.toBeString());
			if (this._onChatAdminControllerCancelNoChatBuffCallback != null) {
				this._onChatAdminControllerCancelNoChatBuffCallback.apply(this, [event]);
				this._onChatAdminControllerCancelNoChatBuffCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onChatAdminControllerGmLoginHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.user.GmLoginResponse("chat.gmLogin", data);
			log.debug(event.toBeString());
			if (this._onChatAdminControllerGmLoginCallback != null) {
				this._onChatAdminControllerGmLoginCallback.apply(this, [event]);
				this._onChatAdminControllerGmLoginCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onChatAdminControllerScreenChatHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("chat.screenChat", data);
			log.debug(event.toBeString());
			if (this._onChatAdminControllerScreenChatCallback != null) {
				this._onChatAdminControllerScreenChatCallback.apply(this, [event]);
				this._onChatAdminControllerScreenChatCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onChatAdminControllerSearchPlayerByNameHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.chat.PlayerResponse("chat.searchPlayerByName", data);
			log.debug(event.toBeString());
			if (this._onChatAdminControllerSearchPlayerByNameCallback != null) {
				this._onChatAdminControllerSearchPlayerByNameCallback.apply(this, [event]);
				this._onChatAdminControllerSearchPlayerByNameCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onChatAdminControllerSendAdminMessageHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("chat.sendAdminMessage", data);
			log.debug(event.toBeString());
			if (this._onChatAdminControllerSendAdminMessageCallback != null) {
				this._onChatAdminControllerSendAdminMessageCallback.apply(this, [event]);
				this._onChatAdminControllerSendAdminMessageCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onChatControllerChatHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("chat.chat", data);
			log.debug(event.toBeString());
			if (this._onChatControllerChatCallback != null) {
				this._onChatControllerChatCallback.apply(this, [event]);
				this._onChatControllerChatCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onChatControllerEnterChannelHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("chat.enterChannel", data);
			log.debug(event.toBeString());
			if (this._onChatControllerEnterChannelCallback != null) {
				this._onChatControllerEnterChannelCallback.apply(this, [event]);
				this._onChatControllerEnterChannelCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onChatControllerQuitChannelHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("chat.quitChannel", data);
			log.debug(event.toBeString());
			if (this._onChatControllerQuitChannelCallback != null) {
				this._onChatControllerQuitChannelCallback.apply(this, [event]);
				this._onChatControllerQuitChannelCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCommonControllerGetLeagueInfoHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.common.AllianceInfoResponse("common.getLeagueInfo", data);
			log.debug(event.toBeString());
			if (this._onCommonControllerGetLeagueInfoCallback != null) {
				this._onCommonControllerGetLeagueInfoCallback.apply(this, [event]);
				this._onCommonControllerGetLeagueInfoCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCommonControllerMapDescHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.common.MapDataResponse("common.mapDesc", data);
			log.debug(event.toBeString());
			if (this._onCommonControllerMapDescCallback != null) {
				this._onCommonControllerMapDescCallback.apply(this, [event]);
				this._onCommonControllerMapDescCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCommonControllerMapFieldInfoHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.common.MapFieldInfoResponse("common.mapFieldInfo", data);
			log.debug(event.toBeString());
			if (this._onCommonControllerMapFieldInfoCallback != null) {
				this._onCommonControllerMapFieldInfoCallback.apply(this, [event]);
				this._onCommonControllerMapFieldInfoCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCommonControllerMapInfo2Handler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.common.MapInfo2Response("common.mapInfo2", data);
			log.debug(event.toBeString());
			if (this._onCommonControllerMapInfo2Callback != null) {
				this._onCommonControllerMapInfo2Callback.apply(this, [event]);
				this._onCommonControllerMapInfo2Callback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCommonControllerRollTextHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.common.RollTextResponse("common.rollText", data);
			log.debug(event.toBeString());
			if (this._onCommonControllerRollTextCallback != null) {
				this._onCommonControllerRollTextCallback.apply(this, [event]);
				this._onCommonControllerRollTextCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCommonControllerZoneInfomationHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.common.ZoneInfoDataResponse("common.zoneInfomation", data);
			log.debug(event.toBeString());
			if (this._onCommonControllerZoneInfomationCallback != null) {
				this._onCommonControllerZoneInfomationCallback.apply(this, [event]);
				this._onCommonControllerZoneInfomationCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onDebugControllerEchoHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.debug.EchoResponse("debug.echo", data);
			log.debug(event.toBeString());
			if (this._onDebugControllerEchoCallback != null) {
				this._onDebugControllerEchoCallback.apply(this, [event]);
				this._onDebugControllerEchoCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onDebugControllerGoToFutureHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("debug.goToFuture", data);
			log.debug(event.toBeString());
			if (this._onDebugControllerGoToFutureCallback != null) {
				this._onDebugControllerGoToFutureCallback.apply(this, [event]);
				this._onDebugControllerGoToFutureCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onDebugControllerRefreshResourceHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("debug.refreshResource", data);
			log.debug(event.toBeString());
			if (this._onDebugControllerRefreshResourceCallback != null) {
				this._onDebugControllerRefreshResourceCallback.apply(this, [event]);
				this._onDebugControllerRefreshResourceCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onEquipControllerBuyEquipHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("equip.buyEquip", data);
			log.debug(event.toBeString());
			if (this._onEquipControllerBuyEquipCallback != null) {
				this._onEquipControllerBuyEquipCallback.apply(this, [event]);
				this._onEquipControllerBuyEquipCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onEquipControllerDestroyEquipHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("equip.destroyEquip", data);
			log.debug(event.toBeString());
			if (this._onEquipControllerDestroyEquipCallback != null) {
				this._onEquipControllerDestroyEquipCallback.apply(this, [event]);
				this._onEquipControllerDestroyEquipCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onEquipControllerEquipForHeroHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("equip.equipForHero", data);
			log.debug(event.toBeString());
			if (this._onEquipControllerEquipForHeroCallback != null) {
				this._onEquipControllerEquipForHeroCallback.apply(this, [event]);
				this._onEquipControllerEquipForHeroCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onEquipControllerGetHeroEquipsHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.equip.HeroEquipsResponse("equip.getHeroEquips", data);
			log.debug(event.toBeString());
			if (this._onEquipControllerGetHeroEquipsCallback != null) {
				this._onEquipControllerGetHeroEquipsCallback.apply(this, [event]);
				this._onEquipControllerGetHeroEquipsCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onEquipControllerGetPlayerEquipsHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.equip.PlayerEquipResponse("equip.getPlayerEquips", data);
			log.debug(event.toBeString());
			if (this._onEquipControllerGetPlayerEquipsCallback != null) {
				this._onEquipControllerGetPlayerEquipsCallback.apply(this, [event]);
				this._onEquipControllerGetPlayerEquipsCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onEquipControllerRemoveHeroEquipHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("equip.removeHeroEquip", data);
			log.debug(event.toBeString());
			if (this._onEquipControllerRemoveHeroEquipCallback != null) {
				this._onEquipControllerRemoveHeroEquipCallback.apply(this, [event]);
				this._onEquipControllerRemoveHeroEquipCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onFortificationsControllerCancelProduceHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("fortifications.cancelProduce", data);
			log.debug(event.toBeString());
			if (this._onFortificationsControllerCancelProduceCallback != null) {
				this._onFortificationsControllerCancelProduceCallback.apply(this, [event]);
				this._onFortificationsControllerCancelProduceCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onFortificationsControllerDestructFortificationHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("fortifications.destructFortification", data);
			log.debug(event.toBeString());
			if (this._onFortificationsControllerDestructFortificationCallback != null) {
				this._onFortificationsControllerDestructFortificationCallback.apply(this, [event]);
				this._onFortificationsControllerDestructFortificationCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onFortificationsControllerProduceFortificationHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("fortifications.produceFortification", data);
			log.debug(event.toBeString());
			if (this._onFortificationsControllerProduceFortificationCallback != null) {
				this._onFortificationsControllerProduceFortificationCallback.apply(this, [event]);
				this._onFortificationsControllerProduceFortificationCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onFortificationsControllerSpeedFortificationProduceHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.troop.MayFinishAllResponse("fortifications.speedFortificationProduce", data);
			log.debug(event.toBeString());
			if (this._onFortificationsControllerSpeedFortificationProduceCallback != null) {
				this._onFortificationsControllerSpeedFortificationProduceCallback.apply(this, [event]);
				this._onFortificationsControllerSpeedFortificationProduceCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onFriendsControllerAddOrUpdatePlayerRelationHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("friends.addOrUpdatePlayerRelation", data);
			log.debug(event.toBeString());
			if (this._onFriendsControllerAddOrUpdatePlayerRelationCallback != null) {
				this._onFriendsControllerAddOrUpdatePlayerRelationCallback.apply(this, [event]);
				this._onFriendsControllerAddOrUpdatePlayerRelationCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onFriendsControllerDeletePlayerHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("friends.deletePlayer", data);
			log.debug(event.toBeString());
			if (this._onFriendsControllerDeletePlayerCallback != null) {
				this._onFriendsControllerDeletePlayerCallback.apply(this, [event]);
				this._onFriendsControllerDeletePlayerCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onFriendsControllerGetRelationPlayerInfoHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.friends.RelationPlayerInfoResponse("friends.getRelationPlayerInfo", data);
			log.debug(event.toBeString());
			if (this._onFriendsControllerGetRelationPlayerInfoCallback != null) {
				this._onFriendsControllerGetRelationPlayerInfoCallback.apply(this, [event]);
				this._onFriendsControllerGetRelationPlayerInfoCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onHeroControllerAddPointsHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("hero.addPoints", data);
			log.debug(event.toBeString());
			if (this._onHeroControllerAddPointsCallback != null) {
				this._onHeroControllerAddPointsCallback.apply(this, [event]);
				this._onHeroControllerAddPointsCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onHeroControllerAwardItemHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("hero.awardItem", data);
			log.debug(event.toBeString());
			if (this._onHeroControllerAwardItemCallback != null) {
				this._onHeroControllerAwardItemCallback.apply(this, [event]);
				this._onHeroControllerAwardItemCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onHeroControllerAwardMoneyHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("hero.awardMoney", data);
			log.debug(event.toBeString());
			if (this._onHeroControllerAwardMoneyCallback != null) {
				this._onHeroControllerAwardMoneyCallback.apply(this, [event]);
				this._onHeroControllerAwardMoneyCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onHeroControllerCancelHeroGrowthHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("hero.cancelHeroGrowth", data);
			log.debug(event.toBeString());
			if (this._onHeroControllerCancelHeroGrowthCallback != null) {
				this._onHeroControllerCancelHeroGrowthCallback.apply(this, [event]);
				this._onHeroControllerCancelHeroGrowthCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onHeroControllerDischargeLeaderHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("hero.dischargeLeader", data);
			log.debug(event.toBeString());
			if (this._onHeroControllerDischargeLeaderCallback != null) {
				this._onHeroControllerDischargeLeaderCallback.apply(this, [event]);
				this._onHeroControllerDischargeLeaderCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onHeroControllerGetTavernHerosListHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.hero.TavernHeroList("hero.getTavernHerosList", data);
			log.debug(event.toBeString());
			if (this._onHeroControllerGetTavernHerosListCallback != null) {
				this._onHeroControllerGetTavernHerosListCallback.apply(this, [event]);
				this._onHeroControllerGetTavernHerosListCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onHeroControllerInnHeroHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("hero.innHero", data);
			log.debug(event.toBeString());
			if (this._onHeroControllerInnHeroCallback != null) {
				this._onHeroControllerInnHeroCallback.apply(this, [event]);
				this._onHeroControllerInnHeroCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onHeroControllerKickHeroHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("hero.kickHero", data);
			log.debug(event.toBeString());
			if (this._onHeroControllerKickHeroCallback != null) {
				this._onHeroControllerKickHeroCallback.apply(this, [event]);
				this._onHeroControllerKickHeroCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onHeroControllerPersuadeHeroHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("hero.persuadeHero", data);
			log.debug(event.toBeString());
			if (this._onHeroControllerPersuadeHeroCallback != null) {
				this._onHeroControllerPersuadeHeroCallback.apply(this, [event]);
				this._onHeroControllerPersuadeHeroCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onHeroControllerReNameHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("hero.reName", data);
			log.debug(event.toBeString());
			if (this._onHeroControllerReNameCallback != null) {
				this._onHeroControllerReNameCallback.apply(this, [event]);
				this._onHeroControllerReNameCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onHeroControllerReachLevelHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("hero.reachLevel", data);
			log.debug(event.toBeString());
			if (this._onHeroControllerReachLevelCallback != null) {
				this._onHeroControllerReachLevelCallback.apply(this, [event]);
				this._onHeroControllerReachLevelCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onHeroControllerRefreshTavernHerosListHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.hero.TavernHeroList("hero.refreshTavernHerosList", data);
			log.debug(event.toBeString());
			if (this._onHeroControllerRefreshTavernHerosListCallback != null) {
				this._onHeroControllerRefreshTavernHerosListCallback.apply(this, [event]);
				this._onHeroControllerRefreshTavernHerosListCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onHeroControllerResetHeroPointsHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("hero.resetHeroPoints", data);
			log.debug(event.toBeString());
			if (this._onHeroControllerResetHeroPointsCallback != null) {
				this._onHeroControllerResetHeroPointsCallback.apply(this, [event]);
				this._onHeroControllerResetHeroPointsCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onHeroControllerSendHeroForGrowthHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("hero.sendHeroForGrowth", data);
			log.debug(event.toBeString());
			if (this._onHeroControllerSendHeroForGrowthCallback != null) {
				this._onHeroControllerSendHeroForGrowthCallback.apply(this, [event]);
				this._onHeroControllerSendHeroForGrowthCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onHeroControllerSetToChiefHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("hero.setToChief", data);
			log.debug(event.toBeString());
			if (this._onHeroControllerSetToChiefCallback != null) {
				this._onHeroControllerSetToChiefCallback.apply(this, [event]);
				this._onHeroControllerSetToChiefCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onHeroControllerSortHeroHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("hero.sortHero", data);
			log.debug(event.toBeString());
			if (this._onHeroControllerSortHeroCallback != null) {
				this._onHeroControllerSortHeroCallback.apply(this, [event]);
				this._onHeroControllerSortHeroCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onHeroControllerSpeedUpHeroGrowthHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("hero.speedUpHeroGrowth", data);
			log.debug(event.toBeString());
			if (this._onHeroControllerSpeedUpHeroGrowthCallback != null) {
				this._onHeroControllerSpeedUpHeroGrowthCallback.apply(this, [event]);
				this._onHeroControllerSpeedUpHeroGrowthCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onHeroControllerTreatSeizedHeroHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("hero.treatSeizedHero", data);
			log.debug(event.toBeString());
			if (this._onHeroControllerTreatSeizedHeroCallback != null) {
				this._onHeroControllerTreatSeizedHeroCallback.apply(this, [event]);
				this._onHeroControllerTreatSeizedHeroCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onLetterControllerDeleteMailsHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("mail.deleteMails", data);
			log.debug(event.toBeString());
			if (this._onLetterControllerDeleteMailsCallback != null) {
				this._onLetterControllerDeleteMailsCallback.apply(this, [event]);
				this._onLetterControllerDeleteMailsCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onLetterControllerMarkAsReadedHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("mail.markAsReaded", data);
			log.debug(event.toBeString());
			if (this._onLetterControllerMarkAsReadedCallback != null) {
				this._onLetterControllerMarkAsReadedCallback.apply(this, [event]);
				this._onLetterControllerMarkAsReadedCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onLetterControllerReadLetterHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.mail.LetterResponse("mail.readLetter", data);
			log.debug(event.toBeString());
			if (this._onLetterControllerReadLetterCallback != null) {
				this._onLetterControllerReadLetterCallback.apply(this, [event]);
				this._onLetterControllerReadLetterCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onLetterControllerReceiveLetterListHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.mail.LetterListResponse("mail.receiveLetterList", data);
			log.debug(event.toBeString());
			if (this._onLetterControllerReceiveLetterListCallback != null) {
				this._onLetterControllerReceiveLetterListCallback.apply(this, [event]);
				this._onLetterControllerReceiveLetterListCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onLetterControllerSendLetterHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("mail.sendLetter", data);
			log.debug(event.toBeString());
			if (this._onLetterControllerSendLetterCallback != null) {
				this._onLetterControllerSendLetterCallback.apply(this, [event]);
				this._onLetterControllerSendLetterCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onPlayerControllerAddOrUpdateFieldCollectHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("player.addOrUpdateFieldCollect", data);
			log.debug(event.toBeString());
			if (this._onPlayerControllerAddOrUpdateFieldCollectCallback != null) {
				this._onPlayerControllerAddOrUpdateFieldCollectCallback.apply(this, [event]);
				this._onPlayerControllerAddOrUpdateFieldCollectCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onPlayerControllerCancelTruceHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("player.cancelTruce", data);
			log.debug(event.toBeString());
			if (this._onPlayerControllerCancelTruceCallback != null) {
				this._onPlayerControllerCancelTruceCallback.apply(this, [event]);
				this._onPlayerControllerCancelTruceCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onPlayerControllerChangeFlagHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("player.changeFlag", data);
			log.debug(event.toBeString());
			if (this._onPlayerControllerChangeFlagCallback != null) {
				this._onPlayerControllerChangeFlagCallback.apply(this, [event]);
				this._onPlayerControllerChangeFlagCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onPlayerControllerChangeLogoHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("player.changeLogo", data);
			log.debug(event.toBeString());
			if (this._onPlayerControllerChangeLogoCallback != null) {
				this._onPlayerControllerChangeLogoCallback.apply(this, [event]);
				this._onPlayerControllerChangeLogoCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onPlayerControllerDeleteFieldCollectHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("player.deleteFieldCollect", data);
			log.debug(event.toBeString());
			if (this._onPlayerControllerDeleteFieldCollectCallback != null) {
				this._onPlayerControllerDeleteFieldCollectCallback.apply(this, [event]);
				this._onPlayerControllerDeleteFieldCollectCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onPlayerControllerGetPlayerCastlesHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.player.PlayerCastleResponse("player.getPlayerCastles", data);
			log.debug(event.toBeString());
			if (this._onPlayerControllerGetPlayerCastlesCallback != null) {
				this._onPlayerControllerGetPlayerCastlesCallback.apply(this, [event]);
				this._onPlayerControllerGetPlayerCastlesCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onPlayerControllerModifyPlayerNameHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("player.modifyPlayerName", data);
			log.debug(event.toBeString());
			if (this._onPlayerControllerModifyPlayerNameCallback != null) {
				this._onPlayerControllerModifyPlayerNameCallback.apply(this, [event]);
				this._onPlayerControllerModifyPlayerNameCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onPlayerControllerModifyPlayerSignatureHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("player.modifyPlayerSignature", data);
			log.debug(event.toBeString());
			if (this._onPlayerControllerModifyPlayerSignatureCallback != null) {
				this._onPlayerControllerModifyPlayerSignatureCallback.apply(this, [event]);
				this._onPlayerControllerModifyPlayerSignatureCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onPlayerControllerRemoveUiBuffHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("player.removeUiBuff", data);
			log.debug(event.toBeString());
			if (this._onPlayerControllerRemoveUiBuffCallback != null) {
				this._onPlayerControllerRemoveUiBuffCallback.apply(this, [event]);
				this._onPlayerControllerRemoveUiBuffCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onPlayerControllerRestartHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("player.restart", data);
			log.debug(event.toBeString());
			if (this._onPlayerControllerRestartCallback != null) {
				this._onPlayerControllerRestartCallback.apply(this, [event]);
				this._onPlayerControllerRestartCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onPlayerControllerSendSpyHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("player.sendSpy", data);
			log.debug(event.toBeString());
			if (this._onPlayerControllerSendSpyCallback != null) {
				this._onPlayerControllerSendSpyCallback.apply(this, [event]);
				this._onPlayerControllerSendSpyCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onPlayerControllerTruceHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("player.truce", data);
			log.debug(event.toBeString());
			if (this._onPlayerControllerTruceCallback != null) {
				this._onPlayerControllerTruceCallback.apply(this, [event]);
				this._onPlayerControllerTruceCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onTaskControllerFinishedQuestCountHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.quest.FinishedQuestCountResponse("quest.finishedQuestCount", data);
			log.debug(event.toBeString());
			if (this._onTaskControllerFinishedQuestCountCallback != null) {
				this._onTaskControllerFinishedQuestCountCallback.apply(this, [event]);
				this._onTaskControllerFinishedQuestCountCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onTaskControllerGetAwardHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("quest.getAward", data);
			log.debug(event.toBeString());
			if (this._onTaskControllerGetAwardCallback != null) {
				this._onTaskControllerGetAwardCallback.apply(this, [event]);
				this._onTaskControllerGetAwardCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onTaskControllerGetQuestTypeListHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.quest.QuestCategoryResponse("quest.getQuestTypeList", data);
			log.debug(event.toBeString());
			if (this._onTaskControllerGetQuestTypeListCallback != null) {
				this._onTaskControllerGetQuestTypeListCallback.apply(this, [event]);
				this._onTaskControllerGetQuestTypeListCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onTaskControllerGetTaskListHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.quest.TaskListResponse("quest.getTaskList", data);
			log.debug(event.toBeString());
			if (this._onTaskControllerGetTaskListCallback != null) {
				this._onTaskControllerGetTaskListCallback.apply(this, [event]);
				this._onTaskControllerGetTaskListCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onRankControllerGetAttackRankHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("rank.getAttackRank", data);
			log.debug(event.toBeString());
			if (this._onRankControllerGetAttackRankCallback != null) {
				this._onRankControllerGetAttackRankCallback.apply(this, [event]);
				this._onRankControllerGetAttackRankCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onRankControllerGetCityRankHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.rank.RankCityResponse("rank.getCityRank", data);
			log.debug(event.toBeString());
			if (this._onRankControllerGetCityRankCallback != null) {
				this._onRankControllerGetCityRankCallback.apply(this, [event]);
				this._onRankControllerGetCityRankCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onRankControllerGetDefenceRankHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("rank.getDefenceRank", data);
			log.debug(event.toBeString());
			if (this._onRankControllerGetDefenceRankCallback != null) {
				this._onRankControllerGetDefenceRankCallback.apply(this, [event]);
				this._onRankControllerGetDefenceRankCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onRankControllerGetHeroManRankHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.rank.RankHeroManResponse("rank.getHeroManRank", data);
			log.debug(event.toBeString());
			if (this._onRankControllerGetHeroManRankCallback != null) {
				this._onRankControllerGetHeroManRankCallback.apply(this, [event]);
				this._onRankControllerGetHeroManRankCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onRankControllerGetLeagueRankHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.rank.RankLeagueResponse("rank.getLeagueRank", data);
			log.debug(event.toBeString());
			if (this._onRankControllerGetLeagueRankCallback != null) {
				this._onRankControllerGetLeagueRankCallback.apply(this, [event]);
				this._onRankControllerGetLeagueRankCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onRankControllerGetPlayerInfoHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.rank.RankPlayerDataResponse("rank.getPlayerInfo", data);
			log.debug(event.toBeString());
			if (this._onRankControllerGetPlayerInfoCallback != null) {
				this._onRankControllerGetPlayerInfoCallback.apply(this, [event]);
				this._onRankControllerGetPlayerInfoCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onRankControllerGetPlayerRankHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.rank.RankPlayerDataResponse("rank.getPlayerRank", data);
			log.debug(event.toBeString());
			if (this._onRankControllerGetPlayerRankCallback != null) {
				this._onRankControllerGetPlayerRankCallback.apply(this, [event]);
				this._onRankControllerGetPlayerRankCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onReportControllerDeleteReportsHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("report.deleteReports", data);
			log.debug(event.toBeString());
			if (this._onReportControllerDeleteReportsCallback != null) {
				this._onReportControllerDeleteReportsCallback.apply(this, [event]);
				this._onReportControllerDeleteReportsCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onReportControllerMarkReadedHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("report.markReaded", data);
			log.debug(event.toBeString());
			if (this._onReportControllerMarkReadedCallback != null) {
				this._onReportControllerMarkReadedCallback.apply(this, [event]);
				this._onReportControllerMarkReadedCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onReportControllerMarkStoreHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("report.markStore", data);
			log.debug(event.toBeString());
			if (this._onReportControllerMarkStoreCallback != null) {
				this._onReportControllerMarkStoreCallback.apply(this, [event]);
				this._onReportControllerMarkStoreCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onReportControllerReceiveReportsHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.report.MessageListResponse("report.receiveReports", data);
			log.debug(event.toBeString());
			if (this._onReportControllerReceiveReportsCallback != null) {
				this._onReportControllerReceiveReportsCallback.apply(this, [event]);
				this._onReportControllerReceiveReportsCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onShopControllerBuyItemHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("shop.buyItem", data);
			log.debug(event.toBeString());
			if (this._onShopControllerBuyItemCallback != null) {
				this._onShopControllerBuyItemCallback.apply(this, [event]);
				this._onShopControllerBuyItemCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onShopControllerBuyResourcesHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("shop.buyResources", data);
			log.debug(event.toBeString());
			if (this._onShopControllerBuyResourcesCallback != null) {
				this._onShopControllerBuyResourcesCallback.apply(this, [event]);
				this._onShopControllerBuyResourcesCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onShopControllerGetBuyResourceDetailHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.shop.PurchaseResourceInfoResponse("shop.getBuyResourceDetail", data);
			log.debug(event.toBeString());
			if (this._onShopControllerGetBuyResourceDetailCallback != null) {
				this._onShopControllerGetBuyResourceDetailCallback.apply(this, [event]);
				this._onShopControllerGetBuyResourceDetailCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onShopControllerUsePlayerItemHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.shop.UseMaterialResultResponse("shop.usePlayerItem", data);
			log.debug(event.toBeString());
			if (this._onShopControllerUsePlayerItemCallback != null) {
				this._onShopControllerUsePlayerItemCallback.apply(this, [event]);
				this._onShopControllerUsePlayerItemCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onShopControllerUseRoletteHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.shop.UseRoletteResponse("shop.useRolette", data);
			log.debug(event.toBeString());
			if (this._onShopControllerUseRoletteCallback != null) {
				this._onShopControllerUseRoletteCallback.apply(this, [event]);
				this._onShopControllerUseRoletteCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onTechControllerCancelTechResearchHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("tech.cancelTechResearch", data);
			log.debug(event.toBeString());
			if (this._onTechControllerCancelTechResearchCallback != null) {
				this._onTechControllerCancelTechResearchCallback.apply(this, [event]);
				this._onTechControllerCancelTechResearchCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onTechControllerSpeedUpResearchHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("tech.speedUpResearch", data);
			log.debug(event.toBeString());
			if (this._onTechControllerSpeedUpResearchCallback != null) {
				this._onTechControllerSpeedUpResearchCallback.apply(this, [event]);
				this._onTechControllerSpeedUpResearchCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onTechControllerStartResearchHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("tech.startResearch", data);
			log.debug(event.toBeString());
			if (this._onTechControllerStartResearchCallback != null) {
				this._onTechControllerStartResearchCallback.apply(this, [event]);
				this._onTechControllerStartResearchCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCampControllerCreateCampHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("tent.createCamp", data);
			log.debug(event.toBeString());
			if (this._onCampControllerCreateCampCallback != null) {
				this._onCampControllerCreateCampCallback.apply(this, [event]);
				this._onCampControllerCreateCampCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCampControllerModifyCampNameHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("tent.modifyCampName", data);
			log.debug(event.toBeString());
			if (this._onCampControllerModifyCampNameCallback != null) {
				this._onCampControllerModifyCampNameCallback.apply(this, [event]);
				this._onCampControllerModifyCampNameCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onCampControllerMoveCampHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("tent.moveCamp", data);
			log.debug(event.toBeString());
			if (this._onCampControllerMoveCampCallback != null) {
				this._onCampControllerMoveCampCallback.apply(this, [event]);
				this._onCampControllerMoveCampCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onTradeControllerCancelCityTradeHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("trade.cancelCityTrade", data);
			log.debug(event.toBeString());
			if (this._onTradeControllerCancelCityTradeCallback != null) {
				this._onTradeControllerCancelCityTradeCallback.apply(this, [event]);
				this._onTradeControllerCancelCityTradeCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onTradeControllerCreateNewTradeHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("trade.createNewTrade", data);
			log.debug(event.toBeString());
			if (this._onTradeControllerCreateNewTradeCallback != null) {
				this._onTradeControllerCreateNewTradeCallback.apply(this, [event]);
				this._onTradeControllerCreateNewTradeCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onTradeControllerFindTradesHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.trade.SearchTradeResponse("trade.findTrades", data);
			log.debug(event.toBeString());
			if (this._onTradeControllerFindTradesCallback != null) {
				this._onTradeControllerFindTradesCallback.apply(this, [event]);
				this._onTradeControllerFindTradesCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onTradeControllerGetSelfTradesHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.trade.BusenissListResponse("trade.getSelfTrades", data);
			log.debug(event.toBeString());
			if (this._onTradeControllerGetSelfTradesCallback != null) {
				this._onTradeControllerGetSelfTradesCallback.apply(this, [event]);
				this._onTradeControllerGetSelfTradesCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onTradeControllerGetTransingTradesHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.trade.TransingMaterialListResponse("trade.getTransingTrades", data);
			log.debug(event.toBeString());
			if (this._onTradeControllerGetTransingTradesCallback != null) {
				this._onTradeControllerGetTransingTradesCallback.apply(this, [event]);
				this._onTradeControllerGetTransingTradesCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onTradeControllerSpeedUpTransitHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("trade.speedUpTransit", data);
			log.debug(event.toBeString());
			if (this._onTradeControllerSpeedUpTransitCallback != null) {
				this._onTradeControllerSpeedUpTransitCallback.apply(this, [event]);
				this._onTradeControllerSpeedUpTransitCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onTradeControllerSpeedupTransportHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("trade.speedupTransport", data);
			log.debug(event.toBeString());
			if (this._onTradeControllerSpeedupTransportCallback != null) {
				this._onTradeControllerSpeedupTransportCallback.apply(this, [event]);
				this._onTradeControllerSpeedupTransportCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onTradeControllerTransportHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("trade.transport", data);
			log.debug(event.toBeString());
			if (this._onTradeControllerTransportCallback != null) {
				this._onTradeControllerTransportCallback.apply(this, [event]);
				this._onTradeControllerTransportCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onTroopControllerCancelProduceHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("troop.cancelProduce", data);
			log.debug(event.toBeString());
			if (this._onTroopControllerCancelProduceCallback != null) {
				this._onTroopControllerCancelProduceCallback.apply(this, [event]);
				this._onTroopControllerCancelProduceCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onTroopControllerDisbandTroopsHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("troop.disbandTroops", data);
			log.debug(event.toBeString());
			if (this._onTroopControllerDisbandTroopsCallback != null) {
				this._onTroopControllerDisbandTroopsCallback.apply(this, [event]);
				this._onTroopControllerDisbandTroopsCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onTroopControllerProduceMoreTroopHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("troop.produceMoreTroop", data);
			log.debug(event.toBeString());
			if (this._onTroopControllerProduceMoreTroopCallback != null) {
				this._onTroopControllerProduceMoreTroopCallback.apply(this, [event]);
				this._onTroopControllerProduceMoreTroopCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onTroopControllerSpeedTroopProduceHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.troop.MayFinishAllResponse("troop.speedTroopProduce", data);
			log.debug(event.toBeString());
			if (this._onTroopControllerSpeedTroopProduceCallback != null) {
				this._onTroopControllerSpeedTroopProduceCallback.apply(this, [event]);
				this._onTroopControllerSpeedTroopProduceCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onUserControllerAutoLoginHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.user.EnterResponse("user.autoLogin", data);
			log.debug(event.toBeString());
			if (this._onUserControllerAutoLoginCallback != null) {
				this._onUserControllerAutoLoginCallback.apply(this, [event]);
				this._onUserControllerAutoLoginCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onUserControllerCreatePlayerHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.user.EnterResponse("user.createPlayer", data);
			log.debug(event.toBeString());
			if (this._onUserControllerCreatePlayerCallback != null) {
				this._onUserControllerCreatePlayerCallback.apply(this, [event]);
				this._onUserControllerCreatePlayerCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onUserControllerLoginHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.user.EnterResponse("user.login", data);
			log.debug(event.toBeString());
			if (this._onUserControllerLoginCallback != null) {
				this._onUserControllerLoginCallback.apply(this, [event]);
				this._onUserControllerLoginCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onWorkerControllerCancelWorkerTrainningHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("worker.cancelWorkerTrainning", data);
			log.debug(event.toBeString());
			if (this._onWorkerControllerCancelWorkerTrainningCallback != null) {
				this._onWorkerControllerCancelWorkerTrainningCallback.apply(this, [event]);
				this._onWorkerControllerCancelWorkerTrainningCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onWorkerControllerSeveranceWorkerHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("worker.severanceWorker", data);
			log.debug(event.toBeString());
			if (this._onWorkerControllerSeveranceWorkerCallback != null) {
				this._onWorkerControllerSeveranceWorkerCallback.apply(this, [event]);
				this._onWorkerControllerSeveranceWorkerCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onWorkerControllerSpeedUpTrainningHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("worker.speedUpTrainning", data);
			log.debug(event.toBeString());
			if (this._onWorkerControllerSpeedUpTrainningCallback != null) {
				this._onWorkerControllerSpeedUpTrainningCallback.apply(this, [event]);
				this._onWorkerControllerSpeedUpTrainningCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		private function _onWorkerControllerTrainningWorkerHandler(data:Object):void{
			sending = false;
			var event:BaseResponse = new roma.common.controller.CommonResponse("worker.trainningWorker", data);
			log.debug(event.toBeString());
			if (this._onWorkerControllerTrainningWorkerCallback != null) {
				this._onWorkerControllerTrainningWorkerCallback.apply(this, [event]);
				this._onWorkerControllerTrainningWorkerCallback = null;
			} else {
				log.debug("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			}
			MouseCursorManager.setNormal();
		} 
		
		private function _onAllianceRelationEventHandler(data:Object):void{
			var event:BaseResponse = new AllianceRelationEvent("server.AllianceRelationEvent", data);
			log.debug(event.toBeString());
			if (onAllianceRelationEvent!=null) {
				onAllianceRelationEvent.apply(this , [event]);
			}
			if (onAllianceRelationEvent==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onApplyBeConquestedCastleUpdateHandler(data:Object):void{
			var event:BaseResponse = new ApplyBeConquestedCastleUpdate("server.ApplyBeConquestedCastleUpdate", data);
			log.debug(event.toBeString());
			if (onApplyBeConquestedCastleUpdate!=null) {
				onApplyBeConquestedCastleUpdate.apply(this , [event]);
			}
			if (onApplyBeConquestedCastleUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onApplyHostCastleUdpateHandler(data:Object):void{
			var event:BaseResponse = new ApplyHostCastleUdpate("server.ApplyHostCastleUdpate", data);
			log.debug(event.toBeString());
			if (onApplyHostCastleUdpate!=null) {
				onApplyHostCastleUdpate.apply(this , [event]);
			}
			if (onApplyHostCastleUdpate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onBuildingUpdateHandler(data:Object):void{
			var event:BaseResponse = new BuildingUpdate("server.BuildingUpdate", data);
			log.debug(event.toBeString());
			if (onBuildingUpdate!=null) {
				onBuildingUpdate.apply(this , [event]);
			}
			if (onBuildingUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onBusinessUpdateHandler(data:Object):void{
			var event:BaseResponse = new BusinessUpdate("server.BusinessUpdate", data);
			log.debug(event.toBeString());
			if (onBusinessUpdate!=null) {
				onBusinessUpdate.apply(this , [event]);
			}
			if (onBusinessUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onCastleBuffUpdateHandler(data:Object):void{
			var event:BaseResponse = new CastleBuffUpdate("server.CastleBuffUpdate", data);
			log.debug(event.toBeString());
			if (onCastleBuffUpdate!=null) {
				onCastleBuffUpdate.apply(this , [event]);
			}
			if (onCastleBuffUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onCastleInfoUpdateHandler(data:Object):void{
			var event:BaseResponse = new CastleInfoUpdate("server.CastleInfoUpdate", data);
			log.debug(event.toBeString());
			if (onCastleInfoUpdate!=null) {
				onCastleInfoUpdate.apply(this , [event]);
			}
			if (onCastleInfoUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onCastleMilitaryUpdateHandler(data:Object):void{
			var event:BaseResponse = new CastleMilitaryUpdate("server.CastleMilitaryUpdate", data);
			log.debug(event.toBeString());
			if (onCastleMilitaryUpdate!=null) {
				onCastleMilitaryUpdate.apply(this , [event]);
			}
			if (onCastleMilitaryUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onCastlePopulationUpdateHandler(data:Object):void{
			var event:BaseResponse = new CastlePopulationUpdate("server.CastlePopulationUpdate", data);
			log.debug(event.toBeString());
			if (onCastlePopulationUpdate!=null) {
				onCastlePopulationUpdate.apply(this , [event]);
			}
			if (onCastlePopulationUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onChatMsgHandler(data:Object):void{
			var event:BaseResponse = new ChatMsg("server.ChatMsg", data);
			log.debug(event.toBeString());
			if (onChatMsg!=null) {
				onChatMsg.apply(this , [event]);
			}
			if (onChatMsg==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onCityFieldUpdateHandler(data:Object):void{
			var event:BaseResponse = new CityFieldUpdate("server.CityFieldUpdate", data);
			log.debug(event.toBeString());
			if (onCityFieldUpdate!=null) {
				onCityFieldUpdate.apply(this , [event]);
			}
			if (onCityFieldUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onCityUpdateHandler(data:Object):void{
			var event:BaseResponse = new CityUpdate("server.CityUpdate", data);
			log.debug(event.toBeString());
			if (onCityUpdate!=null) {
				onCityUpdate.apply(this , [event]);
			}
			if (onCityUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onConnectLostEventHandler(data:Object):void{
			var event:BaseResponse = new ConnectLostEvent("server.ConnectLostEvent", data);
			log.debug(event.toBeString());
			if (onConnectLostEvent!=null) {
				onConnectLostEvent.apply(this , [event]);
			}
			if (onConnectLostEvent==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onConquestCastleUpdateHandler(data:Object):void{
			var event:BaseResponse = new ConquestCastleUpdate("server.ConquestCastleUpdate", data);
			log.debug(event.toBeString());
			if (onConquestCastleUpdate!=null) {
				onConquestCastleUpdate.apply(this , [event]);
			}
			if (onConquestCastleUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onCuredTroopUpdateHandler(data:Object):void{
			var event:BaseResponse = new CuredTroopUpdate("server.CuredTroopUpdate", data);
			log.debug(event.toBeString());
			if (onCuredTroopUpdate!=null) {
				onCuredTroopUpdate.apply(this , [event]);
			}
			if (onCuredTroopUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onDebugEventHandler(data:Object):void{
			var event:BaseResponse = new DebugEvent("server.DebugEvent", data);
			log.debug(event.toBeString());
			if (onDebugEvent!=null) {
				onDebugEvent.apply(this , [event]);
			}
			if (onDebugEvent==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onFieldCollectUpdateHandler(data:Object):void{
			var event:BaseResponse = new FieldCollectUpdate("server.FieldCollectUpdate", data);
			log.debug(event.toBeString());
			if (onFieldCollectUpdate!=null) {
				onFieldCollectUpdate.apply(this , [event]);
			}
			if (onFieldCollectUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onFortiUpdateHandler(data:Object):void{
			var event:BaseResponse = new FortiUpdate("server.FortiUpdate", data);
			log.debug(event.toBeString());
			if (onFortiUpdate!=null) {
				onFortiUpdate.apply(this , [event]);
			}
			if (onFortiUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onFreeSentenceTimeUpdateHandler(data:Object):void{
			var event:BaseResponse = new FreeSentenceTimeUpdate("server.FreeSentenceTimeUpdate", data);
			log.debug(event.toBeString());
			if (onFreeSentenceTimeUpdate!=null) {
				onFreeSentenceTimeUpdate.apply(this , [event]);
			}
			if (onFreeSentenceTimeUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onFriendRelationUpdateHandler(data:Object):void{
			var event:BaseResponse = new FriendRelationUpdate("server.FriendRelationUpdate", data);
			log.debug(event.toBeString());
			if (onFriendRelationUpdate!=null) {
				onFriendRelationUpdate.apply(this , [event]);
			}
			if (onFriendRelationUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onHeroArmyUpdateHandler(data:Object):void{
			var event:BaseResponse = new HeroArmyUpdate("server.HeroArmyUpdate", data);
			log.debug(event.toBeString());
			if (onHeroArmyUpdate!=null) {
				onHeroArmyUpdate.apply(this , [event]);
			}
			if (onHeroArmyUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onHeroBuffUpdateHandler(data:Object):void{
			var event:BaseResponse = new HeroBuffUpdate("server.HeroBuffUpdate", data);
			log.debug(event.toBeString());
			if (onHeroBuffUpdate!=null) {
				onHeroBuffUpdate.apply(this , [event]);
			}
			if (onHeroBuffUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onHeroInfoUpdateHandler(data:Object):void{
			var event:BaseResponse = new HeroInfoUpdate("server.HeroInfoUpdate", data);
			log.debug(event.toBeString());
			if (onHeroInfoUpdate!=null) {
				onHeroInfoUpdate.apply(this , [event]);
			}
			if (onHeroInfoUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onHeroManUpdateHandler(data:Object):void{
			var event:BaseResponse = new HeroManUpdate("server.HeroManUpdate", data);
			log.debug(event.toBeString());
			if (onHeroManUpdate!=null) {
				onHeroManUpdate.apply(this , [event]);
			}
			if (onHeroManUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onHeroTroopUpdateHandler(data:Object):void{
			var event:BaseResponse = new HeroTroopUpdate("server.HeroTroopUpdate", data);
			log.debug(event.toBeString());
			if (onHeroTroopUpdate!=null) {
				onHeroTroopUpdate.apply(this , [event]);
			}
			if (onHeroTroopUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onHostCastleUdpateHandler(data:Object):void{
			var event:BaseResponse = new HostCastleUdpate("server.HostCastleUdpate", data);
			log.debug(event.toBeString());
			if (onHostCastleUdpate!=null) {
				onHostCastleUdpate.apply(this , [event]);
			}
			if (onHostCastleUdpate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onManufactureQueueUpdateHandler(data:Object):void{
			var event:BaseResponse = new ManufactureQueueUpdate("server.ManufactureQueueUpdate", data);
			log.debug(event.toBeString());
			if (onManufactureQueueUpdate!=null) {
				onManufactureQueueUpdate.apply(this , [event]);
			}
			if (onManufactureQueueUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onMaterialUpdateHandler(data:Object):void{
			var event:BaseResponse = new MaterialUpdate("server.MaterialUpdate", data);
			log.debug(event.toBeString());
			if (onMaterialUpdate!=null) {
				onMaterialUpdate.apply(this , [event]);
			}
			if (onMaterialUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onNewAnnounceHandler(data:Object):void{
			var event:BaseResponse = new NewAnnounce("server.NewAnnounce", data);
			log.debug(event.toBeString());
			if (onNewAnnounce!=null) {
				onNewAnnounce.apply(this , [event]);
			}
			if (onNewAnnounce==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onNewBattleMailUpdateHandler(data:Object):void{
			var event:BaseResponse = new NewBattleMailUpdate("server.NewBattleMailUpdate", data);
			log.debug(event.toBeString());
			if (onNewBattleMailUpdate!=null) {
				onNewBattleMailUpdate.apply(this , [event]);
			}
			if (onNewBattleMailUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onNewMailUpdateHandler(data:Object):void{
			var event:BaseResponse = new NewMailUpdate("server.NewMailUpdate", data);
			log.debug(event.toBeString());
			if (onNewMailUpdate!=null) {
				onNewMailUpdate.apply(this , [event]);
			}
			if (onNewMailUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onNewMessageEventHandler(data:Object):void{
			var event:BaseResponse = new NewMessageEvent("server.NewMessageEvent", data);
			log.debug(event.toBeString());
			if (onNewMessageEvent!=null) {
				onNewMessageEvent.apply(this , [event]);
			}
			if (onNewMessageEvent==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onNewQuestFinishedUpdateHandler(data:Object):void{
			var event:BaseResponse = new NewQuestFinishedUpdate("server.NewQuestFinishedUpdate", data);
			log.debug(event.toBeString());
			if (onNewQuestFinishedUpdate!=null) {
				onNewQuestFinishedUpdate.apply(this , [event]);
			}
			if (onNewQuestFinishedUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onNewRelatedBattleFieldHandler(data:Object):void{
			var event:BaseResponse = new NewRelatedBattleField("server.NewRelatedBattleField", data);
			log.debug(event.toBeString());
			if (onNewRelatedBattleField!=null) {
				onNewRelatedBattleField.apply(this , [event]);
			}
			if (onNewRelatedBattleField==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onOtherArmyLeaveHandler(data:Object):void{
			var event:BaseResponse = new OtherArmyLeave("server.OtherArmyLeave", data);
			log.debug(event.toBeString());
			if (onOtherArmyLeave!=null) {
				onOtherArmyLeave.apply(this , [event]);
			}
			if (onOtherArmyLeave==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onOtherArmyStatusUpdateHandler(data:Object):void{
			var event:BaseResponse = new OtherArmyStatusUpdate("server.OtherArmyStatusUpdate", data);
			log.debug(event.toBeString());
			if (onOtherArmyStatusUpdate!=null) {
				onOtherArmyStatusUpdate.apply(this , [event]);
			}
			if (onOtherArmyStatusUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onOtherArmyUpdateHandler(data:Object):void{
			var event:BaseResponse = new OtherArmyUpdate("server.OtherArmyUpdate", data);
			log.debug(event.toBeString());
			if (onOtherArmyUpdate!=null) {
				onOtherArmyUpdate.apply(this , [event]);
			}
			if (onOtherArmyUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onPlayerBufferUpdateHandler(data:Object):void{
			var event:BaseResponse = new PlayerBufferUpdate("server.PlayerBufferUpdate", data);
			log.debug(event.toBeString());
			if (onPlayerBufferUpdate!=null) {
				onPlayerBufferUpdate.apply(this , [event]);
			}
			if (onPlayerBufferUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onPlayerInfoDataUpdateHandler(data:Object):void{
			var event:BaseResponse = new PlayerInfoDataUpdate("server.PlayerInfoDataUpdate", data);
			log.debug(event.toBeString());
			if (onPlayerInfoDataUpdate!=null) {
				onPlayerInfoDataUpdate.apply(this , [event]);
			}
			if (onPlayerInfoDataUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onPostTransportUpdateHandler(data:Object):void{
			var event:BaseResponse = new PostTransportUpdate("server.PostTransportUpdate", data);
			log.debug(event.toBeString());
			if (onPostTransportUpdate!=null) {
				onPostTransportUpdate.apply(this , [event]);
			}
			if (onPostTransportUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onResourceMaterialUpdateHandler(data:Object):void{
			var event:BaseResponse = new ResourceMaterialUpdate("server.ResourceMaterialUpdate", data);
			log.debug(event.toBeString());
			if (onResourceMaterialUpdate!=null) {
				onResourceMaterialUpdate.apply(this , [event]);
			}
			if (onResourceMaterialUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onScoutPlayerUpdateHandler(data:Object):void{
			var event:BaseResponse = new ScoutPlayerUpdate("server.ScoutPlayerUpdate", data);
			log.debug(event.toBeString());
			if (onScoutPlayerUpdate!=null) {
				onScoutPlayerUpdate.apply(this , [event]);
			}
			if (onScoutPlayerUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onScoutUpdateHandler(data:Object):void{
			var event:BaseResponse = new ScoutUpdate("server.ScoutUpdate", data);
			log.debug(event.toBeString());
			if (onScoutUpdate!=null) {
				onScoutUpdate.apply(this , [event]);
			}
			if (onScoutUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onServerInfoEventHandler(data:Object):void{
			var event:BaseResponse = new ServerInfoEvent("server.ServerInfoEvent", data);
			log.debug(event.toBeString());
			if (onServerInfoEvent!=null) {
				onServerInfoEvent.apply(this , [event]);
			}
			if (onServerInfoEvent==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onServerItemEventHandler(data:Object):void{
			var event:BaseResponse = new ServerItemEvent("server.ServerItemEvent", data);
			log.debug(event.toBeString());
			if (onServerItemEvent!=null) {
				onServerItemEvent.apply(this , [event]);
			}
			if (onServerItemEvent==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onTechUpdateHandler(data:Object):void{
			var event:BaseResponse = new TechUpdate("server.TechUpdate", data);
			log.debug(event.toBeString());
			if (onTechUpdate!=null) {
				onTechUpdate.apply(this , [event]);
			}
			if (onTechUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onTransingBusinessUpdateHandler(data:Object):void{
			var event:BaseResponse = new TransingBusinessUpdate("server.TransingBusinessUpdate", data);
			log.debug(event.toBeString());
			if (onTransingBusinessUpdate!=null) {
				onTransingBusinessUpdate.apply(this , [event]);
			}
			if (onTransingBusinessUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onTransportUpdateHandler(data:Object):void{
			var event:BaseResponse = new TransportUpdate("server.TransportUpdate", data);
			log.debug(event.toBeString());
			if (onTransportUpdate!=null) {
				onTransportUpdate.apply(this , [event]);
			}
			if (onTransportUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onTroopManUpdateHandler(data:Object):void{
			var event:BaseResponse = new TroopManUpdate("server.TroopManUpdate", data);
			log.debug(event.toBeString());
			if (onTroopManUpdate!=null) {
				onTroopManUpdate.apply(this , [event]);
			}
			if (onTroopManUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		private function _onWorkerTrainningUpdateHandler(data:Object):void{
			var event:BaseResponse = new WorkerTrainningUpdate("server.WorkerTrainningUpdate", data);
			log.debug(event.toBeString());
			if (onWorkerTrainningUpdate!=null) {
				onWorkerTrainningUpdate.apply(this , [event]);
			}
			if (onWorkerTrainningUpdate==null && !hasEventListener(event.type)) {
				log.error("EventListener:" + event.type + " not found!");
				dispatchEvent(new CommandEvent(event.type, event));
			} else {
				dispatchEvent(event);
			}
		}
		
		public static function getInstance():ResponseEvtDispatcher {
			return _instance;
		}
		
		public function dispatch(cmd:int , data:Object):void {
			
			var func:Function = this.controllerArray[cmd] as Function;
			if (func!=null) {
				func.apply(this , [data]);
			} else {
				log.debug("ResponseEvtDispatcher.dispatch: [" + cmd + "] not found!");
			}
		}
	}
}
