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
	import com.netflix.webapis.ServiceFault;
	
	import flash.events.Event;
	
	/**
	 * Fault Event from any of the Netflix Services.
	 * @author jonbcampos
	 * 
	 */
	public class NetflixFaultEvent extends Event
	{
		/**
		 * Fault Event. 
		 */		
		public static const FAULT:String = "fault";
		/**
		 * Error Event. 
		 */		
		public static const ERROR_EVENT:String = "ErrorEvent";
		/**
		 * API Response Event. 
		 */		
		public static const API_RESPONSE:String  = "API Response";
		/**
		 * XML Loading Notice. 
		 */		
		public static const XML_LOADING:String  = "XML Loading";
		/**
		 * No results notice. 
		 */		
		public static const NO_RESULTS:String  = "No Results";
		/**
		 * Security Error. 
		 */		
		public static const SECURITY_ERROR:String  = "securityError";
		
		private var _fault:ServiceFault;
		/**
		 * Fault Object. 
		 * @return 
		 * 
		 */		
		public function get fault():ServiceFault
		{
			return _fault;
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
		
		/**
		 * Fault Result Event from Netflix API. 
		 * @param type
		 * @param fault
		 * 
		 */		
		public function NetflixFaultEvent(type:String, fault:ServiceFault = null, url:String = null, params:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			_fault = fault;
			_url = url;
			_params = params;
		}
		
		override public function clone():Event
		{
			return new NetflixFaultEvent(type, fault, url, params, bubbles, cancelable);
		}
		
	}
}