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
	import com.netflix.webapis.params.ParamsBase;
	import com.netflix.webapis.ServiceFault;
	import com.netflix.webapis.vo.CategoryItem;
	import com.netflix.webapis.events.NetflixFaultEvent;
	import com.netflix.webapis.events.NetflixResultEvent;
	import com.netflix.webapis.xml.NetflixXMLUtil;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	import org.iotashan.oauth.OAuthRequest;

	/**
	 * Categories Service to retrieve category information. 
	 * @author jonbcampos
	 * 
	 */	
	public class CategoriesService extends ServiceBase
	{
		public function CategoriesService(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		//---------------------------------------------------------------------
		//
		// Public Static Consts
		//
		//---------------------------------------------------------------------
		public static const GENRES_SERVICE:String = "genres";
		public static const TV_RATINGS_SERVICE:String = "tvRatings";
		public static const MPAA_RATINGS_SERVICE:String = "mpaaRatings";
		public static const QUEUE_AVAILABILITY_SERVICE:String = "queueAvailability";
		public static const TITLE_FORMATS_SERVICE:String = "titleFormats";
		
		//---------------------------------------------------------------------
		//
		// Protected Static Consts
		//
		//---------------------------------------------------------------------
		protected static const GENRES_URL:String = NETFLIX_BASE_URL+"categories/genres";
		protected static const TV_RATINGS_URL:String = NETFLIX_BASE_URL+"categories/tv_ratings";
		protected static const MPAA_RATINGS_URL:String = NETFLIX_BASE_URL+"categories/mpaa_ratings";
		protected static const QUEUE_AVAILABILITY_URL:String = NETFLIX_BASE_URL+"categories/queue_availability";
		protected static const TITLE_FORMATS_URL:String = NETFLIX_BASE_URL+"categories/title_formats";
		
		//---------------------------------------------------------------------
		//
		// Public Methods
		//
		//---------------------------------------------------------------------
		/**
		 * @inheritDoc
		 */
		override public function send(parameters:ParamsBase=null):void
		{
			super.send(parameters);
			
			switch(type)
			{
				case GENRES_SERVICE:
					genresService(parameters);
				break;
				case TV_RATINGS_SERVICE:
					tvRatingsService(parameters);
				break;
				case MPAA_RATINGS_SERVICE:
					mpaaRatingsService(parameters);
				break;
				case QUEUE_AVAILABILITY_SERVICE:
					queueAvailabilityService(parameters);
				break;
				case TITLE_FORMATS_SERVICE:
					titleFormatsService(parameters);
				break;
			}
		}
		
		/**
		 * Retrieves all the different types of genres.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 *  
		 * @param params
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.vo.CategoryItem
		 */	
		public function genresService(params:ParamsBase=null):void
		{
			handleServiceLoading(GENRES_URL,determineParams(params,GENRES_SERVICE));
		}
		
		/**
		 * Retrieves all the different types of tv ratings.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 *  
		 * @param params
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.vo.CategoryItem
		 */
		public function tvRatingsService(params:ParamsBase=null):void
		{
			handleServiceLoading(TV_RATINGS_URL,determineParams(params,TV_RATINGS_SERVICE));
		}
		
		/**
		 * Retrieves all the different types of mpaa ratings.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 *  
		 * @param params
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.vo.CategoryItem
		 */
		public function mpaaRatingsService(params:ParamsBase=null):void
		{
			handleServiceLoading(MPAA_RATINGS_URL,determineParams(params,MPAA_RATINGS_SERVICE));
		}
		
		/**
		 * Retrieves all the different types of queue availability types.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 *  
		 * @param params
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.vo.CategoryItem
		 */
		public function queueAvailabilityService(params:ParamsBase=null):void
		{
			handleServiceLoading(QUEUE_AVAILABILITY_URL,determineParams(params,QUEUE_AVAILABILITY_SERVICE));
		}
		
		/**
		 * Retrieves all the different types of title formats.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 *  
		 * @param params
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.vo.CategoryItem
		 */
		public function titleFormatsService(params:ParamsBase=null):void
		{
			handleServiceLoading(TITLE_FORMATS_URL,determineParams(params,TITLE_FORMATS_SERVICE));
		}
		
		/**
		 * @inheritDoc
		 */	
		override protected function handleServiceLoading(methodString:String, params:ParamsBase = null):void
		{
			super.handleServiceLoading(methodString, params);
			
			var sendQuery:String = methodString;
			var typeQuery:String;
			
			if(checkForConsumerKey()==false)
				return;
			
			createLoader(sendQuery, params, _categoriesService_CompleteHandler);
		}
		
		private function _categoriesService_CompleteHandler(event:Event):void
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
				case GENRES_SERVICE:
				case MPAA_RATINGS_SERVICE:
				case TV_RATINGS_SERVICE:
				case TITLE_FORMATS_SERVICE:
				case QUEUE_AVAILABILITY_SERVICE:
					for each(resultNode in returnedXML..category_item){
						resultsArray.push( NetflixXMLUtil.handleCategory(resultNode) );
					}
				break;
			}
			if(resultsArray==null || resultsArray.length==0){
				dispatchFault(new ServiceFault(NetflixFaultEvent.API_RESPONSE, "Parameter Errors", "No valid 'expand' option was selected."));
				return;
			}
			lastNetflixResult = resultsArray;
			dispatchResult(resultsArray,type,returnedXML);
		}
		
		//---------------------------------------------------------------------
		//
		// No Params Quick Functions
		//
		//---------------------------------------------------------------------
		/**
		 * Retrieves all the different types of genres.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 *  
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.vo.CategoryItem
		 */	
		public function getGenres():void
		{
			genresService();
		}
		
		/**
		 * Retrieves all the different types of tv ratings.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 *  
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.vo.CategoryItem
		 */
		public function getTvRatings():void
		{
			tvRatingsService();
		}
		
		/**
		 * Retrieves all the different types of mpaa ratings.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 *  
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.vo.CategoryItem
		 */
		public function getMpaaRatings():void
		{
			mpaaRatingsService();
		}
		
		/**
		 * Retrieves all the different types of queue availability types.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 *  
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.vo.CategoryItem
		 */
		public function getQueueAvailabilities():void
		{
			queueAvailabilityService();
		}
		
		/**
		 * Retrieves all the different types of title formats.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 *  
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.vo.CategoryItem
		 */
		public function getTitleFormats():void
		{
			titleFormatsService();
		}
	}
}