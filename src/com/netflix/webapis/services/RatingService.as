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
	import com.netflix.webapis.models.RatingsItemModel;
	import com.netflix.webapis.params.ParamsBase;
	import com.netflix.webapis.params.RatingParams;
	import com.netflix.webapis.vo.CategoryItem;
	import com.netflix.webapis.xml.NetflixXMLUtil;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	
	/**
	 * Rating Services under the <i>Rating</i> category. 
	 * @author jonbcampos
	 * 
	 */	
	public class RatingService extends ServiceBase
	{
		public function RatingService(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		//---------------------------------------------------------------------
		//
		// Constants
		//
		//---------------------------------------------------------------------
		protected static const TITLES_PART:String = "title";
		protected static const ACTUAL_RATINGS_PART:String = TITLES_PART+"/actual";
		protected static const PREDICTED_RATINGS_PART:String = TITLES_PART+"/predicted";
		
		public static const TITLE_RATINGS_SERVICE:String = "titleRatings";
		public static const GET_ACTUAL_TITLE_RATINGS_SERVICE:String = "getActualTitleRatings";
		public static const SET_ACTUAL_TITLE_RATINGS_SERVICE:String = "setActualTitleRatings";
		
		public static const GET_ACTUAL_RATING_SERVICE:String = "getActualRating";
		public static const UPDATE_ACTUAL_RATING_SERVICE:String = "updateActualRating";
		
		public static const PREDICTED_RATING_SERVICE:String = "predictedRating";
		
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
				case TITLE_RATINGS_SERVICE:
					titleRatingsService( parameters );
					break;
				case GET_ACTUAL_TITLE_RATINGS_SERVICE:
					getActualTitleRatingsService( parameters );
					break;
				case SET_ACTUAL_TITLE_RATINGS_SERVICE:
					setActualTitleRatingsService( parameters );
					break;
				case GET_ACTUAL_RATING_SERVICE:
					getActualRatingService( parameters );
					break;
				case PREDICTED_RATING_SERVICE:
					getPredictedRatingService( parameters );
					break;
			}
		}
		
		/**
		 * Returns a subscriber's rating for a title.
		 * 
		 * @param params
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.RatingsItemModel
		 */		
		public function titleRatingsService(params:ParamsBase = null):void
		{
			handleServiceLoading(user.ratingsLink, determineParams(params,TITLE_RATINGS_SERVICE));
		}
		
		/**
		 * Returns a subscriber's rating for a title.
		 * 
		 * @param params
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.RatingsItemModel
		 */		
		public function getActualTitleRatingsService(params:ParamsBase = null):void
		{
			handleServiceLoading(user.ratingsLink, determineParams(params,GET_ACTUAL_TITLE_RATINGS_SERVICE));
		}
		
		/**
		 * Creates/Updates a new rating for a subscriber.
		 * 
		 * @param params
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.RatingsItemModel
		 */		
		public function setActualTitleRatingsService(params:ParamsBase = null):void
		{
			handleServiceLoading(user.ratingsLink, determineParams(params,SET_ACTUAL_TITLE_RATINGS_SERVICE));
		}
		
		/**
		 * Returns the actual ratings for a subscriber.
		 * 
		 * @param params
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.RatingsItemModel
		 */		
		public function getActualRatingService(params:ParamsBase = null):void
		{
			handleServiceLoading(user.ratingsLink, determineParams(params,GET_ACTUAL_RATING_SERVICE));
		}
		
		/**
		 * Returns the predicted ratings for a subscriber.
		 *  
		 * @param params
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.RatingsItemModel
		 */		
		public function getPredictedRatingService(params:ParamsBase = null):void
		{
			handleServiceLoading(user.ratingsLink, determineParams(params,PREDICTED_RATING_SERVICE));
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function handleServiceLoading(methodString:String, params:ParamsBase=null) : void
		{
			super.handleServiceLoading(methodString, params);
			
			var sendQuery:String = methodString;
			var typeQuery:String;
			var method:String = ServiceBase.GET_REQUEST_METHOD;
			
			if(checkForUser()==false)
				return;
			
			if(!params)
				return;
			
			switch(type)
			{
				case TITLE_RATINGS_SERVICE:
					sendQuery += "/" + TITLES_PART;
					break;
				case GET_ACTUAL_RATING_SERVICE:
					sendQuery += "/" +ACTUAL_RATINGS_PART;
					break;
				case SET_ACTUAL_TITLE_RATINGS_SERVICE:
					method = ServiceBase.PUT_REQUEST_METHOD;
					sendQuery += "/" +ACTUAL_RATINGS_PART;
					break;
				case GET_ACTUAL_TITLE_RATINGS_SERVICE:
					if(!(params is RatingParams))
						return;
					sendQuery += "/" +ACTUAL_RATINGS_PART+"/"+RatingParams(params).ratingItem.id;
					break;
				case PREDICTED_RATING_SERVICE:
					sendQuery += "/" + PREDICTED_RATINGS_PART;
					break;
			}
			
			createLoader(sendQuery, params, _ratingService_CompleteHandler, method);
		}
		
		private function _ratingService_CompleteHandler(event:Event):void
		{
			var loader:URLLoader = event.target as URLLoader;
			var queryXML:XML = XML(loader.data);
			
			if(queryXML.Error == undefined)
				formatAndDispatch(queryXML);
			else
				dispatchFault(new ServiceFault(NetflixFaultEvent.API_RESPONSE, queryXML.Error, queryXML.Error.Message));
			clearLoader();
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function formatAndDispatch(returnedXML:XML) : void
		{
			super.formatAndDispatch(returnedXML);
			
			var resultsArray:Array = [];
			var resultNode:XML;
			
			//loop through child nodes and build value objects based on catagory type
			switch(type)
			{
				case TITLE_RATINGS_SERVICE:
				case GET_ACTUAL_TITLE_RATINGS_SERVICE:
				case GET_ACTUAL_RATING_SERVICE:
				case PREDICTED_RATING_SERVICE:
					for each (resultNode in returnedXML..ratings_item)
					{
						resultsArray.push( NetflixXMLUtil.handleXMLToCatalogItemModel(resultNode, new RatingsItemModel() ) );
					}
					break;
				case SET_ACTUAL_TITLE_RATINGS_SERVICE:
					lastNetflixResult = RatingParams(request).rating;
					dispatchResult(RatingParams(request).rating,type, returnedXML);
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
		 * Accept Netflix Models or NetflixIds to pull ratings for the selected titles.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param titles
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.RatingsItemModel
		 */		
		public function getTitlesRatings(titles:Array, expansions:String=null):void
		{
			var params:RatingParams = new RatingParams();
			params.titleRefs = titles;
			params.expansions = expansions;
			titleRatingsService(params);
		}
		
		/**
		 * Returns a subscriber's rating for a title.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param titles
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.RatingsItemModel
		 */	
		public function getActualTitleRatings(item:RatingsItemModel):void
		{
			var params:RatingParams = new RatingParams();
			params.ratingItem = item;
			getActualTitleRatingsService(params);
		}
		
		/**
		 * Creates/Updates a new rating for a subscriber.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param titles
		 * @param rating
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.RatingsItemModel
		 */	
		public function setActualTitleRatings(title:CatalogItemModel, rating:int):void
		{
			var params:RatingParams = new RatingParams();
			params.rating = rating;
			params.titleRef = title;
			setActualTitleRatingsService(params);
		}
		
		/**
		 * Returns a subscriber's rating for a title.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param ratingItem
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.RatingsItemModel
		 */	
		public function getActualRating(titles:Array):void
		{
			var params:RatingParams = new RatingParams();
			params.titleRefs = titles;
			getActualRatingService(params);
		}
		
		/**
		 * Returns the predicted ratings for a subscriber.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param titles
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.RatingsItemModel
		 */	
		public function getPredictedRating(titles:Array):void
		{
			var params:RatingParams = new RatingParams();
			params.titleRefs = titles;
			getPredictedRatingService(params);
		}
	}
}