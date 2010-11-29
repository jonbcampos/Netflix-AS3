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
	import com.netflix.webapis.events.AuthenticationResultEvent;
	import com.netflix.webapis.events.NetflixResultEvent;
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.sampler.stopSampling;
	
	import org.iotashan.oauth.OAuthRequest;
	import org.iotashan.utils.URLEncoding;

	/**
	* Result Event.
	*/	
	[Event(name="result",type="com.netflix.webapis.events.AuthenticationResultEvent")]
	[Event(name="serverTimeComplete",type="com.netflix.webapis.events.NetflixResultEvent")]
	
	/**
	 * Services to Authorize your application with Netflix.
	 * @author jonbcampos
	 * 
	 */	
	public class AuthenticationService extends ServiceBase
	{
		
		public function AuthenticationService(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		private var _urlLoader:URLLoader;
		
		/**
		 * Calls for the token to be able to call the access token service. 
		 * 
		 * @param key Consumer key given by Netflix.
		 * @param secret Consumer secret given by Netflix.
		 * 
		 * @see com.netflix.webapis.events.AuthenticationResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 */		
		public function requestToken(callBackUrl:String=null):void
		{
			this.callBackUrl = callBackUrl;
			//don't get if exists
			if(checkForAuthToken(false)==true)
				return;
			//run if doesn't exist
			_clearLoader();
			_urlLoader = new URLLoader();
			_urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			_urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR,_authenticationService_IOErrorHandler);
			_urlLoader.addEventListener(Event.COMPLETE,_authenticationService_CompleteHandler);
			_urlLoader.load(new URLRequest(_getRequestUrl()));
		}
		
		
		/**
		 * @private
		 * Receives service result and dispatches result event. 
		 * @param event
		 * 
		 */	
		private function _authenticationService_CompleteHandler(event:Event):void
		{
			var loader:URLLoader = event.target as URLLoader;
			var result:String = loader.data as String;
			//_clearLoader();
			var s:Array = String(result).split("&");  
			var array:Array;  
			for each(var item:String in s)  
			{  
				array = item.split("=");
				switch(array[0])
				{
					case "oauth_token":
						oauthToken = array[1];
						break;
					case "oauth_token_secret":
						oauthTokenSecret = array[1];
						break;
					case "application_name":
						applicationName = array[1];
						break;
					case "login_url":
						loginURL = URLEncoding.decode(array[1]);
						break;
				}
			}
			
			authorizationURL = loginURL + "&application_name=" + applicationName + "&oauth_consumer_key=" + consumer.key;
			if(callBackUrl)
				authorizationURL += "&oauth_callback=" + URLEncoding.encode(callBackUrl);
				
			lastNetflixResult = {"token":oauthToken, "tokenSecret":oauthTokenSecret, "applicationName":applicationName, "loginURL":loginURL,"key":consumer.key};
			dispatchEvent(new AuthenticationResultEvent(AuthenticationResultEvent.RESULT, oauthToken, oauthTokenSecret, applicationName, loginURL, authorizationURL, ServiceStorage.getInstance().accessTokenExists));
		}
		
		private function _authenticationService_IOErrorHandler(event:IOErrorEvent):void
		{
			_clearLoader();
			dispatchFault(new ServiceFault(event.type,"Token Request Error",event.text, lastHttpStatusResponse));
		}
		
		/**
		 * @private
		 * Clears our the URLLoader. 
		 * 
		 */		
		private function _clearLoader():void
		{
			if(_urlLoader){
				try{
					_urlLoader.close();
				} catch (e:Error){
					//no stream open
				}
				_urlLoader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
				_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,_authenticationService_IOErrorHandler);
				_urlLoader.removeEventListener(Event.COMPLETE,_authenticationService_CompleteHandler);
				_urlLoader = null;
			}
		}
		
		/**
		 * @private 
		 * Creates the request url.
		 * @return request url
		 * 
		 */		
		private function _getRequestUrl():String
		{
			var reqUrl:String = NETFLIX_BASE_URL + "oauth/request_token";
			var tokenRequest:OAuthRequest = new OAuthRequest(ServiceBase.GET_REQUEST_METHOD,reqUrl,null,consumer);
			var request:String = tokenRequest.buildRequest(SIG_METHOD, OAuthRequest.RESULT_TYPE_URL_STRING, "", timeOffset);
			if(enableTraceStatements)
				trace(request);
			return request;
		}
		
		/**
		 * Calls for an authorization url to authorize this application with a 
		 * user's account. Required to access user account information. There is 
		 * no result to listen to.
		 */		
		public static function getAuthorization():void
		{
			var url:String = ServiceStorage.getInstance().authorizationURL;
			if(url)
				navigateToURL(new URLRequest(url));
			else
				throw new Error("Missing Authorization URL, use the Authentication Service and requestToken() prior to making this call.");
		}
		
		/**
		 * Returns the Authorization URL to run for Authorization. 
		 * @return 
		 * 
		 */		
		public function getAuthorizationURL():String
		{
			return ServiceStorage.getInstance().authorizationURL;
		}
		
		//---------------------------------------------------------------------
		//
		//  Time Loader
		//
		//---------------------------------------------------------------------
		private var _timeLoader:URLLoader;
		
		public function setServerTimeOffset(key:String,secret:String):void
		{
			this.key = key;
			this.secret = secret;
			
			_clearTimeLoader();
			
			_timeLoader = new URLLoader();
			_timeLoader.dataFormat = URLLoaderDataFormat.TEXT;
			_timeLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			_timeLoader.addEventListener(IOErrorEvent.IO_ERROR,_onTimeLoader_IOErrorHandler);
			_timeLoader.addEventListener(Event.COMPLETE,_onTimeLoader_CompleteHandler);
			
			var tokenRequest:OAuthRequest = new OAuthRequest(ServiceBase.GET_REQUEST_METHOD,NETFLIX_BASE_URL+"oauth/clock/time",null,consumer);
			var request:String = tokenRequest.buildRequest(SIG_METHOD, OAuthRequest.RESULT_TYPE_URL_STRING, "", timeOffset);
			
			if(enableTraceStatements)
				trace(request);
			_timeLoader.load(new URLRequest(request));
		}
		
		private function _clearTimeLoader():void
		{
			if(_timeLoader){
				try{
					_timeLoader.close();
				} catch (e:Error){
					//no stream open
				}
				_timeLoader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
				_timeLoader.removeEventListener(IOErrorEvent.IO_ERROR,_onTimeLoader_CompleteHandler);
				_timeLoader.removeEventListener(Event.COMPLETE,_onTimeLoader_IOErrorHandler);
				_timeLoader = null;
			}
		}
		
		private function _onTimeLoader_CompleteHandler(event:Event):void
		{
			var loader:URLLoader = event.target as URLLoader;
			var result:XML = XML(loader.data);
			_clearTimeLoader();
			var serverTime:Number = Number(result.valueOf())*1000;
			var cur:Number = new Date().time;
			timeOffset =  serverTime - cur;
			lastNetflixResult = {"time":serverTime};
			dispatchEvent(new NetflixResultEvent(NetflixResultEvent.SERVER_TIME_COMPLETE, serverTime, null, result));
		}
		
		private function _onTimeLoader_IOErrorHandler(event:IOErrorEvent):void
		{
			_clearTimeLoader();
			dispatchFault(new ServiceFault(event.type,"Server Time Error",event.text, lastHttpStatusResponse));
		}
		
	}
}