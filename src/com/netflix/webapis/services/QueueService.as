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
	import com.netflix.webapis.events.NetflixFaultEvent;
	import com.netflix.webapis.events.NetflixResultEvent;
	import com.netflix.webapis.models.CatalogItemModel;
	import com.netflix.webapis.models.QueueItemModel;
	import com.netflix.webapis.params.ParamsBase;
	import com.netflix.webapis.params.QueueParams;
	import com.netflix.webapis.xml.NetflixXMLUtil;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequestMethod;
	
	/**
	 * Services under the Queue Category, including adding items into a
	 * user's instant or disc queue, removing, and updating a queue, and
	 * retrieving the queue.
	 *  
	 * @author jonbcampos
	 * 
	 */	
	public class QueueService extends ServiceBase
	{
		public function QueueService(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		//---------------------------------------------------------------------
		//
		// Constants
		//
		//---------------------------------------------------------------------
		protected static const QUEUES_PART:String = "queues";
		protected static const DISC_PART:String = "disc";
		protected static const INSTANT_PART:String = "instant";
		
		protected static const AVAILABLE_PART:String = "available";
		protected static const SAVED_PART:String = "saved";
		
		public static const DISC_QUEUE_SERVICE:String = "discQueue";
		public static const INSTANT_QUEUE_SERVICE:String = "instantQueue";
		
		public static const UPDATE_DISC_SERVICE:String = "updateDiscQueue";
		public static const UPDATE_INSTANT_SERVICE:String = "updateInstantQueue";
		
		public static const DELETE_DISC_SERVICE:String = "deleteDiscQueue";
		public static const DELETE_INSTANT_SERVICE:String = "deleteInstantQueue";
		
		//---------------------------------------------------------------------
		//
		// Public Methods
		//
		//---------------------------------------------------------------------
		/**
		 * @inheritDoc
		 */	
		override public function send(parameters:ParamsBase = null):void
		{
			super.send(parameters);
			
			switch(type)
			{
				case DISC_QUEUE_SERVICE:
					discQueueService( parameters );
					break;
				case INSTANT_QUEUE_SERVICE:
					instantQueueService( parameters );
					break;
				case UPDATE_DISC_SERVICE:
					updateDiscQueueService( parameters );
					break;
				case UPDATE_INSTANT_SERVICE:
					updateInstantQueueService( parameters );
					break;
				case DELETE_DISC_SERVICE:
					deleteDiscQueueService( parameters );
					break;
				case DELETE_INSTANT_SERVICE:
					deleteInstantQueueService( parameters );
					break;
			}
		}
		
		/**
		 * Returns the contents of a user's disc queues.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param params
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */		
		public function discQueueService(params:ParamsBase=null):void
		{
			if(checkForUser()==false)
				return;
			handleServiceLoading(user.queuesLink,determineParams(params,DISC_QUEUE_SERVICE));
		}
		
		/**
		 * Returns the contents of a user's instant queues.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param params
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */	
		public function instantQueueService(params:ParamsBase=null):void
		{
			if(checkForUser()==false)
				return;
			handleServiceLoading(user.queuesLink,determineParams(params,INSTANT_QUEUE_SERVICE));
		}
		
		/**
		 * Creates/Updates the contents of a user's disc queues.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param params
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */	
		public function updateDiscQueueService(params:ParamsBase=null):void
		{
			if(checkForUser()==false)
				return;
			handleServiceLoading(user.queuesLink,determineParams(params,UPDATE_DISC_SERVICE));
		}
		
		/**
		 * Creates/Updates the contents of a user's instant queues.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param params
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */	
		public function updateInstantQueueService(params:ParamsBase=null):void
		{
			if(checkForUser()==false)
				return;
			handleServiceLoading(user.queuesLink,determineParams(params,UPDATE_INSTANT_SERVICE));
		}
		
		/**
		 * Removes a title from a user's instant queues.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param params
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */
		public function deleteInstantQueueService(params:ParamsBase=null):void
		{
			if(checkForUser()==false)
				return;
			handleServiceLoading(user.queuesLink,determineParams(params,DELETE_INSTANT_SERVICE));
		}
		
		/**
		 * Removes a title from a user's disc queues.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param params
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */
		public function deleteDiscQueueService(params:ParamsBase=null):void
		{
			if(checkForUser()==false)
				return;
			handleServiceLoading(user.queuesLink,determineParams(params,DELETE_DISC_SERVICE));
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function handleServiceLoading(methodString:String, params:ParamsBase=null):void
		{
			super.handleServiceLoading(methodString, params);
			
			var sendQuery:String = methodString;
			var typeQuery:String;
			var method:String = URLRequestMethod.GET;
			
			if(checkForUser()==false)
				return;
			
			if(!params)
				return;
				
			switch(type)
			{
				case DISC_QUEUE_SERVICE:
					sendQuery += "/" + DISC_PART + _getStatus(params as QueueParams);
					break;
				case INSTANT_QUEUE_SERVICE:
					sendQuery += "/" + INSTANT_PART + _getStatus(params as QueueParams);
					break;
				case UPDATE_DISC_SERVICE:
					if(checkForETag()==false)
						return;
					sendQuery += "/" + DISC_PART;
					method = URLRequestMethod.POST;
					break;
				case UPDATE_INSTANT_SERVICE:
					if(checkForETag()==false)
						return;
					sendQuery += "/" + INSTANT_PART;
					method = URLRequestMethod.POST;
					break;
				case DELETE_DISC_SERVICE:
					if(!QueueParams(params).titleRef)
						return;
					sendQuery = (params as QueueParams).titleRef.id;
					method = ServiceBase.DELETE_REQUEST_METHOD;
					break;
				case DELETE_INSTANT_SERVICE:
					if(!QueueParams(params).titleRef)
						return;
					sendQuery = (params as QueueParams).titleRef.id;
					method = ServiceBase.DELETE_REQUEST_METHOD;
					break;
			}
			
			createLoader(sendQuery, params, _queueService_CompleteHandler, method);
		}
		//---------------------------------------------------------------------
		//
		// Private Methods
		//
		//---------------------------------------------------------------------
		
		private function _queueService_CompleteHandler(event:Event):void
		{
			var loader:URLLoader = event.target as URLLoader;
			var queryXML:XML = XML(loader.data);
			
			if(queryXML.Error == undefined)
				formatAndDispatch(queryXML);
			else
				dispatchFault(new ServiceFault(NetflixFaultEvent.API_RESPONSE, queryXML.Error, queryXML.Error.Message));
			clearLoader();
		}
		
		//---------------------------------------------------------------------
		//
		// Override Methods
		//
		//---------------------------------------------------------------------
		/**
		 * @inheritDoc
		 */		
		override protected function formatAndDispatch(returnedXML:XML):void
		{
			super.formatAndDispatch(returnedXML);
			
			var resultsArray:Array = [];
			var resultNode:XML;
			
			//loop through child nodes and build value objects based on catagory type
			switch(type)
			{
				case DISC_QUEUE_SERVICE:
				case UPDATE_DISC_SERVICE:
					if (returnedXML..etag != null)
						ServiceStorage.getInstance().lastDiscQueueETag = NetflixXMLUtil.handleETagNode(returnedXML..etag[0]);
					for each (resultNode in returnedXML..queue_item) {
						resultsArray.push( NetflixXMLUtil.handleXMLToCatalogItemModel(resultNode, new QueueItemModel()) );
					}
					break;
				case INSTANT_QUEUE_SERVICE:
				case UPDATE_INSTANT_SERVICE:
					if (returnedXML..etag != null)
						ServiceStorage.getInstance().lastInstantQueueETag = NetflixXMLUtil.handleETagNode(returnedXML..etag[0]);
					for each (resultNode in returnedXML..queue_item) {
						resultsArray.push( NetflixXMLUtil.handleXMLToCatalogItemModel(resultNode, new QueueItemModel()) );
					}
					break;
				case DELETE_DISC_SERVICE:
					resultsArray.push((request as QueueParams).titleRef);
					break;
				case DELETE_INSTANT_SERVICE:
					resultsArray.push((request as QueueParams).titleRef);
					break;
			}
			lastNetflixResult = resultsArray;
			dispatchResult(resultsArray,type, returnedXML);
		}
		
		//---------------------------------------------------------------------
		//
		// No Params Quick Functions
		//
		//---------------------------------------------------------------------
		/**
		 * Returns the contents of a user's disc queues.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */	
		public function getUserDiscQueue(startIndex:uint=0, maxResults:uint=25):void
		{
			var q:QueueParams = new QueueParams();
			q.startIndex = startIndex;
			q.maxResults = maxResults;
			discQueueService(q);
		}
		
		/**
		 * Returns the contents of a user's available disc queues.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */	
		public function getUserAvailableDiscQueue(startIndex:uint=0, maxResults:uint=25):void
		{
			var q:QueueParams = new QueueParams();
			q.startIndex = startIndex;
			q.maxResults = maxResults;
			q.status = QueueParams.STATUS_AVAILABLE;
			discQueueService(q);
		}
		
		/**
		 * Returns the contents of a user's saved disc queues.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */	
		public function getUserSavedDiscQueue(startIndex:uint=0, maxResults:uint=25):void
		{
			var q:QueueParams = new QueueParams();
			q.startIndex = startIndex;
			q.maxResults = maxResults;
			q.status = QueueParams.STATUS_SAVED;
			discQueueService(q);
		}
		
		/**
		 * Returns the contents of a user's instant queues.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */	
		public function getUserInstantQueue(startIndex:uint=0, maxResults:uint=25):void
		{
			var q:QueueParams = new QueueParams();
			q.startIndex = startIndex;
			q.maxResults = maxResults;
			instantQueueService(q);
		}
		
		/**
		 * Returns the contents of a user's available instant queues.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */	
		public function getUserAvailableInstantQueue(startIndex:uint=0, maxResults:uint=25):void
		{
			var q:QueueParams = new QueueParams();
			q.startIndex = startIndex;
			q.maxResults = maxResults;
			q.status = QueueParams.STATUS_AVAILABLE;
			instantQueueService(q);
		}
		
		/**
		 * Returns the contents of a user's saved instant queues.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */	
		public function getUserSavedInstantQueue(startIndex:uint=0, maxResults:uint=25):void
		{
			var q:QueueParams = new QueueParams();
			q.startIndex = startIndex;
			q.maxResults = maxResults;
			q.status = QueueParams.STATUS_SAVED;
			instantQueueService(q);
		}
		
		/**
		 * Creates/Updates the contents of a user's disc queues.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param title
		 * @param position
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */	
		public function updateTitleInDiscQueue(title:CatalogItemModel,position:int=0):void
		{
			var params:QueueParams = new QueueParams();
			params.titleRef = title;
			params.position = position;
			updateDiscQueueService(params);
		}
		
		/**
		 * Creates/Updates the contents of a user's instant queues.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param title
		 * @param position
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */	
		public function updateTitleInInstantQueue(title:CatalogItemModel,position:int=0):void
		{
			var params:QueueParams = new QueueParams();
			params.titleRef = title;
			params.position = position;
			updateInstantQueueService(params);
		}
		
		/**
		 * Removes a title from a user's instant queues.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param title
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */
		public function deleteTitleFromDiscQueue(title:QueueItemModel):void
		{
			var params:QueueParams = new QueueParams();
			params.titleRef = title;
			deleteDiscQueueService(params);
		}
		
		/**
		 * Removes a title from a user's disc queues.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param title
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */
		public function deleteTitleFromInstantQueue(title:QueueItemModel):void
		{
			var params:QueueParams = new QueueParams();
			params.titleRef = title;
			deleteInstantQueueService(params);
		}
		
		//---------------------------------------------------------------------
		//
		// Private Functions
		//
		//---------------------------------------------------------------------
		/**
		 * @private
		 * Retrieves the appropriate status. 
		 * @param params
		 * @return 
		 * 
		 */		
		private function _getStatus(params:QueueParams):String
		{
			if(!params)
				return "";
			switch(params.status)
			{
				case QueueParams.STATUS_SAVED:
					return "/"+SAVED_PART;
					break;
				case QueueParams.STATUS_AVAILABLE:
					return "/"+AVAILABLE_PART;
					break;
				default:
					return "";
					break;
			}
		}
		
	}
}