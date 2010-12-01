/*
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
	import com.netflix.webapis.vo.NetflixUser;
	
	import flash.events.EventDispatcher;
	import flash.net.SharedObject;
	
	import org.iotashan.oauth.OAuthConsumer;
	import org.iotashan.oauth.OAuthToken;
	
	/**
	 * Centralized Storage unit for the api. Rather than having to keep adding 
	 * the same variables to each call, or have to pass them into each instance, 
	 * the <code>ServiceStorage</code> unit holds the variables in one central place 
	 * that is accessable via a Singleton object to each instance.
	 * 
	 * <p>Not intended to be accessed directly, but it is possible dependent on 
	 * your needs.</p>
	 * 
	 * @author jonbcampos
	 * */
	public class ServiceStorage extends EventDispatcher
	{
		//---------------------------------------------------------------------
		//
		//  Singleton Setup
		//
		//---------------------------------------------------------------------
		
		private static var _instance:ServiceStorage;
		
		/**
		 * Singleton Enforced Constructor. 
		 * @param enforcer
		 * 
		 */		
		public function ServiceStorage(enforcer:SingletonEnforcer)
		{
			// get local shared object
			lso = SharedObject.getLocal(LSO_NAME);
			if(lso.size==0){
				_autoSaveAuthorization = false;
			} else {
				_autoSaveAuthorization = lso.data.autoSaveAuthorization;
				if(lso.data)
				{
					if(lso.data.userId)
						userId = lso.data.userId;
					if(lso.data.accessToken && lso.data.accessToken.key && lso.data.accessToken.secret)
						accessToken = new OAuthToken(lso.data.accessToken.key, lso.data.accessToken.secret);
					if(lso.data.user)
						user = lso.data.user;
				}
			}
		}
		
		/**
		 * Constructor Accessor. 
		 * @return instance of the class.
		 * 
		 */		
		public static function getInstance():ServiceStorage
		{
			if(ServiceStorage._instance==null)
				ServiceStorage._instance = new ServiceStorage(new SingletonEnforcer());
			return ServiceStorage._instance;
		}
		
		//---------------------------------------------------------------------
		//
		//  Public Properties
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		//  consumer key
		//-----------------------------
		/**
		 * Consumer Key. Get this variable from Netflix when you sign up for a developer account.
		 */
		internal var key:String;
		
		//-----------------------------
		//  consumer secret
		//-----------------------------
		/**
		 * Consumer Secret. Get this variable from Netflix when you sign up for a developer account.
		 */
		internal var secret:String;
		
		internal var callBackUrl:String;
		//-----------------------------
		//  oauth consumer
		//-----------------------------
		/**
		 * OAuth Consumer created when the developer key and secret are entered into the authorization service.
		 */
		internal var consumer:OAuthConsumer;
		
		//-----------------------------
		//  oauth access token
		//-----------------------------
		/**
		 * Token returned from the <code>AuthenticationService.requestToken()</code>.
		 * 
		 * @see com.netflix.webapis.services.AuthenticationService#requestToken()
		 */
		internal var oauthToken:String;
		/**
		 * Token Secret returned from the <code>AuthenticationService.requestToken()</code>.
		 * 
		 * @see com.netflix.webapis.services.AuthenticationService#requestToken()
		 */
		internal var oauthTokenSecret:String;
		//-----------------------------
		//  access token
		//-----------------------------
		/**
		 * Token returned from the <code>AccessTokenService.getAccessToken()</code>.
		 * 
		 * @see com.netflix.webapis.services.AccessTokenService#getAccessToken()
		 */
		internal var token:String;
		
		//-----------------------------
		//  token secret
		//-----------------------------
		/**
		 * Token Secret returned from the <code>AccessTokenService.getAccessToken()</code>.
		 * 
		 * @see com.netflix.webapis.services.AccessTokenService#getAccessToken()
		 */
		internal var tokenSecret:String;
		
		//-----------------------------
		//  oauth token
		//-----------------------------
		/**
		 * OAuth Token created when the token and tokenSecret are returned. 
		 */
		internal var accessToken:OAuthToken;
		
		//-----------------------------
		//  user id
		//-----------------------------
		/**
		 * User id returned from the AccessToken Service. 
		 */
		internal var userId:String;
		
		//-----------------------------
		//  application name
		//-----------------------------
		/**
		 * Application Name returned from the <code>AuthenticationService.requestToken()</code> call.
		 * 
		 * @see com.netflix.webapis.services.AuthenticationService#requestToken()
		 */
		internal var applicationName:String;
		
		//-----------------------------
		//  login url
		//-----------------------------
		/**
		 * Login URL returned from the <code>AuthenticationService.requestToken()</code> call.
		 * 
		 * @see com.netflix.webapis.services.AuthenticationService#requestToken()
		 */
		internal var loginURL:String;
		
		//-----------------------------
		//  server time offset
		//-----------------------------
		internal var timeOffset:Number = 0;
		
		//-----------------------------
		//  authorization url
		//-----------------------------
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
		 */
		internal var authorizationURL:String;
		
		/**
		 * Last returned netflix etag. 
		 */		
		public var lastDiscQueueETag:String;
		public var lastInstantQueueETag:String;
		
		[Bindable]
		/**
		 * Netflix User.
		 */		
		public var user:NetflixUser;
		
		//-----------------------------
		//  access token exists
		//-----------------------------
		public function get accessTokenExists():Boolean
		{
			return (userId && userId.length>0 && accessToken)
		}
		//-----------------------------
		//  enable trace
		//-----------------------------
		public var enableTraceStatements:Boolean;
		//-----------------------------
		//  shared object
		//-----------------------------
		private var LSO_NAME:String = "com.netflix.webapis.storage";
		/**
		 * Secret Local Shared Object. 
		 */		
		internal var lso:SharedObject;
		
		private var _autoSaveAuthorization:Boolean = false;
		/**
		 * Auto Save Authoization Storage. 
		 */		
		public function get autoSaveAuthorization():Boolean
		{
			return _autoSaveAuthorization;
		}
		
		public function set autoSaveAuthorization(value:Boolean):void
		{
			if(value==_autoSaveAuthorization)
				return;
			_autoSaveAuthorization = value;
			lso.data.autoSaveAuthorization = value;
			if(value){
				lso = SharedObject.getLocal(LSO_NAME);
				lso.data.userId = userId;
				lso.data.user = user;
				lso.data.accessToken = accessToken;
				lso.flush();
			} else {
				lso.clear();
				lso.flush();
			}
		}
	}
}
class SingletonEnforcer{}