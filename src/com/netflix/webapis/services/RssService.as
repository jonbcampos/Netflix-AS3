package com.netflix.webapis.services
{
	import com.netflix.webapis.ServiceFault;
	import com.netflix.webapis.events.NetflixFaultEvent;
	import com.netflix.webapis.events.NetflixResultEvent;
	import com.netflix.webapis.params.ParamsBase;
	import com.netflix.webapis.xml.NetflixXMLUtil;
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	public class RssService extends ServiceBase
	{
		public function RssService(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		//---------------------------------------------------------------------
		//
		// Public Static Consts
		//
		//---------------------------------------------------------------------
		public static const TOP_100_SERVICE:String = "top100";
		public static const NEW_RELEASES_SERVICE:String = "newReleases";
		public static const NEW_INSTANT_SERVICE:String = "newInstant";
		public static const ACTION_AND_ADVENTURE_TOP_25_SERVICE:String = "actionAndAdventure";
		public static const ANIME_AND_ANIMATION_TOP_25_SERVICE:String = "animeAndAnimation";
		public static const BLU_RAY_TOP_25_SERVICE:String = "bluRay";
		public static const CHILDREN_AND_FAMILY_TOP_25_SERVICE:String = "childrenAndFamily";
		public static const CLASSICS_TOP_25_SERVICE:String = "classics";
		public static const COMEDY_TOP_25_SERVICE:String = "comedy";
		public static const DOCUMENTARY_TOP_25_SERVICE:String = "documentary";
		public static const DRAMA_TOP_25_SERVICE:String = "drama";
		public static const FAITH_AND_SPIRITUALITY_TOP_25_SERVICE:String = "faithAndSpirituality";
		public static const FOREIGN_TOP_25_SERVICE:String = "foreign";
		public static const GAY_AND_LESBIAN_TOP_25_SERVICE:String = "gayAndLesbian";
		public static const HORROR_TOP_25_SERVICE:String = "horror";
		public static const INDEPENDENT_TOP_25_SERVICE:String = "independent";
		public static const MUSIC_AND_MUSICALS_TOP_25_SERVICE:String = "musicAndMusicals";
		public static const ROMANCE_TOP_25_SERVICE:String = "romance";
		public static const SCI_FI_AND_FANTASY_TOP_25_SERVICE:String = "sciFiAndFantasy";
		public static const SPECIAL_INTEREST_TOP_25_SERVICE:String = "specialInterest";
		public static const SPORTS_AND_FITNESS_TOP_25_SERVICE:String = "sportsAndFitness";
		public static const TELEVISION_TOP_25_SERVICE:String = "television";
		public static const THRILLERS_TOP_25_SERVICE:String = "thrillers";
		
		//---------------------------------------------------------------------
		//
		// Protected Static Consts
		//
		//---------------------------------------------------------------------
		protected static const TOP_100_URL:String = "http://rss.netflix.com/Top100RSS";
		protected static const NEW_RELEASES_URL:String = "http://rss.netflix.com/NewReleasesRSS";
		protected static const NEW_INSTANT_URL:String = "http://www.netflix.com/NewWatchInstantlyRSS";
		protected static const ACTION_AND_ADVENTURE_TOP_25_URL:String = "http://rss.netflix.com/Top25RSS?gid=296";
		protected static const ANIME_AND_ANIMATION_TOP_25_URL:String = "http://rss.netflix.com/Top25RSS?gid=623";
		protected static const BLU_RAY_TOP_25_URL:String = "http://rss.netflix.com/Top25RSS?gid=2444";
		protected static const CHILDREN_AND_FAMILY_TOP_25_URL:String = "http://rss.netflix.com/Top25RSS?gid=302";
		protected static const CLASSICS_TOP_25_URL:String = "http://rss.netflix.com/Top25RSS?gid=306";
		protected static const COMEDY_TOP_25_URL:String = "http://rss.netflix.com/Top25RSS?gid=307";
		protected static const DOCUMENTARY_TOP_25_URL:String = "http://rss.netflix.com/Top25RSS?gid=864";
		protected static const DRAMA_TOP_25_URL:String = "http://rss.netflix.com/Top25RSS?gid=315";
		protected static const FAITH_AND_SPIRITUALITY_TOP_25_URL:String = "http://rss.netflix.com/Top25RSS?gid=2108";
		protected static const FOREIGN_TOP_25_URL:String = "http://rss.netflix.com/Top25RSS?gid=2514";
		protected static const GAY_AND_LESBIAN_TOP_25_URL:String = "http://rss.netflix.com/Top25RSS?gid=330";
		protected static const HORROR_TOP_25_URL:String = "http://rss.netflix.com/Top25RSS?gid=338";
		protected static const INDEPENDENT_TOP_25_URL:String = "http://rss.netflix.com/Top25RSS?gid=343";
		protected static const MUSIC_AND_MUSICALS_TOP_25_URL:String = "http://rss.netflix.com/Top25RSS?gid=2310";
		protected static const ROMANCE_TOP_25_URL:String = "http://rss.netflix.com/Top25RSS?gid=371";
		protected static const SCI_FI_AND_FANTASY_TOP_25_URL:String = "http://rss.netflix.com/Top25RSS?gid=373";
		protected static const SPECIAL_INTEREST_TOP_25_URL:String = "http://rss.netflix.com/Top25RSS?gid=2223";
		protected static const SPORTS_AND_FITNESS_TOP_25_URL:String = "http://rss.netflix.com/Top25RSS?gid=2190";
		protected static const TELEVISION_TOP_25_URL:String = "http://rss.netflix.com/Top25RSS?gid=2197";
		protected static const THRILLERS_TOP_25_URL:String = "http://rss.netflix.com/Top25RSS?gid=387";
		
		//---------------------------------------------------------------------
		//
		// Private Properties
		//
		//---------------------------------------------------------------------
		private var _ratingService:RatingService;
		private var _urlLoader:URLLoader;
		//---------------------------------------------------------------------
		//
		// Public Methods
		//
		//---------------------------------------------------------------------
		/**
		 * @inheritDoc
		 */		
		override public function send(parameters:ParamsBase = null):void
		{
			super.send(parameters);
			
			//run service based on type
			switch(type)
			{
				case TOP_100_SERVICE:
					top100Service( parameters );
					break;
				case NEW_RELEASES_SERVICE:
					newReleasesService( parameters );
					break;
				case NEW_INSTANT_SERVICE:
					newInstantService( parameters );
					break;
				case ACTION_AND_ADVENTURE_TOP_25_SERVICE:
					actionAndAdventureService( parameters );
					break;
				case ANIME_AND_ANIMATION_TOP_25_SERVICE:
					animeAndAnimationService( parameters );
					break;
				case BLU_RAY_TOP_25_SERVICE:
					bluRayService( parameters );
					break;
				case CHILDREN_AND_FAMILY_TOP_25_SERVICE:
					childrenAndFamilyService( parameters );
					break;
				case CLASSICS_TOP_25_SERVICE:
					classicsService( parameters );
					break;
				case COMEDY_TOP_25_SERVICE:
					comedyService( parameters );
					break;
				case DOCUMENTARY_TOP_25_SERVICE:
					documentaryService( parameters );
					break;
				case DRAMA_TOP_25_SERVICE:
					dramaService( parameters );
					break;
				case FAITH_AND_SPIRITUALITY_TOP_25_SERVICE:
					faithAndSpiritualityService( parameters );
					break;
				case FOREIGN_TOP_25_SERVICE:
					foreignService( parameters );
					break;
				case GAY_AND_LESBIAN_TOP_25_SERVICE:
					gayAndLesbianService( parameters );
					break;
				case HORROR_TOP_25_SERVICE:
					horrorService( parameters );
					break;
				case INDEPENDENT_TOP_25_SERVICE:
					independentService( parameters );
					break;
				case MUSIC_AND_MUSICALS_TOP_25_SERVICE:
					musicAndMusicalsService( parameters );
					break;
				case ROMANCE_TOP_25_SERVICE:
					romanceService( parameters );
					break;
				case SCI_FI_AND_FANTASY_TOP_25_SERVICE:
					sciFiAndFantasyService( parameters );
					break;
				case SPECIAL_INTEREST_TOP_25_SERVICE:
					specialInterestService( parameters );
					break;
				case SPORTS_AND_FITNESS_TOP_25_SERVICE:
					sportsAndFitnessService( parameters );
					break;
				case TELEVISION_TOP_25_SERVICE:
					televisionService( parameters );
					break;
				case THRILLERS_TOP_25_SERVICE:
					thrillersService( parameters );
					break;
			}
		}
		
		public function top100Service(params:ParamsBase=null):void
		{
			handleServiceLoading(TOP_100_URL,determineParams(params,TOP_100_SERVICE));
		}
		
		public function newReleasesService(params:ParamsBase=null):void
		{
			handleServiceLoading(NEW_RELEASES_URL,determineParams(params,NEW_RELEASES_SERVICE));
		}
		
		public function newInstantService(params:ParamsBase=null):void
		{
			handleServiceLoading(NEW_INSTANT_URL,determineParams(params,NEW_INSTANT_SERVICE));
		}
		
		public function actionAndAdventureService(params:ParamsBase=null):void
		{
			handleServiceLoading(ACTION_AND_ADVENTURE_TOP_25_URL,determineParams(params,ACTION_AND_ADVENTURE_TOP_25_SERVICE));
		}
		
		public function animeAndAnimationService(params:ParamsBase=null):void
		{
			handleServiceLoading(ANIME_AND_ANIMATION_TOP_25_URL,determineParams(params,ANIME_AND_ANIMATION_TOP_25_SERVICE));
		}
		
		public function bluRayService(params:ParamsBase=null):void
		{
			handleServiceLoading(BLU_RAY_TOP_25_URL,determineParams(params,BLU_RAY_TOP_25_SERVICE));
		}
		
		public function childrenAndFamilyService(params:ParamsBase=null):void
		{
			handleServiceLoading(CHILDREN_AND_FAMILY_TOP_25_URL,determineParams(params,CHILDREN_AND_FAMILY_TOP_25_SERVICE));
		}
		
		public function classicsService(params:ParamsBase=null):void
		{
			handleServiceLoading(CLASSICS_TOP_25_URL,determineParams(params,CLASSICS_TOP_25_SERVICE));
		}
		
		public function comedyService(params:ParamsBase=null):void
		{
			handleServiceLoading(COMEDY_TOP_25_URL,determineParams(params,COMEDY_TOP_25_SERVICE));
		}
		
		public function documentaryService(params:ParamsBase=null):void
		{
			handleServiceLoading(DOCUMENTARY_TOP_25_URL,determineParams(params,DOCUMENTARY_TOP_25_SERVICE));
		}
		
		public function dramaService(params:ParamsBase=null):void
		{
			handleServiceLoading(DRAMA_TOP_25_URL,determineParams(params,DRAMA_TOP_25_SERVICE));
		}
		
		public function faithAndSpiritualityService(params:ParamsBase=null):void
		{
			handleServiceLoading(FAITH_AND_SPIRITUALITY_TOP_25_URL,determineParams(params,FAITH_AND_SPIRITUALITY_TOP_25_SERVICE));
		}
		
		public function foreignService(params:ParamsBase=null):void
		{
			handleServiceLoading(FOREIGN_TOP_25_URL,determineParams(params,FOREIGN_TOP_25_SERVICE));
		}
		
		public function gayAndLesbianService(params:ParamsBase=null):void
		{
			handleServiceLoading(GAY_AND_LESBIAN_TOP_25_URL,determineParams(params,GAY_AND_LESBIAN_TOP_25_SERVICE));
		}
		
		public function horrorService(params:ParamsBase=null):void
		{
			handleServiceLoading(HORROR_TOP_25_URL,determineParams(params,HORROR_TOP_25_SERVICE));
		}
		
		public function independentService(params:ParamsBase=null):void
		{
			handleServiceLoading(INDEPENDENT_TOP_25_URL,determineParams(params,INDEPENDENT_TOP_25_SERVICE));
		}
		
		public function musicAndMusicalsService(params:ParamsBase=null):void
		{
			handleServiceLoading(MUSIC_AND_MUSICALS_TOP_25_URL,determineParams(params,MUSIC_AND_MUSICALS_TOP_25_SERVICE));
		}
		
		public function romanceService(params:ParamsBase=null):void
		{
			handleServiceLoading(ROMANCE_TOP_25_URL,determineParams(params,ROMANCE_TOP_25_SERVICE));
		}
		
		public function sciFiAndFantasyService(params:ParamsBase=null):void
		{
			handleServiceLoading(SCI_FI_AND_FANTASY_TOP_25_URL,determineParams(params,SCI_FI_AND_FANTASY_TOP_25_SERVICE));
		}
		
		public function specialInterestService(params:ParamsBase=null):void
		{
			handleServiceLoading(SPECIAL_INTEREST_TOP_25_URL,determineParams(params,SPECIAL_INTEREST_TOP_25_SERVICE));
		}
		
		public function sportsAndFitnessService(params:ParamsBase=null):void
		{
			handleServiceLoading(SPORTS_AND_FITNESS_TOP_25_URL,determineParams(params,SPORTS_AND_FITNESS_TOP_25_SERVICE));
		}
		
		public function televisionService(params:ParamsBase=null):void
		{
			handleServiceLoading(TELEVISION_TOP_25_URL,determineParams(params,TELEVISION_TOP_25_SERVICE));
		}
		
		public function thrillersService(params:ParamsBase=null):void
		{
			handleServiceLoading(THRILLERS_TOP_25_URL,determineParams(params,THRILLERS_TOP_25_SERVICE));
		}
		
		/**
		 * @inheritDoc
		 */	
		override protected function handleServiceLoading(methodString:String, params:ParamsBase = null):void
		{
			super.handleServiceLoading(methodString, params);
			
			if(checkForConsumerKey()==false)
				return;
			
			var method:String = ServiceBase.GET_REQUEST_METHOD;
			var sendQuery:String = methodString;
			var typeQuery:String;
			
			if(!params)
				return;
			
			if(!_urlLoader)
			{
				_urlLoader = new URLLoader();
				_urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
				//functions
				_urlLoader.addEventListener(Event.COMPLETE,_service_CompleteHandler);
				_urlLoader.addEventListener(IOErrorEvent.IO_ERROR,faultHandler);
				_urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
				_urlLoader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
				_urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			}
			
			_urlLoader.load(new URLRequest(sendQuery));
		}
		
		/**
		 * @private
		 * Complete Handler. 
		 * @param event
		 * 
		 */		
		private function _service_CompleteHandler(event:Event):void
		{
			var loader:URLLoader = event.target as URLLoader;
			var queryXML:XML = XML(loader.data);
			
			if(queryXML.Error == undefined)
				formatAndDispatch(queryXML);
			else
				dispatchFault(new ServiceFault(NetflixFaultEvent.API_RESPONSE, queryXML.Error, queryXML.Error.Message));
			_clearLoader();
		}
		
		override protected function formatAndDispatch(returnedXML:XML):void
		{
			if(!_ratingService)
			{
				_ratingService = new RatingService();
				_ratingService.addEventListener(NetflixResultEvent.RESULT, _onRatingService_ResultHandler);
				_ratingService.addEventListener(NetflixFaultEvent.FAULT, _onRatingService_FaultHandler);
			}
			
			var titles:Array = NetflixXMLUtil.handleRssResult(returnedXML);
			_numberOfResults = titles.length;
			_currentIndex = request.startIndex;
			_resultsPerPage = request.maxResults;
			
			_ratingService.getPredictedRating(titles.slice(request.startIndex,request.startIndex+request.maxResults), request.expansions);
		}
		
		private function _onRatingService_ResultHandler(event:NetflixResultEvent):void
		{
			lastNetflixResult = event.result;
			dispatchResult(event.result,type,event.rawXML);
		}
		
		private function _onRatingService_FaultHandler(event:NetflixFaultEvent):void
		{
			dispatchEvent(event.clone());
		}
		
		private function _clearLoader():void
		{
			if(_urlLoader)
			{
				try{
					_urlLoader.close();
				} catch(e:Error){
					//no stream open
				}
				_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,faultHandler);
				_urlLoader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
				_urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
				_urlLoader.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
				_urlLoader.removeEventListener(Event.COMPLETE,_service_CompleteHandler);
				_urlLoader = null;
			}
		}
		
		//---------------------------------------------------------------------
		//
		// No Params Quick Functions
		//
		//---------------------------------------------------------------------
		public function getTop100(startIndex:uint=0, maxResults:uint=25, expansions:String = null):void
		{
			var params:ParamsBase = new ParamsBase();
			params.startIndex = startIndex;
			params.maxResults = maxResults;
			params.expansions = expansions;
			top100Service(params);
		}
		
		public function getNewReleases(startIndex:uint=0, maxResults:uint=25, expansions:String = null):void
		{
			var params:ParamsBase = new ParamsBase();
			params.startIndex = startIndex;
			params.maxResults = maxResults;
			params.expansions = expansions;
			newReleasesService(params);
		}
		
		public function getNewInstant(startIndex:uint=0, maxResults:uint=25, expansions:String = null):void
		{
			var params:ParamsBase = new ParamsBase();
			params.startIndex = startIndex;
			params.maxResults = maxResults;
			params.expansions = expansions;
			newInstantService(params);
		}
		
		public function getActionAdventureTop25(expansions:String = null):void
		{
			var params:ParamsBase = new ParamsBase();
			params.expansions = expansions;
			actionAndAdventureService(params);
		}
		
		public function getAnimeAndAnimationTop25(expansions:String = null):void
		{
			var params:ParamsBase = new ParamsBase();
			params.expansions = expansions;
			animeAndAnimationService(params);
		}
		
		public function getBluRayTop25(expansions:String = null):void
		{
			var params:ParamsBase = new ParamsBase();
			params.expansions = expansions;
			bluRayService(params);
		}
		
		public function getChildrenAndFamilyTop25(expansions:String = null):void
		{
			var params:ParamsBase = new ParamsBase();
			params.expansions = expansions;
			childrenAndFamilyService(params);
		}
		
		public function getClassicsTop25(expansions:String = null):void
		{
			var params:ParamsBase = new ParamsBase();
			params.expansions = expansions;
			classicsService(params);
		}
		
		public function getComedyTop25(expansions:String = null):void
		{
			var params:ParamsBase = new ParamsBase();
			params.expansions = expansions;
			comedyService(params);
		}
		
		public function getDocumentaryTop25(expansions:String = null):void
		{
			var params:ParamsBase = new ParamsBase();
			params.expansions = expansions;
			documentaryService(params);
		}
		
		public function getDramaTop25(expansions:String = null):void
		{
			var params:ParamsBase = new ParamsBase();
			params.expansions = expansions;
			dramaService(params);
		}
		
		public function getFaithAndSpiritualityTop25(expansions:String = null):void
		{
			var params:ParamsBase = new ParamsBase();
			params.expansions = expansions;
			faithAndSpiritualityService(params);
		}
		
		public function getForeignTop25(expansions:String = null):void
		{
			var params:ParamsBase = new ParamsBase();
			params.expansions = expansions;
			foreignService(params);
		}
		
		public function getGayAndLesbianTop25(expansions:String = null):void
		{
			var params:ParamsBase = new ParamsBase();
			params.expansions = expansions;
			gayAndLesbianService(params);
		}
		
		public function getHorrorTop25(expansions:String = null):void
		{
			var params:ParamsBase = new ParamsBase();
			params.expansions = expansions;
			horrorService(params);
		}
		
		public function getIndependentTop25(expansions:String = null):void
		{
			var params:ParamsBase = new ParamsBase();
			params.expansions = expansions;
			independentService(params);
		}
		
		public function getMusicAndMusicalsTop25(expansions:String = null):void
		{
			var params:ParamsBase = new ParamsBase();
			params.expansions = expansions;
			musicAndMusicalsService(params);
		}
		
		public function getRomanceTop25(expansions:String = null):void
		{
			var params:ParamsBase = new ParamsBase();
			params.expansions = expansions;
			romanceService(params);
		}
		
		public function getSciFiAndFantasyTop25(expansions:String = null):void
		{
			var params:ParamsBase = new ParamsBase();
			params.expansions = expansions;
			sciFiAndFantasyService(params);
		}
		
		public function getSpecialInterestTop25(expansions:String = null):void
		{
			var params:ParamsBase = new ParamsBase();
			params.expansions = expansions;
			specialInterestService(params);
		}
		
		public function getSportsAndFitnessTop25(expansions:String = null):void
		{
			var params:ParamsBase = new ParamsBase();
			params.expansions = expansions;
			sportsAndFitnessService(params);
		}
		
		public function getTelevisionTop25(expansions:String = null):void
		{
			var params:ParamsBase = new ParamsBase();
			params.expansions = expansions;
			televisionService(params);
		}
		
		public function getThrillersTop25(expansions:String = null):void
		{
			var params:ParamsBase = new ParamsBase();
			params.expansions = expansions;
			thrillersService(params);
		}
		
		
	}
}