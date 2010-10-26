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
package com.netflix.webapis.params
{
	import org.iotashan.utils.URLEncoding;

	/**
	 * Base of Parameters Class.
	 * @author jonbcampos
	 * 
	 */	
	public class ParamsBase
	{
		public function ParamsBase()
		{
		}
		
		//---------------------------------------------------------------------
		//
		// Public Properties
		//
		//---------------------------------------------------------------------
		
		private var _startIndex:uint = 0;
		/**
		 * The zero-based offset into the results of the query. When used with 
		 * the maxResults parameter, you can request successive pages of 
		 * search results.
		 */
		public function get startIndex():uint
		{
			return _startIndex;
		}
		
		public function set startIndex(value:uint):void
		{
			if(value<0) value = 0;
			_startIndex = value;
		}
		
		//---------------------------
		// maxResults
		//---------------------------
		private var _maxResults:uint = 25;
		/**
		 * The maximum number of results to return. 
		 * This number cannot be greater than 100. 
		 * If maxResults is not specified, the default value is 25.
		 */		
		public function get maxResults():uint
		{
			return _maxResults;
		}
		
		public function set maxResults(value:uint):void
		{
			if(value>100) value = 100;
			if(value<1) value = 1;
			_maxResults = value;
		}
		
		/**
		 * Netflix ID, similar to: http://api.netflix.com/catalog/titles/movies/xxxxxxxxx/.
		 */		
		public var netflixId:String;
		
		/**
		 * Type of service. 
		 */		
		public var type:String = null;
		/**
		 * Parameter that will expand sections of the response to prevent the need for n additional calls.
		 * Multiple selections can be specified by using a comma delimiter. 
		 */		
		public var expansions:String;
		
		public var filter:String;
		
		public var orderBy:String;
		
		//---------------------------------------------------------------------
		//
		// Public Methods
		//
		//---------------------------------------------------------------------
		public function toOdataString():String
		{
			var returnString:String = "";
			if(startIndex) returnString += "&$skip=" + URLEncoding.encode(startIndex.toString());
			if(maxResults) returnString += "&$top=" + URLEncoding.encode(maxResults.toString());
			if(expansions) returnString += "&$expand=" + URLEncoding.encode(expansions);
			if(filter) returnString += "&$filter=" + URLEncoding.encode(filter);
			if(orderBy) returnString += "&$orderby=" + URLEncoding.encode(orderBy);
			returnString += "&$inlinecount=allpages";
			return returnString;
		}
		/**
		 * Creates the string of parameters to send to Netflix.
		 * @return string of parameters
		 * 
		 */
		public function toString():String
		{
			var returnString:String = "";
			if(startIndex) returnString += "&start_index=" + escape(startIndex.toString());
			if(maxResults) returnString += "&max_results=" + escape(maxResults.toString());
			if(expansions) returnString += "&expand=" + expansions;
			return returnString;
		}
		/**
		 * Creates an object the OAuthRequest object needs to generate the signature for GET Methods.
		 * @return object with key-value pairs
		 * 
		 */
		public function toObject():Object
		{
			var o:Object = {};
			o.start_index = startIndex;
			o.max_results = maxResults;
			o.oauth_version = "1.0";
			if(expansions)
				o.expand = expansions;
			return o;
		}
		/**
		 * Creates an object the OAuthRequest object needs to generate the signature for POST Methods.
		 * @return object with key-value pairs
		 * 
		 */
		public function toPostObject():Object
		{
			var o:Object = {};
			o.start_index = startIndex;
			o.max_results = maxResults;
			o.oauth_version = "1.0";
			if(expansions)
				o.expand = expansions;
			return o;
		}
		
		/**
		 * Returns the defaultType for this service. 
		 * @return 
		 * 
		 */		
		public function get defaultType():String
		{
			return null;
		}

	}
}