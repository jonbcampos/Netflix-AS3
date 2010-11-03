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
	import com.netflix.webapis.events.NetflixResultEvent;
	import com.netflix.webapis.models.CatalogItemModel;
	import com.netflix.webapis.params.ParamsBase;
	import com.netflix.webapis.params.RentalHistoryParams;
	import com.netflix.webapis.xml.NetflixXMLUtil;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequestMethod;
	
	/**
	 * Tracking Services under the <i>Tracking</i> category. 
	 * @author jonbcampos
	 * 
	 */	
	public class RentalHistoryService extends ServiceBase
	{
		public function RentalHistoryService(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		//---------------------------------------------------------------------
		//
		// Constants
		//
		//---------------------------------------------------------------------
		protected static const SHIPPED_URL_PART:String = "shipped";
		protected static const WATCHED_URL_PART:String = "watched";
		protected static const RETURNED_URL_PART:String = "returned";
		
		public static const AT_HOME_SERVICE:String = "atHome";
		public static const SHIPPED_SERVICE:String = "shipped";
		public static const WATCHED_SERVICE:String = "watched";
		public static const RETURNED_SERVICE:String = "returned";
		
		public static const GET_USER_REVIEWS_SERVICE:String = "getReviews";
		//---------------------------------------------------------------------
		//
		// Public Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override public function send(parameters:ParamsBase=null) : void
		{
			super.send(parameters);
			
			switch(type)
			{
				case AT_HOME_SERVICE:
					atHomeService( parameters );
					break;
				case SHIPPED_SERVICE:
					shippedService( parameters );
					break;
				case WATCHED_SERVICE:
					watchedService( parameters );
					break;
				case RETURNED_SERVICE:
					returnedService( parameters );
					break;
				case GET_USER_REVIEWS_SERVICE:
					reviewsService( parameters );
					break;
			}
		}
		
		/**
		 * Returns a list of titles that have been shipped to a subscriber's 
		 * home and not yet returned to Netflix (that is, the discs have 
		 * not been received at a Netflix distribution center). When the 
		 * distribution center receives a disc, the users/userID/at_home 
		 * entry for the disc is purged.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param params
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */		
		public function atHomeService(params:ParamsBase=null):void
		{
			handleServiceLoading(user.atHomeLink, determineParams(params, AT_HOME_SERVICE));
		}
		
		/**
		 * These resources return a list of titles that reflect a 
		 * subscriber's rental history, specifically the items 
		 * shiped from Netflix. The response 
		 * results are sorted by each title's entry date into 
		 * each list. Note that shipped titles are not purged 
		 * from the user's rental history after they are received 
		 * or returned.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param params
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */
		public function shippedService(params:ParamsBase=null):void
		{
			handleServiceLoading(user.rentalHistoryLink+"/"+SHIPPED_URL_PART, determineParams(params, SHIPPED_SERVICE));
		}
		
		/**
		 * These resources return a list of titles that reflect a 
		 * subscriber's rental history, specifically the items 
		 * watched on Netflix home and instant. The response 
		 * results are sorted by each title's entry date into 
		 * each list.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param params
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */
		public function watchedService(params:ParamsBase=null):void
		{
			handleServiceLoading(user.rentalHistoryLink+"/"+WATCHED_URL_PART, determineParams(params, WATCHED_SERVICE));
		}
		
		/**
		 * These resources return a list of titles that reflect a 
		 * subscriber's rental history, specifically the items 
		 * returned to Netflix. The response results are 
		 * sorted by each title's entry date into each list.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param params
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */
		public function returnedService(params:ParamsBase=null):void
		{
			handleServiceLoading(user.rentalHistoryLink+"/"+RETURNED_URL_PART, determineParams(params, RETURNED_SERVICE));
		}
		
		/**
		 * This resource returns a subscriber's reviews and related title URLs.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param params
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.ReviewItemModel
		 */		
		public function reviewsService(params:ParamsBase=null):void
		{
			handleServiceLoading(user.reviewsLink, determineParams(params, GET_USER_REVIEWS_SERVICE));
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function handleServiceLoading(methodString:String, params:ParamsBase=null) : void
		{
			super.handleServiceLoading(methodString, params);
			
			var sendQuery:String = methodString;
			var typeQuery:String;
			var method:String = URLRequestMethod.GET;
			
			if(checkForUser()==false)
				return;
			
			if(!params)
				return;
			
			createLoader(sendQuery, params, _rentalHistoryService_CompleteHandler, method);
		}
		
		/**
		 * @private
		 * Complete Handler. 
		 * @param event
		 * 
		 */		
		private function _rentalHistoryService_CompleteHandler(event:Event):void
		{
			var loader:URLLoader = event.target as URLLoader;
			var queryXML:XML = XML(loader.data);
			
			if(queryXML.Error == undefined)
				formatAndDispatch(queryXML);
			else
				dispatchFault(new ServiceFault(NetflixFaultEvent.API_RESPONSE, queryXML.Error, queryXML.Error.Message));
			clearLoader();
		}
		
		override protected function formatAndDispatch(returnedXML:XML) : void
		{
			super.formatAndDispatch(returnedXML);
			
			var resultsArray:Array = [];
			var resultNode:XML;
			
			switch(type)
			{
				case AT_HOME_SERVICE:
					for each(resultNode in returnedXML..at_home_item)
						resultsArray.push( NetflixXMLUtil.handleXMLToCatalogItemModel(resultNode) );
					break;
				case SHIPPED_SERVICE:
				case WATCHED_SERVICE:
				case RETURNED_SERVICE:
					for each(resultNode in returnedXML..rental_history_item)
						resultsArray.push( NetflixXMLUtil.handleXMLToCatalogItemModel(resultNode) );
					break;
				case GET_USER_REVIEWS_SERVICE:
					for each(resultNode in returnedXML..review)
						resultsArray.push( NetflixXMLUtil.handleReviewNode(resultNode) );
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
		 * Returns a list of titles that have been shipped to a subscriber's 
		 * home and not yet returned to Netflix (that is, the discs have 
		 * not been received at a Netflix distribution center). When the 
		 * distribution center receives a disc, the users/userID/at_home 
		 * entry for the disc is purged.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param sinceDate Filters returned items, allowing through only 
		 * those items with updated dates greater than or equal to the 
		 * passed value of 'sinceDate'.
		 * 
		 * @param startIndex The zero-based offset into the results for 
		 * the query. Use this parameter with max_results to request 
		 * successive pages of search results.
		 * 
		 * @param maxResults The maximum number of results to return. 
		 * This number cannot be greater than 500. If max_results is 
		 * not specified, the default value is 25.
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */
		public function getAtHomeItems(sinceDate:Date=null, startIndex:int=0, maxResults:int=25, expansions:String=null):void
		{
			var params:RentalHistoryParams = new RentalHistoryParams();
			params.updatedMin = sinceDate;
			params.startIndex = startIndex;
			params.maxResults = maxResults;
			params.expansions = expansions;
			atHomeService(params);
		}
		
		/**
		 * These resources return a list of titles that reflect a 
		 * subscriber's rental history, specifically the items 
		 * shiped from Netflix. The response 
		 * results are sorted by each title's entry date into 
		 * each list. Note that shipped titles are not purged 
		 * from the user's rental history after they are received 
		 * or returned.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param sinceDate Filters returned items, allowing through only 
		 * those items with updated dates greater than or equal to the 
		 * passed value of 'sinceDate'.
		 * 
		 * @param startIndex The zero-based offset into the results for 
		 * the query. Use this parameter with max_results to request 
		 * successive pages of search results.
		 * 
		 * @param maxResults The maximum number of results to return. 
		 * This number cannot be greater than 500. If max_results is 
		 * not specified, the default value is 25.
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */
		public function getShippedItems(sinceDate:Date=null, startIndex:int=0, maxResults:int=25, expansions:String=null):void
		{
			var params:RentalHistoryParams = new RentalHistoryParams();
			params.updatedMin = sinceDate;
			params.startIndex = startIndex;
			params.maxResults = maxResults;
			params.expansions = expansions;
			shippedService(params);
		}
		
		/**
		 * These resources return a list of titles that reflect a 
		 * subscriber's rental history, specifically the items 
		 * watched on Netflix home and instant. The response 
		 * results are sorted by each title's entry date into 
		 * each list.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param sinceDate Filters returned items, allowing through only 
		 * those items with updated dates greater than or equal to the 
		 * passed value of 'sinceDate'.
		 * 
		 * @param startIndex The zero-based offset into the results for 
		 * the query. Use this parameter with max_results to request 
		 * successive pages of search results.
		 * 
		 * @param maxResults The maximum number of results to return. 
		 * This number cannot be greater than 500. If max_results is 
		 * not specified, the default value is 25.
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */
		public function getWatchedItems(sinceDate:Date=null, startIndex:int=0, maxResults:int=25, expansions:String=null):void
		{
			var params:RentalHistoryParams = new RentalHistoryParams();
			params.updatedMin = sinceDate;
			params.startIndex = startIndex;
			params.maxResults = maxResults;
			params.expansions = expansions;
			watchedService(params);
		}
		
		/**
		 * These resources return a list of titles that reflect a 
		 * subscriber's rental history, specifically the items 
		 * returned to Netflix. The response results are 
		 * sorted by each title's entry date into each list.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param sinceDate Filters returned items, allowing through only 
		 * those items with updated dates greater than or equal to the 
		 * passed value of 'sinceDate'.
		 * 
		 * @param startIndex The zero-based offset into the results for 
		 * the query. Use this parameter with max_results to request 
		 * successive pages of search results.
		 * 
		 * @param maxResults The maximum number of results to return. 
		 * This number cannot be greater than 500. If max_results is 
		 * not specified, the default value is 25.
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */
		public function getReturnedItems(sinceDate:Date=null, startIndex:int=0, maxResults:int=25, expansions:String=null):void
		{
			var params:RentalHistoryParams = new RentalHistoryParams();
			params.updatedMin = sinceDate;
			params.startIndex = startIndex;
			params.maxResults = maxResults;
			params.expansions = expansions;
			returnedService(params);
		}
		
		/**
		 * This resource returns a subscriber's reviews and related title URLs.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.ReviewItemModel
		 */	
		public function getReviewedItems():void
		{
			reviewsService();
		}
	}
}