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
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
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
		public function AccessTokenService(target:IEventDispatcher=null)
		{
			super(target);
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
			if(checkForAccessToken(false))
				return;
			_urlLoader = new URLLoader();
			_urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR,_accessTokenService_IOErrorHandler);
			_urlLoader.addEventListener(Event.COMPLETE,_accessTokenService_CompleteHandler);
			
			var requestToken:OAuthToken = new OAuthToken(oauthToken,oauthTokenSecret);
			var tokenRequest:OAuthRequest = new OAuthRequest(ServiceBase.GET_REQUEST_METHOD,NETFLIX_BASE_URL+"oauth/access_token",null,consumer,requestToken);
			var request:String = tokenRequest.buildRequest(SIG_METHOD, OAuthRequest.RESULT_TYPE_URL_STRING, "", timeOffset);
			
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
			dispatchFault(new ServiceFault(event.type,"Access Token Error",event.text));
		}
		
	}
}