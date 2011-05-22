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
	import com.netflix.webapis.events.AccessTokenResultEvent;
	import com.netflix.webapis.events.NetflixResultEvent;
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	import org.iotashan.oauth.OAuthRequest;
	import org.iotashan.oauth.OAuthToken;

	/**
	* Result Event.
	*/	
	[Event(name="result",type="com.netflix.webapis.events.AccessTokenResultEvent")]
	
	/**
	 * Service to requests an Access Token with Netflix to connect to a 
	 * specific user's account.
	 * @author jonbcampos
	 * 
	 */	
	public class AccessTokenService extends ServiceBase
	{
		public function AccessTokenService()
		{
			super();
		}
		
		private var _urlLoader:URLLoader;
		
		/**
		 * Requests an Access Token with Netflix to connect to a 
		 * specific user's account. Returns the OAuth Token and 
		 * the user's id that this application is authenticated for. 
		 * 
		 * @see com.netflix.webapis.events.AccessTokenResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 */		
		public function getAccessToken():void
		{
			_clearLoader();
			if(!checkForAuthToken())
				return;
			//get access token
			_urlLoader = new URLLoader();
			_urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			_urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			_urlLoader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			_urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR,_accessTokenService_IOErrorHandler);
			_urlLoader.addEventListener(Event.COMPLETE,_accessTokenService_CompleteHandler);
			
			var requestToken:OAuthToken = new OAuthToken(oauthToken,oauthTokenSecret);
			var tokenRequest:OAuthRequest = new OAuthRequest(ServiceBase.GET_REQUEST_METHOD,NETFLIX_BASE_URL+"oauth/access_token",null,consumer,requestToken);
			var request:String = createRequestString(tokenRequest);
			
			if(enableTraceStatements)
				trace(request);
			_urlLoader.load(new URLRequest(request));
		}
		
		/**
		 * @private
		 * Receives service result and dispatches result event. 
		 * @param event
		 * 
		 */		
		private function _accessTokenService_CompleteHandler(event:Event):void
		{
			var loader:URLLoader = event.target as URLLoader;
			var result:String = loader.data as String;
			if(result=="Timestamp Is Invalid")
			{
				addEventListener(NetflixResultEvent.SERVER_TIME_COMPLETE, _onServerTimeOffset_CompleteHandler);
				getServerTimeOffset();
				return;
			}
			_clearLoader();
			var a:Array = String(result).split("&");
			var s:Array;
			var o:Object = {};
			for each(var item:String in a)
			{
				s = item.split("=");
				o[s[0]] = s[1];
			}
			
			token = o.oauth_token as String;
			tokenSecret = o.oauth_token_secret as String;
			userId = o.user_id;
			if(autoSaveAuthorization)
			{
				lso.data.accessToken = accessToken;
				lso.data.userId = userId;
				lso.flush();
			}
			
			lastNetflixResult = {"accessToken":accessToken,"userId":userId};
			if(hasEventListener(AccessTokenResultEvent.RESULT))
				dispatchEvent(new AccessTokenResultEvent(AccessTokenResultEvent.RESULT,accessToken,userId));
		}
		
		private function _clearLoader():void
		{
			if(_urlLoader){
				try{
					_urlLoader.close();
				} catch (e:Error){
					//no stream open
				}
				_urlLoader.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
				_urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
				_urlLoader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
				_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,_accessTokenService_IOErrorHandler);
				_urlLoader.removeEventListener(Event.COMPLETE,_accessTokenService_CompleteHandler);
				_urlLoader = null;
			}
		}
		
		/**
		 * @private
		 * Dispatches fault event.  
		 * @param event
		 * 
		 */		
		private function _accessTokenService_IOErrorHandler(event:IOErrorEvent):void
		{
			_clearLoader();
			if(httpStatusResponse && httpStatusResponse=="API Fault, Invalid Signature." && isNaN(timeOffset))
			{
				addEventListener(NetflixResultEvent.SERVER_TIME_COMPLETE, _onServerTimeOffset_CompleteHandler);
				getServerTimeOffset();
				return;
			}
			dispatchFault(new ServiceFault(event.type,"Access Token Error",event.text, httpStatusResponse, httpStatus));
		}
		
		private function _onServerTimeOffset_CompleteHandler(event:NetflixResultEvent):void
		{
			removeEventListener(NetflixResultEvent.SERVER_TIME_COMPLETE, _onServerTimeOffset_CompleteHandler);
			getAccessToken();
		}
		
	}
}