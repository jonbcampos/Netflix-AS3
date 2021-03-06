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
package com.netflix.webapis.services
{
	import com.netflix.webapis.ServiceFault;
	import com.netflix.webapis.events.NetflixFaultEvent;
	import com.netflix.webapis.events.NetflixResultEvent;
	import com.netflix.webapis.params.ParamsBase;
	import com.netflix.webapis.vo.NetflixUser;
	import com.netflix.webapis.xml.NetflixXMLUtilV2;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	import org.iotashan.oauth.IOAuthSignatureMethod;
	import org.iotashan.oauth.OAuthConsumer;
	import org.iotashan.oauth.OAuthRequest;
	import org.iotashan.oauth.OAuthSignatureMethod_HMAC_SHA1;
	import org.iotashan.oauth.OAuthToken;

	/**
	* Fault Event.
	*/	
	[Event(name="fault",type="com.netflix.webapis.events.NetflixFaultEvent")]
	/**
	 * Progress Event. 
	 */	
	[Event(name="progress",type="flash.events.ProgressEvent")]
	/**
	 * HTTP Status Event. 
	 */	
	[Event(name="httpStatus",type="flash.events.HTTPStatusEvent")]
	/**
	 * Event fired when the server time is returned. 
	 */	
	[Event(name="serverTimeComplete",type="com.netflix.webapis.events.NetflixResultEvent")]
	
	/**
	 * Base to all service classes.
	 * @author jonbcampos
	 * 
	 */	
	public class ServiceBase extends EventDispatcher
	{
		public static const NETFLIX_BASE_URL:String = "http://api-public.netflix.com/";
		public static const GET_REQUEST_METHOD:String = "GET";
		public static const POST_REQUEST_METHOD:String = "POST";
		public static const PUT_REQUEST_METHOD:String = "PUT";
		public static const DELETE_REQUEST_METHOD:String = "delete";
		public static const ODATA_REQUEST_METHOD:String = "odata";
		public static const SIG_METHOD:IOAuthSignatureMethod = new OAuthSignatureMethod_HMAC_SHA1();
		
		private static const LAST_RESULT_CHANGED:String = "lastResultChanged";
		
		private static const RESOURCE_BY_ID:String = "resourceById";
		//---------------------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------------------
		
		/**
		 * @private
		 * Reference to service storage. 
		 */		
		private var storage:ServiceStorage;
		
		public function ServiceBase()
		{
			super();
			storage = ServiceStorage.getInstance();
		}
		
		//---------------------------------------------------------------------
		//
		// Public Properties
		//
		//---------------------------------------------------------------------
		
		//---------------------
		// Key
		//---------------------
    	[Inspectable(category="General")]
    	/**
		 * Consumer Key. Get this variable from Netflix when you sign up for a developer account.
		 * 
		 * <p>Part of application wide storage.</p>
		 */
		protected function get key():String
		{
			return storage.key;
		}
		
		protected function set key(value:String):void
		{
			if(value && storage.secret)
				storage.consumer = new OAuthConsumer(value,storage.secret);
			storage.key = value;
		}
		
		//---------------------
		// Secret
		//---------------------
    	[Inspectable(category="General")]
    	/**
		 * Consumer Secret. Get this variable from Netflix when you sign up for a developer account.
		 * 
		 * <p>Part of application wide storage.</p>
		 */
		protected function get secret():String
		{
			return storage.secret;
		}
		
		protected function set secret(value:String):void
		{
			if(value && storage.key)
				storage.consumer = new OAuthConsumer(storage.key,value);
			storage.secret = value;
		}
		
		protected function get callBackUrl():String
		{
			return storage.callBackUrl;
		}
		
		protected function set callBackUrl(value:String):void
		{
			storage.callBackUrl = value;
		}
		//---------------------
		// Consumer
		//---------------------
    	[Inspectable(category="General")]
    	/**
		 * OAuth Consumer created when the developer key and secret are entered into the authorization service.
		 * 
		 * <p>Part of application wide storage.</p>
		 */
		protected function get consumer():OAuthConsumer
		{
			return storage.consumer;
		}
		
		//---------------------
		// Token
		//---------------------
    	[Inspectable(category="General")]
		/**
		 * Token returned from the <code>AccessTokenService.getAccessToken()</code>.
		 * 
		 * @see com.netflix.webapis.services.AccessTokenService#getAccessToken()
		 */
		protected function get token():String
		{
			return storage.token;
		}
		
		protected function set token(value:String):void
		{
			storage.token = value;
			if(value && tokenSecret)
				storage.accessToken = new OAuthToken(token,tokenSecret);
			else
				storage.accessToken = null;
		}
		
		//---------------------
		// Token Secret
		//---------------------
    	[Inspectable(category="General")]
		/**
		 * Token Secret returned from the <code>AccessTokenService.getAccessToken()</code>.
		 * 
		 * @see com.netflix.webapis.services.AccessTokenService#getAccessToken()
		 */	
		protected function get tokenSecret():String
		{
			return storage.tokenSecret;
		}
		
		protected function set tokenSecret(value:String):void
		{
			storage.tokenSecret = value;
			if(value && token)
				storage.accessToken = new OAuthToken(token,tokenSecret);
			else
				storage.accessToken = null;
		}
		
		//---------------------
		// OAuth Token
		//---------------------
    	[Inspectable(category="General")]
		/**
		 * Token returned from the <code>AuthenticationService.requestToken()</code>.
		 * 
		 * @see com.netflix.webapis.services.AuthenticationService#requestToken()
		 */
		protected function get oauthToken():String
		{
			return storage.oauthToken;
		}
		
		protected function set oauthToken(value:String):void
		{
			storage.oauthToken = value;
		}
		
		//---------------------
		// OAuth Token Secret
		//---------------------
    	[Inspectable(category="General")]
		/**
		 * Token Secret returned from the <code>AuthenticationService.requestToken()</code>.
		 * 
		 * @see com.netflix.webapis.services.AuthenticationService#requestToken()
		 */	
		protected function get oauthTokenSecret():String
		{
			return storage.oauthTokenSecret;
		}
		
		protected function set oauthTokenSecret(value:String):void
		{
			storage.oauthTokenSecret = value;
		}
		
		//---------------------
		// AuthToken
		//---------------------
    	[Inspectable(category="General")]
    	/**
		 * OAuth Token created when the token and tokenSecret are returned.
		 * 
		 * <p>Part of application wide storage.</p>
		 */	
		protected function get accessToken():OAuthToken
		{
			return storage.accessToken;
		}
		
		//---------------------
		// User Id
		//---------------------
    	[Inspectable(category="General")]
    	/**
		 * User id returned from the AccessToken Service.
		 * 
		 * <p>Part of application wide storage.</p>
		 */	
		protected function get userId():String
		{
			return storage.userId;
		}
		
		protected function set userId(value:String):void
		{
			storage.userId = value;
		}
		
		//---------------------
		// applicationName
		//---------------------
    	[Inspectable(category="General")]
    	/**
		 * Application Name returned from the <code>AuthenticationService.requestToken()</code> call.
		 * 
		 * <p>Part of application wide storage.</p>
		 * 
		 * @see com.netflix.webapis.services.AuthenticationService#requestToken()
		 */		
		protected function get applicationName():String
		{
			return storage.applicationName;
		}
		
		protected function set applicationName(value:String):void
		{
			storage.applicationName = value;
		}
		
		//---------------------
		// loginURL
		//---------------------
    	[Inspectable(category="General")]
    	/**
		 * Login URL returned from the <code>AuthenticationService.requestToken()</code> call.
		 * 
		 * <p>Part of application wide storage.</p>
		 * 
		 * @see com.netflix.webapis.services.AuthenticationService#requestToken()
		 */	
		protected function get loginURL():String
		{
			return storage.loginURL;
		}
		
		protected function set loginURL(value:String):void
		{
			storage.loginURL = value;
		}
		
		//---------------------
		// time offset
		//---------------------
		public function get timeOffset():Number
		{
			return storage.timeOffset;
		}
		
		public function set timeOffset(value:Number):void
		{
			storage.timeOffset = value;
		}
		
		//-----------------------------
		// shared object
		//-----------------------------
		/**
		 * Sets AutoSave for Authorization information for SharedObject access. 
		 * @return 
		 * 
		 */		
		public function get autoSaveAuthorization():Boolean
		{
			return storage.autoSaveAuthorization;
		}
		public function set autoSaveAuthorization(value:Boolean):void
		{
			storage.autoSaveAuthorization = value;
		}
		/**
		 * @private
		 * Persistent storage. 
		 */		
		protected function get lso():SharedObject
		{
			return storage.lso;
		}
		
		//---------------------
		// enableTrace
		//---------------------
		public function get enableTraceStatements():Boolean
		{
			return storage.enableTraceStatements;
		}
		
		public function set enableTraceStatements(value:Boolean):void
		{
			storage.enableTraceStatements = value;
		}
		
		//---------------------
		// user
		//---------------------
		[Inspectable(category="General")]
		/**
		 * User returned from the <code>UserService.getUserInfo()</code> call.
		 * 
		 * <p>Part of application wide storage.</p>
		 * 
		 * @see com.netflix.webapis.services.UserService#getUserInfo()
		 */		
		public function get user():NetflixUser
		{
			return storage.user;
		}
		
		public function set user(value:NetflixUser):void
		{
			storage.user = value;
		}
		
		//---------------------
		// authorizationURL
		//---------------------
    	[Inspectable(category="General")]
    	/**
		 * Authentication URL returned from the <code>AuthenticationService.requestToken()</code> call. 
		 * This is what is used to authorize your application to a user for user information access.
		 * 
		 * <p>To have the user authorize your app to access their account you need to invoke the 
		 * <code>AuthenticationService.getAuthorization()</code> function. This will open up a new 
		 * window where they will authorize your app. This one needs to be done once or until the
		 * user removes your app from the authorized list.<br />
		 * <br />
		 * Part of application wide storage.
		 * </p>
		 * 
		 * @see com.netflix.webapis.services.AuthenticationService#requestToken()
		 * @see com.netflix.webapis.services.AuthenticationService#getAuthorization()
		 */
		protected function get authorizationURL():String
		{
			return storage.authorizationURL;
		}
		
		protected function set authorizationURL(value:String):void
		{
			storage.authorizationURL = value;
		}
		
		//-----------------------------
		// lastResult
		//-----------------------------
		private var _lastNetflixResult:Object = null;
		[Inspectable(category="General")]
		/**
		 * The result of the last invocation.
		 * @return 
		 * 
		 */		
		public function get lastResult():Object
		{
			return _lastNetflixResult;
		}
		
		protected function set lastNetflixResult(value:Object):void
		{
			if(value==_lastNetflixResult)
				return;
			_lastNetflixResult = value;
			dispatchEvent(new Event(LAST_RESULT_CHANGED));
		}
		
		//-----------------------------
		// urlLoader
		//-----------------------------
		private var _urlLoader:URLLoader;
		/**
		 * Service URLLoader. 
		 * @return 
		 * 
		 */		
		protected function get urlLoader():URLLoader
		{
			return _urlLoader;
		}
		
		//---------------------------------------------------------------------
		//
		// Requests Storage
		//
		//---------------------------------------------------------------------
		internal var _numberOfResults:int;
		/**
		 * The total amount of results available 
		 */
		public function get numberOfResults():int
		{
			return _numberOfResults;
		}
		
		internal var _resultsPerPage:int;
		/**
		 * The total amount of results returned.
		 */
		public function get resultsPerPage():int
		{
			return _resultsPerPage;
		}
		
		/**
		 * Current Request. 
		 */		
		public var request:ParamsBase;
		
		/**
		 * Current URL. 
		 */		
		private var _currentURL:String;
		
		/**
		 * Current Params Object.
		 */		
		private var _currentParams:Object;
		
		protected var httpStatusResponse:String;
		protected var httpStatus:int;
		protected function get lastHttpStatusResponse():String
		{
			return httpStatusResponse;
		}
		
		internal var _currentIndex:int = 0;
		/**
		 * Current start index.
		 */
		public function get currentIndex():int
		{
			return _currentIndex;
		}
		
		private var _type:String;
		/**
		 * Service Type. 
		 * @return 
		 * 
		 */		
		public function get type():String
		{
			return _type;
		}
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Sends off for service.
		 * 
		 * This provides a way to use a standard method for services.
		 *  
		 * @param parameters
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 */
		public function send(parameters:ParamsBase = null):void
		{
			if(parameters == null)
			{
				if(request == null)
					request = new ParamsBase();
			}
			
			//set type if exists
			_type = (parameters.type)?parameters.type:parameters.defaultType;
		}
		/**
		 * Handles requests and previous requests to determine current request. 
		 * @param params sent params.
		 * @param type Requested type.
		 * @return 
		 * 
		 */		
		protected function determineParams(params:ParamsBase=null,type:String=null):ParamsBase
		{
			if(params == null)
			{
				if(request == null)
					request = new ParamsBase();
			}
			if(params is ParamsBase)
				request = params;
			
			if(type)
				_type = type;
				
			return request;
		}
		/**
		 * Handlers the service loading and calls for the service. Constructs the query string and retrieves the 
		 * parameters based <code>params</code> and sends for the service. 
		 * @param methodString url to send for the request
		 * @param params parameters of the query
		 * 
		 */
		protected function handleServiceLoading(methodString:String, params:ParamsBase = null):void
		{
			//check that the type is set in the params
			if(params && !params.type)
				params.type = type;
		}
		/**
		 * Formats the xml into typed objects and dispatches the final object in a result event.
		 * @param returnedXML
		 * 
		 */	
		protected function formatAndDispatch(returnedXML:XML):void
		{
			_numberOfResults = (returnedXML.number_of_results)?returnedXML.number_of_results:0;
			_currentIndex = (returnedXML.start_index)?returnedXML.start_index:0;
			_resultsPerPage = (returnedXML.results_per_page)?returnedXML.results_per_page:0;
			httpStatusResponse = (returnedXML.message)?returnedXML.message:httpStatusResponse;
		}
		/**
		 * Dispatches the result. 
		 * @param result formatted data
		 * @param dispatchType
		 * 
		 */	
		protected function dispatchResult(result:Object, dispatchType:String, rawXML:XML = null):void
		{
			if(hasEventListener(dispatchType+"Result"))
				dispatchEvent(new NetflixResultEvent(dispatchType+"Result", result, rawXML, _currentURL, _currentParams, httpStatusResponse));
		}
		/**
		 * Dispatches Fault.
		 * @param fault
		 * 
		 */	
		protected function dispatchFault(fault:ServiceFault):void
		{
			if(enableTraceStatements)
				trace(fault.toString());
			if(hasEventListener(NetflixFaultEvent.FAULT))
				dispatchEvent(new NetflixFaultEvent(NetflixFaultEvent.FAULT,fault, _currentURL, _currentParams, type));
		}
		
		private var _resultFunction:Function;
		private var _storedSendQuery:String;
		private var _storedParams:Object;
		private var _storedHttpMethod:String;
		/**
		 * Creates and handles loading for requests. 
		 * @param sendQuery
		 * @param params
		 * @param result
		 * @param httpMethod
		 * 
		 */		
		protected function createLoader(sendQuery:String, params:Object, result:Function, httpMethod:String="GET"):void
		{
			//first clear
			clearLoader();
			//store in case of fault
			_storedSendQuery = sendQuery;
			_storedParams = params;
			_storedHttpMethod = httpMethod;
			_resultFunction = result;
			//final http method
			var finalHttpMethod:String = (httpMethod==DELETE_REQUEST_METHOD || httpMethod==PUT_REQUEST_METHOD)?GET_REQUEST_METHOD:httpMethod;
			//then create
			_urlLoader = new URLLoader();
			_urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			//functions
			_urlLoader.addEventListener(Event.COMPLETE,result);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR,faultHandler);
			_urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			_urlLoader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			_urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			//make final params
			var finalParams:Object;
			//null check
			if(!params)
				params = {};
			//adjust params
			if(params is ParamsBase){
				if(finalHttpMethod==POST_REQUEST_METHOD)
					finalParams = ParamsBase(params).toPostObject();
				else if(httpMethod==PUT_REQUEST_METHOD)
					finalParams = ParamsBase(params).toPutObject();
				else
					finalParams = ParamsBase(params).toObject();
			} else {
				finalParams = params;
			}
			//don't say what the method is if we handle it correctly
			if(httpMethod != GET_REQUEST_METHOD || httpMethod != POST_REQUEST_METHOD)
				finalParams.method = httpMethod;
			//store information
			_currentParams = finalParams;
			_currentURL = sendQuery;
			//make request
			var requestString:String;
			if(httpMethod!=ODATA_REQUEST_METHOD)
			{
				var tokenRequest:OAuthRequest = new OAuthRequest(finalHttpMethod,sendQuery,finalParams,consumer,accessToken);
				requestString = createRequestString(tokenRequest);
			} else {
				requestString = sendQuery + ParamsBase(params).toOdataString();
				finalHttpMethod = GET_REQUEST_METHOD;
			}
			if(enableTraceStatements)
				trace(requestString);
			//make request
			var urlRequest:URLRequest = new URLRequest(requestString);
			
			if(finalHttpMethod==POST_REQUEST_METHOD)
			{
				var postVars:URLVariables = new URLVariables();
				for(var key:String in finalParams)
				{
					postVars[key] = finalParams[key];
				}
				urlRequest.data = postVars;
				urlRequest.url = sendQuery;
			}
			
			urlRequest.method = finalHttpMethod;
			try{
				_urlLoader.load(urlRequest);
			} catch (error:Error){
				dispatchFault(new ServiceFault(error.errorID.toString(), error.name, error.message));
			}
		}
		
		protected function createRequestString(tokenRequest:OAuthRequest):String
		{
			var offset:Number = 0;
			if(isNaN(timeOffset)==false)
				offset = timeOffset;
			return tokenRequest.buildRequest(SIG_METHOD, OAuthRequest.RESULT_TYPE_URL_STRING, "", offset);
		}
		
		/**
		 * Service Base ID result. Due to the unknown id request there is no VOs returned. Just XML. 
		 * @param event
		 * 
		 */		
		protected function completeHandler(event:Event):void
		{
			var loader:URLLoader = event.target as URLLoader;
			var queryXML:XML = XML(loader.data);
			
			if(queryXML.Error == undefined)
				dispatchResult(null,RESOURCE_BY_ID,queryXML);
			else
				dispatchFault(new ServiceFault(NetflixFaultEvent.API_RESPONSE, queryXML.Error, queryXML.Error.Message));
			clearLoader();
		}
		
		/**
		 * Service Base fault. 
		 * @param event
		 * 
		 */		
		protected function faultHandler(event:IOErrorEvent):void
		{
			if(enableTraceStatements)
				trace(event.toString());
			if(httpStatusResponse && httpStatusResponse=="API Fault, Invalid Signature." && isNaN(timeOffset))
			{
				getServerTimeOffset();
			} else {
				var errorText:String = (httpStatusResponse)?httpStatusResponse:event.text;
				dispatchFault(new ServiceFault(event.type,"IO Service Error: "+type+ " Error",errorText, event.text, httpStatus));
				clearLoader();
			}
		}
		
		/**
		 * Progress Handler. 
		 * @param event
		 * 
		 */		
		protected function progressHandler(event:ProgressEvent):void
		{
			if(enableTraceStatements)
				trace(event.toString());
			if(hasEventListener(event.type))
				dispatchEvent(event.clone());
		}
		
		/**
		 * Security Error Handler. 
		 * @param event
		 * 
		 */		
		protected function securityErrorHandler(event:SecurityErrorEvent):void
		{
			if(enableTraceStatements)
				trace(event.toString());
			if(hasEventListener(event.type))
				dispatchFault(new ServiceFault(event.type,"Security Service Error: "+type+ " Error",event.text, event.text));
			clearLoader();
		}
		
		/**
		 * HTTP Status Handler. 
		 * @param event
		 * 
		 */		
		protected function httpStatusHandler(event:HTTPStatusEvent):void
		{
			if(hasEventListener(event.type))
				dispatchEvent(event.clone());
			httpStatus = event.status;
			switch(event.status)
			{
				case 200:
					httpStatusResponse = "The resource's representation is returned in the response.";
					break;
				case 201:
					//users/user_token/queues/disc and users/user_token/queues/instant
					if(type==QueueService.DISC_QUEUE_SERVICE||
						type==QueueService.INSTANT_QUEUE_SERVICE||
						type==QueueService.UPDATE_INSTANT_SERVICE||
						type==QueueService.UPDATE_DISC_SERVICE
					)
						httpStatusResponse = "Only some titles in series or disc set were added.";
					else
						httpStatusResponse = "Resource created";
					break;
				case 304:
					httpStatusResponse = "Resource not modified";
					break;
				case 400:
					httpStatusResponse = "Invalid OAuth Security Token";
					break;
				case 401:
					httpStatusResponse = "API Fault, Invalid Signature.";
					break;
				case 403:
					httpStatusResponse = "Invalid feed token";
					break;
				case 404:
					httpStatusResponse = "Resource not found";
					break;
				case 412:
					//users/user_token/queues/disc and users/user_token/queues/instant
					if(type==QueueService.DISC_QUEUE_SERVICE||
						type==QueueService.INSTANT_QUEUE_SERVICE||
						type==QueueService.UPDATE_INSTANT_SERVICE||
						type==QueueService.UPDATE_DISC_SERVICE
					)
						httpStatusResponse = "Title already in queue";
					else
						httpStatusResponse = "Precondition failed. Resource has been modified.";
					break;
				case 422:
					httpStatusResponse = "Title has already been rated";
					break;
				case 500:
					httpStatusResponse = "Internal error";
					break;
			}
		}
		
		/**
		 * Clears our the URLLoader. 
		 */	
		protected function clearLoader():void
		{
			if(_urlLoader)
			{
				try{
					_urlLoader.close();
				} catch(e:Error){
					//no stream open
				}
				_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,faultHandler);
				_urlLoader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
				_urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
				_urlLoader.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
				if(_resultFunction!=null)
					_urlLoader.removeEventListener(Event.COMPLETE,_resultFunction);
				_urlLoader = null;
			}
			//release stored values
			/*
			_resultFunction = null;
			_storedHttpMethod = null;
			_storedParams = null;
			_storedSendQuery = null;
			*/
			//release held response
			httpStatusResponse = null;
		}
		//---------------------------------------------------------------------
		//
		// getResourceById service
		//
		//---------------------------------------------------------------------
		
		/**
		 * Retrieves Netflix result by Netflix Id Object. 
		 * @param id netflix id
		 * @param params base object with additional params
		 * 
		 */		
		final public function getResourceById(id:String,params:Object=null):void
		{
			if(params==null)
				params = new ParamsBase();
			if(checkForAccessToken()==false)
				return;
			//create loader
			createLoader(id, params, completeHandler);
		}
		
		//---------------------------------------------------------------------
		//
		// Services Checks
		//
		//---------------------------------------------------------------------
		
		/**
		 * Checks for Consumer key, returns true if exists, false if does not exist.
		 * 
		 * @return 
		 * 
		 */
		protected function checkForConsumerKey():Boolean
		{
			if(!consumer){
				dispatchFault(new ServiceFault("fault","OAuth Error","Missing Authentication Token, use the Authentication Token Service and requestToken() prior to making this call."));
				return false;
			} else {
				return true;
			}
		}
		
		/**
		 * Checks for AuthToken, returns true if exists, false if does not exist.
		 * 
		 * @return 
		 * 
		 */
		protected function checkForAuthToken():Boolean
		{
			if(checkForConsumerKey()==false)
				return false;
			if(oauthToken==null||oauthTokenSecret==null){
				dispatchFault(new ServiceFault("fault","OAuth Error","Missing Authentication Token, use the Authentication Token Service and requestToken() prior to making this call."));
				return false;
			} else {
				return true;
			}
		}
		
		/**
		 * Checks for AccessToken, returns true if exists, false if does not exist.
		 * 
		 * @return 
		 * 
		 */		
		protected function checkForAccessToken():Boolean
		{
			if(checkForAuthToken()==false)
				return false;
			if(userId==null){
				dispatchFault(new ServiceFault("fault","OAuth Error","Missing Access Token, use the Access Token Service and getAccessToken() prior to making this call."));
				return false;
			}
			return true;
		}
		
		/**
		 * Checks for User Information, returns true if exists, false if does not exist.
		 * 
		 * @return 
		 * 
		 */		
		protected function checkForUser():Boolean
		{
			if(user==null){
				dispatchFault(new ServiceFault("fault","User Error","Missing Netflix User, use the User Service and getUserInfo() prior to making this call."));
				return false;
			}
			return true;
		}
		
		/**
		 * Checks for etag, returns true if exists, false if does not exist.
		 *  
		 * @return 
		 * 
		 */		
		protected function checkForDiscETag():Boolean
		{
			if(checkForUser()==false)
				return false;
			if(!storage.lastDiscQueueETag)
			{
				dispatchFault(new ServiceFault("fault","ETag Error","Missing Netflix Etag, use the Queue Service and discQueueService() prior to making this call."));
				return false;
			}
			return true;
		}
		
		/**
		 * Checks for etag, returns true if exists, false if does not exist.
		 *  
		 * @return 
		 * 
		 */		
		protected function checkForInstantETag():Boolean
		{
			if(checkForUser()==false)
				return false;
			if(!storage.lastInstantQueueETag)
			{
				dispatchFault(new ServiceFault("fault","ETag Error","Missing Netflix Etag, use the Queue Service and instantQueueService() prior to making this call."));
				return false;
			}
			return true;
		}
		
		//---------------------------------------------------------------------
		//
		//  Public Function
		//
		//---------------------------------------------------------------------
		
		public function setConsumerKey(netflixKey:String, netflixSecret:String):void
		{
			if(netflixKey != key)
				key = netflixKey;
			if(netflixSecret != secret)
				secret = netflixSecret;
		}
		
		/**
		 * Logout function, forgets userId and access token. 
		 * 
		 */		
		public function logout():void
		{
			if(lso)
			{
				token = null;
				tokenSecret = null;
				userId = null;
				user = null;
				lso.clear();
				lso.flush();
			}
		}
		
		//---------------------------------------------------------------------
		//
		//  Time Loader
		//
		//---------------------------------------------------------------------
		private var _timeLoader:URLLoader;
		
		protected function getServerTimeOffset():void
		{
			_clearTimeLoader();
			
			_timeLoader = new URLLoader();
			_timeLoader.dataFormat = URLLoaderDataFormat.TEXT;
			_timeLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			_timeLoader.addEventListener(IOErrorEvent.IO_ERROR,_onTimeLoader_IOErrorHandler);
			_timeLoader.addEventListener(Event.COMPLETE,_onTimeLoader_CompleteHandler);
			
			var tokenRequest:OAuthRequest = new OAuthRequest(GET_REQUEST_METHOD,NETFLIX_BASE_URL+"oauth/clock/time",null,consumer, accessToken);
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
			//find offset
			var serverTime:Number = NetflixXMLUtilV2.handleNumber(result)*1000;
			var cur:Date = new Date();
			timeOffset =  serverTime - cur.time;
			lastNetflixResult = {"time":serverTime};
			if(hasEventListener(NetflixResultEvent.SERVER_TIME_COMPLETE))
				dispatchEvent(new NetflixResultEvent(NetflixResultEvent.SERVER_TIME_COMPLETE, serverTime, null, result));
			//reply last result
			reRunLast();
		}
		
		private function _onTimeLoader_IOErrorHandler(event:IOErrorEvent):void
		{
			_clearTimeLoader();
			dispatchFault(new ServiceFault(event.type,"Server Time Error",event.text, lastHttpStatusResponse));
		}
		
		protected function reRunLast():void
		{
			if(_resultFunction!=null)
				createLoader(_storedSendQuery, _storedParams, _resultFunction, _storedHttpMethod);
		}
	}
}