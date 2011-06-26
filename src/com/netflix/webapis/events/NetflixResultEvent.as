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
package com.netflix.webapis.events
{
	import flash.events.Event;
	
	/**
	 * Result Event from any of the Netflix Services.
	 * @author jonbcampos
	 * 
	 */
	public class NetflixResultEvent extends Event
	{
		/**
		 * Result Event. 
		 */		
		public static const GENRES_RESULT:String = "genresResult";
		public static const TV_RATINGS_RESULT:String = "tvRatingsResult";
		public static const MPAA_RATINGS_RESULT:String = "mpaaRatingsResult";
		public static const QUEUE_AVAILABILITY_RESULT:String = "queueAvailabilityResult";
		public static const TITLE_FORMATS_RESULT:String = "titleFormatsResult";
		
		public static const PEOPLE_RESULT:String = "peopleResult";
		public static const PERSON_RESULT:String = "personResult";
		public static const FILMOGRAPHY_RESULT:String = "filmographyResult";
		
		public static const DISC_QUEUE_RESULT:String = "discQueueResult";
		public static const INSTANT_QUEUE_RESULT:String = "instantQueueResult";
		public static const UPDATE_DISC_QUEUE_RESULT:String = "updateDiscQueueResult";
		public static const UPDATE_INSTANT_QUEUE_RESULT:String = "updateInstantQueueResult";
		public static const DELETE_DISC_QUEUE_RESULT:String = "deleteDiscQueueResult";
		public static const DELETE_INSTANT_QUEUE_RESULT:String = "deleteInstantQueueResult";
		
		public static const TITLE_RATINGS_RESULT:String = "titleRatingsResult";
		public static const GET_ACTUAL_TITLE_RATINGS_RESULT:String = "getActualTitleRatingsResult";
		public static const SET_ACTUAL_TITLE_RATINGS_RESULT:String = "setActualTitleRatingsResult";
		public static const GET_ACTUAL_RATING_RESULT:String = "getActualRatingResult";
		public static const UPDATE_ACTUAL_RATING_RESULT:String = "updateActualRatingResult";
		public static const PREDICTED_RATING_RESULT:String = "predictedRatingResult";
		
		public static const AT_HOME_RESULT:String = "atHomeResult";
		public static const SHIPPED_RESULT:String = "shippedResult";
		public static const WATCHED_RESULT:String = "watchedResult";
		public static const RETURNED_RESULT:String = "returnedResult";
		
		public static const TOP_100_RESULT:String = "top100Result";
		public static const NEW_RELEASES_RESULT:String = "newReleasesResult";
		public static const NEW_INSTANT_RESULT:String = "newInstantResult";
		public static const FEED_RESULT:String = "feedResult";
		
		public static const AUTOCOMPLETE_RESULT:String = "autoCompleteResult";
		public static const CATALOG_RESULT:String = "catalogResult";
		public static const TITLE_RESULT:String = "titleResult";
		public static const GENRE_RESULT:String = "genreResult";
		public static const ADVANCED_TITLE_RESULT:String = "advancedTitleResult";
		
		public static const RECOMMENDATION_RESULT:String = "recommendationResult";
		public static const TITLES_STATES_RESULT:String = "titleStatesResult";
		public static const USER_FEEDS_RESULT:String = "userFeedsResult";
		
		public static const SERVER_TIME_COMPLETE:String = "serverTimeComplete";
		
		private var _result:Object;
		/**
		 * Returned object in valid value objects and models. 
		 * @return 
		 * 
		 */		
		public function get result():Object
		{
			return _result;
		}
		
		private var _rawXML:XML;
		/**
		 * Returns the raw xml fom netflix. 
		 * @return 
		 * 
		 */		
		public function get rawXML():XML {
			return _rawXML;
		}
		
		private var _url:String;
		/**
		 * URL for this result.
		 * @return 
		 * 
		 */		
		public function get url():String
		{
			return _url;
		}
		
		private var _params:Object;
		/**
		 * Get/Post Params for this request.
		 * @return 
		 * 
		 */		
		public function get params():Object
		{
			return _params;
		}
		
		private var _statusMessage:String;
		/**
		 * Netflix Status Message By HTTP Status Code. 
		 * @return 
		 * 
		 */		
		public function get statusMessage():String
		{
			return _statusMessage;
		}
		
		public function NetflixResultEvent(type:String, result:Object = null, rawXML:XML = null, url:String = null, params:Object = null, statusMessage:String = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			_result = result;
			_rawXML = rawXML;
			_url = url;
			_params = params;
			_statusMessage = statusMessage;
		}
		
		override public function clone():Event
		{
			return new NetflixResultEvent(type, result, rawXML, url, params, statusMessage, bubbles, cancelable);
		}
	}
}