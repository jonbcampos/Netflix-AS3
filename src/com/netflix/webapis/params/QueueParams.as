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
	import com.netflix.webapis.models.CatalogItemModel;
	import com.netflix.webapis.models.QueueItemModel;
	import com.netflix.webapis.services.QueueService;
	import com.netflix.webapis.services.ServiceStorage;
	
	/**
	 * User Queue Parameters.
	 * @author jonbcampos
	 * 
	 */	
	public class QueueParams extends ParamsBase
	{
		public function QueueParams()
		{
			super();
		}
		
		//---------------------------------------------------------------------
		//
		// Public Constant
		//
		//---------------------------------------------------------------------
		public static const SORT_QUEUE_SEQUENCE:String = "queue_sequence";
		public static const SORT_DATE_ADDED:String = "date_added";
		public static const SORT_ALPHABETICAL:String = "alphabetical";
		
		public static const FORMAT_DVD:String = "DVD";
		public static const FORMAT_BLURAY:String = "Blu-ray";
		
		public static const STATUS_AVAILABLE:String = "available";
		public static const STATUS_SAVED:String = "saved";
		//---------------------------------------------------------------------
		//
		// Public Properties
		//
		//---------------------------------------------------------------------
		[Inspectable(enumeration="available,saved")]
		/**
		 * Specifies which list to retrieve from the user's queue. <code>null</code> 
		 * returns the entire list, <code>available</code> retrieves from the available 
		 * list, and <code>saved</code> retrieves from the saved list.
		 */		
		public var status:String;
		
		[Inspectable(enumeration="queue_sequence,date_added,alphabetical",defaultValue="queue_sequence")]
		/**
		 * Specifies the sort order for the queue entries.
		 * 
		 * Sort order may be by queue_sequence, date_added, or alphabetical. 
		 * The default sort order, if not specified, is queue_sequence. 
		 * Note: The queue_order is always alphabetical for a saved disc queue 
		 * that does not have numeric positions.
		 */		
		public var sort:String = SORT_QUEUE_SEQUENCE;
		/**
		 * Filters returned items, allowing through only those items with 
		 * updated dates greater than or equal to the passed value of 
		 * updated_min. The value can be specified in Unix time format 
		 * (seconds since epoch) or in the format defined by RFC 3339 
		 * (as used by the Atom feed standard).
		 */		
		public var updatedMin:Date;
		/**
		 * The catalog title to be added to the queue.
		 */		
		public var titleRef:CatalogItemModel;
		
		[Inspectable(enumeration="DVD,Blu-ray",defaultValue="DVD")]
		/**
		 * Either DVD or Blu-ray format. (Applies to discs only.)
		 * 
		 * If this value is not supplied, the subscriber's format preference is 
		 * used. Note: DVD format is used if the subscriber's format preference 
		 * is Blu-ray and the title is not available in Blu-ray format but it 
		 * is available in DVD format.
		 */		
		public var formatType:String = FORMAT_DVD;
		/**
		 * The position within the queue in which to insert or move the title.
		 */		
		public var position:Number = NaN;
		
		//---------------------------------------------------------------------
		//
		// Public Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */		
		override public function toObject():Object
		{
			var o:Object = super.toObject();
			//sort
			if(sort)
				o.sort = sort;
			//updatedMin
			if(updatedMin)
				o.updated_min = updatedMin.time;
			//etag
			switch(type)
			{
				case QueueService.DISC_QUEUE_SERVICE:
				case QueueService.UPDATE_DISC_SERVICE:
				case QueueService.DELETE_DISC_SERVICE:
					o.etag = ServiceStorage.getInstance().lastDiscQueueETag;
					break;
				case QueueService.INSTANT_QUEUE_SERVICE:
				case QueueService.UPDATE_INSTANT_SERVICE:
				case QueueService.DELETE_INSTANT_SERVICE:
					o.etag = ServiceStorage.getInstance().lastInstantQueueETag;
					break;
			}
			return o;
		}
		
		/**
		 * @inheritDoc
		 */	
		override public function toPostObject() : Object
		{
			var o:Object = super.toPostObject();
			if(titleRef)
				o.title_ref = titleRef.netflixId;
			if(formatType)
				o.format = formatType;
			if(!isNaN(position))
				o.position = position;
			//etag
			//etag
			switch(type)
			{
				case QueueService.DISC_QUEUE_SERVICE:
				case QueueService.UPDATE_DISC_SERVICE:
				case QueueService.DELETE_DISC_SERVICE:
					o.etag = ServiceStorage.getInstance().lastDiscQueueETag;
					break;
				case QueueService.INSTANT_QUEUE_SERVICE:
				case QueueService.UPDATE_INSTANT_SERVICE:
				case QueueService.DELETE_INSTANT_SERVICE:
					o.etag = ServiceStorage.getInstance().lastInstantQueueETag;
					break;
			}
			return o;
		}
		
		/**
		 * @inheritDoc
		 */	
		override public function get defaultType() : String
		{
			return null;
		}
		

	}
}