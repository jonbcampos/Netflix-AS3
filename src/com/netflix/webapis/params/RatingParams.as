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
	import com.netflix.webapis.models.RatingsItemModel;
	import com.netflix.webapis.services.RatingService;
	
	/**
	 * Params for the RatingService. 
	 * @author jonbcampos
	 * 
	 * @see com.netflix.webapis.services.RatingService
	 */	
	public class RatingParams extends ParamsBase
	{
		public function RatingParams()
		{
			super();
		}
		
		//---------------------------------------------------------------------
		//
		// Public Constant
		//
		//---------------------------------------------------------------------
		public static const RATING_TYPE_TITLE_RATINGS:String = RatingService.TITLE_RATINGS_SERVICE;
		
		//---------------------------------------------------------------------
		//
		// Public Properties
		//
		//---------------------------------------------------------------------
		/**
		 * One or more catalog title URLs for which to retrieve rental option 
		 * state. Up to 500 titles states may be requested.
		 */		
		public var titleRefs:Array;
		
		/**
		 * One catalog title URLs for which to retrieve rental option state.
		 */		
		public var titleRef:CatalogItemModel;
		
		/**
		 * Rating item to update. 
		 */		
		public var ratingItem:RatingsItemModel;
		
		private var _rating:int;
		/**
		 * Rating Value. 
		 * @return 
		 * 
		 */		
		public function get rating():int
		{
			return _rating;
		}
		public function set rating(value:int):void
		{
			if(value<-1) value=-1;
			if(value>5) value=5;
			_rating = value;
		}
		
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
			if(titleRefs&&titleRefs.length>0){
				var n:int = titleRefs.length;
				var titleRefString:String = "";
				for(var i:int=0;i<n;i++)
				{
					if(titleRefs[i] is CatalogItemModel)
					{
						titleRefString += (titleRefs[i] as CatalogItemModel).netflixId;
						if(i<n-1)
							titleRefString += ",";
					} else if(titleRefs[i] && titleRefs[i] is String)
					{
						titleRefString += titleRefs[i] as String;
						if(i<n-1)
							titleRefString += ",";
					}
				}
				o.title_refs = titleRefString;
			} else if(titleRef)
			{
				o.title_refs = titleRef.id;
			}
			return o;
		}
		
		override public function toPostObject() : Object
		{
			var o:Object = super.toPostObject();
			//rating
			if(rating==-1)
				o.rating = "no_opinion";
			else if(rating==0)
				o.rating = "not_interested";
			else
				o.rating = rating;
			//titleRef
			if(titleRef)
				o.title_ref = titleRef.netflixId;
			//
			return o;
		}
		
		/**
		 * @inheritDoc
		 */	
		override public function get defaultType() : String
		{
			return RATING_TYPE_TITLE_RATINGS;
		}
	}
}