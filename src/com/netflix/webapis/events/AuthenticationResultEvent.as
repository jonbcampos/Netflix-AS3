/**
 * Copyright (c) 2009 Netflix-Flex_API Contributors.
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
	 * Result Event from the <code>AuthenticationService</code>.
	 * 
	 * @author jonbcampos
	 * 
	 * @see com.netflix.webapis.authenticate.AuthenticationService
	 */	
	public class AuthenticationResultEvent extends Event
	{
		public static const RESULT:String = "result";
		
		private var _token:String;
		/**
		 * Token returned from the <code>AccessTokenService.getAccessToken()</code> 
		 * and/or <code>AuthenticationService.requestToken()</code>.
		 * 
		 * @see com.netflix.webapis.services.AuthenticationService#requestToken()
		 * @see com.netflix.webapis.services.AccessTokenService#getAccessToken()
		 */	
		public function get token():String
		{
			return _token;
		}

		private var _tokenSecret:String;
		/**
		 * Token Secret returned from the <code>AccessTokenService.getAccessToken()</code> 
		 * and/or <code>AuthenticationService.requestToken()</code>.
		 * 
		 * @see com.netflix.webapis.services.AuthenticationService#requestToken()
		 * @see com.netflix.webapis.services.AccessTokenService#getAccessToken()
		 */	
		public function get tokenSecret():String
		{
			return _tokenSecret;
		}

		private var _applicationName:String;
		/**
		 * Application Name returned from the <code>AuthenticationService.requestToken()</code> call.
		 * 
		 * @see com.netflix.webapis.services.AuthenticationService#requestToken()
		 */	
		public function get applicationName():String
		{
			return _applicationName;
		}

		private var _loginURL:String;
		/**
		 * Login URL returned from the <code>AuthenticationService.requestToken()</code> call.
		 * 
		 * @see com.netflix.webapis.services.AuthenticationService#requestToken()
		 */	
		public function get loginURL():String
		{
			return _loginURL;
		}

		private var _authorizationURL:String;
		/**
		 * Authentication URL returned from the <code>AuthenticationService.requestToken()</code> call. 
		 * This is what is used to authorize your application to a user for user information access.
		 * 
		 * <p>To have the user authorize your app to access their account you need to invoke the 
		 * <code>AuthenticationService.getAuthorization()</code> function. This will open up a new 
		 * window where they will authorize your app. This one needs to be done once or until the
		 * user removes your app from the authorized list.</p>
		 * 
		 * @see com.netflix.webapis.services.AuthenticationService#requestToken()
		 * @see com.netflix.webapis.services.AuthenticationService#getAuthorization()
		 * */
		public function get authorizationURL():String
		{
			return _authorizationURL;
		}

		private var _accessTokenExists:Boolean = false;
		/**
		 * Boolean to specify if the access token already exists and is available for use.
		 * 
		 * <p>If the access token exists you can immediately get the user information. If 
		 * it doesn't then you need to call for the access token before calling for the
		 * user information.</p>
		 * 
		 * @return 
		 * 
		 */             
		public function get accessTokenExists():Boolean
		{
			return _accessTokenExists;
		}
		
		public function AuthenticationResultEvent(type:String, token:String, tokenSecret:String, applicationName:String, loginURL:String, authorizationURL:String, accessTokenExists:Boolean, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_token = token;
			_tokenSecret = tokenSecret;
			_applicationName = applicationName;
			_loginURL = loginURL;
			_authorizationURL = authorizationURL;
			_accessTokenExists = accessTokenExists;
		}
		
		override public function clone() : Event
		{
			return new AuthenticationResultEvent(type, token, tokenSecret, applicationName, loginURL, authorizationURL, bubbles, cancelable);
		}
		
	}
}