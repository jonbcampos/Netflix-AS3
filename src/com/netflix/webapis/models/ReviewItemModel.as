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
package com.netflix.webapis.models
{
	import com.netflix.webapis.vo.LinkItem;
	import com.netflix.webapis.xml.NetflixXMLUtil;
	
	import flash.events.IEventDispatcher;
	
	[RemoteClass(alias="com.netflix.webapis.models.ReviewItemModel")]
	/**
	 * Review Item Model. 
	 * @author jonbcampos
	 * 
	 */	
	public class ReviewItemModel extends CatalogItemModel
	{
		public function ReviewItemModel(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		/**
		 * Review Writeup. 
		 */		
		public var writeup:String;
		/**
		 * User Rating. 
		 */		
		public var userRating:Number;
		/**
		 * Number that found this review helpful. 
		 */		
		public var helpful:Number;
		/**
		 * Number that found this review not helpful. 
		 */		
		public var notHelpful:Number;
		/**
		 * Review Id. 
		 */		
		public var reviewId:String;
		/**
		 * Awards Link. 
		 */		
		public var awards:LinkItem;
		/**
		 * Alternate Link. 
		 */		
		public var alternate:LinkItem;
		
	}
}