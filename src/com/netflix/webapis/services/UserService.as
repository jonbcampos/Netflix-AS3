/**
 * Copyright (c) 2009 Netflix-AS3_API Contributors.
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of 
 * this software and associated documentation files (the "Software"), to deal in 
 * the Software without restriction, including without limitation the rights to 
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
 * of the Software, and to permit persons to whom the Software is furnished to do 
 * so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all 
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE. 
 * */
package com.netflix.webapis.services
{
	import com.netflix.webapis.ServiceFault;
	import com.netflix.webapis.events.NetflixFaultEvent;
	import com.netflix.webapis.events.UsersResultEvent;
	import com.netflix.webapis.params.ParamsBase;
	import com.netflix.webapis.params.UserParams;
	import com.netflix.webapis.vo.CategoryItemVO;
	import com.netflix.webapis.vo.NetflixUser;
	import com.netflix.webapis.xml.NetflixXMLUtilV2;
	
	import flash.events.Event;
	import flash.net.URLLoader;

	/**
	* Result Event.
	*/	
	[Event(name="userResult",type="com.netflix.webapis.events.UsersResultEvent")]
	
	[Event(name="recommendationResult",type="com.netflix.webapis.events.NetflixResultEvent")]
	[Event(name="titleStatesResult",type="com.netflix.webapis.events.NetflixResultEvent")]
	[Event(name="userFeedsResult",type="com.netflix.webapis.events.NetflixResultEvent")]
	
	/**
	 * User Services.
	 * @author jonbcampos
	 * 
	 */	
	public class UserService extends ServiceBase
	{

		public function UserService()
		{
			super();
		}
		
		//---------------------------------------------------------------------
		//
		// User Service Methods
		//
		//---------------------------------------------------------------------
		protected static const USERS_URL:String = NETFLIX_BASE_URL+"users";
		protected static const RECOMMENDATION_PART:String = "recommendations";
		
		public static const RECOMMENDATION_SERVICE:String = "recommendation";
		public static const USER_INFO_SERVICE:String = "userInfo";
		public static const TITLES_STATES_SERVICE:String = "titleStates";
		public static const USER_FEEDS_SERVICE:String = "userFeeds";
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
			
			switch(type)
			{
				case RECOMMENDATION_SERVICE:
					recommendationService( parameters );
					break;
				case USER_INFO_SERVICE:
					userInfoService( parameters );
					break;
				case TITLES_STATES_SERVICE:
					titleStatesService( parameters );
					break;
				case USER_FEEDS_SERVICE:
					userFeedsService( parameters );
					break;
			}
		}
		
		/**
		 * Returns Recommended Titles. 
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RECOMMENDATION_RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param params
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RECOMMENDATION_RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 */		
		public function recommendationService(params:ParamsBase=null):void 
		{
			handleServiceLoading(USERS_URL,determineParams(params,RECOMMENDATION_SERVICE));
		}
		
		/**
		 * Calls for the user info. Requires that you have already called the 
		 * <code>AccessTokenService.getAccessToken()</code>.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>UserResultEvent.USER_RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 *  
		 * @param params
		 * 
		 * @see com.netflix.webapis.events.UsersResultEvent#USER_RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.services.AccessTokenService#getAccessToken()
		 */		
		public function userInfoService(params:ParamsBase=null):void 
		{
			handleServiceLoading(USERS_URL,determineParams(params,USER_INFO_SERVICE));
		}
		
		/**
		 * Calls for the state of one or more title. Requires 
		 * that you have already have the user information.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 *  
		 * @param params
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#TITLES_STATES_RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 */	
		public function titleStatesService(params:ParamsBase=null):void
		{
			handleServiceLoading(USERS_URL,determineParams(params,TITLES_STATES_SERVICE));
		}
		
		public function userFeedsService(params:ParamsBase=null):void
		{
			handleServiceLoading(USERS_URL,determineParams(params,USER_FEEDS_SERVICE));
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function handleServiceLoading(methodString:String, params:ParamsBase=null):void
		{
			super.handleServiceLoading(methodString, params);
			
			var sendQuery:String = methodString;
			var typeQuery:String;
			var method:String = ServiceBase.GET_REQUEST_METHOD;
			
			if(!params)
				return;
			
			switch(type)
			{
				case RECOMMENDATION_SERVICE:
					if(checkForUser()==false)
						return;
					sendQuery = user.recommendationsLink;
					break;
				case TITLES_STATES_SERVICE:
					if(checkForUser()==false)
						return;
					sendQuery = user.titleStatesLink;
					break;
				case USER_FEEDS_SERVICE:
					if(checkForUser()==false)
						return;
					sendQuery = user.feedsLink;
					break;
				default:
					sendQuery = methodString + "/" + userId;
					break;
			}
			
			createLoader(sendQuery, params, _userService_CompleteHandler, method);
		}
		//---------------------------------------------------------------------
		//
		// Private Methods
		//
		//---------------------------------------------------------------------
		/**
		 * @private
		 * Complete Handler Method. 
		 * @param event
		 * 
		 */		
		private function _userService_CompleteHandler(event:Event):void
		{
			var loader:URLLoader = event.target as URLLoader;
			var queryXML:XML = XML(loader.data);
			clearLoader();
			
			if(queryXML=="Timestamp Is Invalid")
				getServerTimeOffset();
			else if(queryXML.Error == undefined)
				formatAndDispatch(queryXML);
			else
				dispatchFault(new ServiceFault(NetflixFaultEvent.API_RESPONSE, queryXML.Error, queryXML.Error.Message));
		}
		
		//---------------------------------------------------------------------
		//
		// Override Methods
		//
		//---------------------------------------------------------------------
		/**
		 * @inheritDoc
		 */		
		override protected function formatAndDispatch(returnedXML:XML):void
		{
			super.formatAndDispatch(returnedXML);
			
			var resultsArray:Array = [];
			var resultNode:XML;
			
			//loop through child nodes and build value objects based on catagory type
			switch(type)
			{
				case RECOMMENDATION_SERVICE:
					for each (resultNode in returnedXML..recommendation)
						resultsArray.push( NetflixXMLUtilV2.handleXMLToCatalogItemVO(resultNode) );
					break;
				case TITLES_STATES_SERVICE:
					for each (resultNode in returnedXML..title_state)
						resultsArray.push( NetflixXMLUtilV2.handleTitleState(resultNode) );
					break;
				case USER_FEEDS_SERVICE:
					for each (resultNode in returnedXML..link)
						resultsArray.push( NetflixXMLUtilV2.handleLink(resultNode) );
					break;
				default:
					user = new NetflixUser();
					//attributes
					user.userId = returnedXML.user_id;
					user.firstName = returnedXML.first_name;
					user.lastName = returnedXML.last_name;
					user.nickName = returnedXML.nickname;
					user.canInstantWatch = Boolean(returnedXML.can_instant_watch);
					user.isAccountOwner = Boolean(returnedXML.is_account_owner);
					user.canInstantWatchOnDevice = Boolean(returnedXML.can_instant_watch_on_device);
					user.accountMaxNumberOfDiscs = int(returnedXML.account_max_number_of_discs);
					//preferred formats
					user.preferredFormats = [];
					for each(var categoryXML:XML in returnedXML..category){
						if(categoryXML.@scheme == NetflixXMLUtilV2.TITLE_FORMAT_SCHEMA)
						{
							var preferredFormat:CategoryItemVO = NetflixXMLUtilV2.handleCategory(categoryXML);
							if(preferredFormat.label=="Blu-ray")
								user.canBlurayWatch = true;
							if(preferredFormat.label=="DVD")
								user.canDvdWatch = true;
							user.preferredFormats.push(preferredFormat.label);
						} else if(categoryXML.@scheme == NetflixXMLUtilV2.MATURITY_LEVEL_SCHEMA)
						{
							user.maxMaturityLevel = NetflixXMLUtilV2.handleCategory(categoryXML).label;
						} else if(categoryXML.@scheme == NetflixXMLUtilV2.LANGUAGES_SCHEMA)
						{
							if(!user.preferredLanguages) user.preferredLanguages = [];
							user.preferredLanguages.push(NetflixXMLUtilV2.handleCategory(categoryXML).label)
						}
					}
					//double check for dvds
					if(user.accountMaxNumberOfDiscs == 0)
					{
						user.canBlurayWatch = false;
						user.canDvdWatch = false;
					}
					//links
					for each(var linksXML:XML in returnedXML..link)
					{
						var rel:String = linksXML.@rel;
						switch(rel)
						{
							case NetflixXMLUtilV2.QUEUES_SCHEMA:
								user.queuesLink = linksXML.@href;
								break;
							case NetflixXMLUtilV2.RENTAL_HISTORY_SCHEMA:
								user.rentalHistoryLink = linksXML.@href;
								break;
							case NetflixXMLUtilV2.RECOMMENDATIONS_SCHEMA:
								user.recommendationsLink = linksXML.@href;
								break;
							case NetflixXMLUtilV2.TITLE_STATES_SCHEMA:
								user.titleStatesLink = linksXML.@href;
								break;
							case NetflixXMLUtilV2.RATINGS_SCHEMA:
								user.ratingsLink = linksXML.@href;
								break;
							case NetflixXMLUtilV2.REVIEWS_SCHEMA:
								user.reviewsLink = linksXML.@href;
								break;
							case NetflixXMLUtilV2.AT_HOME_SCHEMA:
								user.atHomeLink = linksXML.@href;
								break;
							case NetflixXMLUtilV2.FEEDS_SCHEMA:
								user.feedsLink = linksXML.@href;
								break;
						}
					}
					lastNetflixResult = user;
					//store user for later
					if(autoSaveAuthorization)
					{
						lso.data.user = user;
						lso.flush();
					}
					
					dispatchEvent(new UsersResultEvent(UsersResultEvent.USER_RESULT,user));
					return;
					break;
			}
			lastNetflixResult = resultsArray;
			dispatchResult(resultsArray,type, returnedXML);
		}
		
		//---------------------------------------------------------------------
		//
		// No Params Quick Functions
		//
		//---------------------------------------------------------------------
		/**
		 * Gets Recommended Titles.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RECOMMENDATION_RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param startIndex
		 * @param maxResults
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RECOMMENDATION_RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 */		
		public function getRecommendedTitles(startIndex:int=0, maxResults:int=25, expansions:String=null):void
		{
			var params:UserParams = new UserParams();
			params.startIndex = startIndex;
			params.maxResults = maxResults;
			params.expansions = expansions;
			recommendationService(params);
		}
		
		/**
		 * Calls for the user info. Requires that you have already called the 
		 * <code>AccessTokenService.getAccessToken()</code>.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>UserResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @see com.netflix.webapis.events.UsersResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.services.AccessTokenService#getAccessToken()
		 */	
		public function getUserInfo():void
		{
			userInfoService(null);
		}
		
		/**
		 * Gets the title states for a list of titles.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.TITLE_STATE_RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param titles
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#TITLE_STATE_RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 */		
		public function getTitlesStates(titles:Array):void
		{
			var params:UserParams = new UserParams();
			params.titleRefs = titles;
			titleStatesService(params);
		}
		
		public function getUserFeeds():void
		{
			var params:UserParams = new UserParams();
			userFeedsService(params);
		}
	}
}