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
		public static const RESULT:String = "result";
		
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
		
		private var _serviceResultType:String;
		/**
		 * Service Result Type. 
		 * @return 
		 * 
		 */		
		public function get serviceResultType():String
		{
			return _serviceResultType;
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
		
		public function NetflixResultEvent(type:String, result:Object = null, serviceResultType:String = null, rawXML:XML = null, url:String = null, params:Object = null, statusMessage:String = null)
		{
			super(type);
			_result = result;
			_serviceResultType = serviceResultType;
			_rawXML = rawXML;
			_url = url;
			_params = params;
			_statusMessage = statusMessage;
		}
		
		override public function clone():Event
		{
			return new NetflixResultEvent(type, result, serviceResultType, rawXML, url, params, statusMessage);
		}
	}
}