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
	import com.netflix.webapis.services.TitlesService;
	
	/**
	 * Parameters to the Titles Services.
	 * @author jonbcampos
	 * 
	 */	
	public class TitlesParams extends ParamsBase
	{
		public function TitlesParams()
		{
			super();
		}
		
		//---------------------------------------------------------------------
		//
		// Public Constant
		//
		//---------------------------------------------------------------------
		public static const CATALOG_TYPE_AUTOCOMPLETE:String = TitlesService.AUTOCOMPLETE_SERVICE;
		public static const CATALOG_TYPE_CATALOG:String = TitlesService.CATALOG_SERVICE;
		public static const CATALOG_TYPE_TITLE:String = TitlesService.TITLE_SERVICE;
		
		//---------------------------------------------------------------------
		//
		// Public Properties
		//
		//---------------------------------------------------------------------
		
		/**
		 * Term Parameters purpose changes dependent on the service being called.
		 * 
		 * <p>
		 * <ul>
		 * <li>Catalog Service: The word or term for which to search in the catalog. 
		 * The method searches the title and synopses of catalog titles fields for a 
		 * match.</li>
		 * </ul>
		 * </p>
		 */		
		public var term:String = "";
		
		/**
		 * Catalog Title to get details on. 
		 */		
		public var title:CatalogItemModel;
		
		public var expandItem:String;
		
		/**
		 * Flag to get just the expansion list rather than the entire item. 
		 */		
		public var retrieveExpansionOnly:Boolean = false;
		
		public var genre:String;
		
		//---------------------------------------------------------------------
		//
		// Public Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */		
		override public function toString():String
		{
			var returnString:String = super.toString();
			if(term && term!="") returnString += "&term=" + escape(term);
			return returnString;
		}
		/**
		 * @inheritDoc
		 */		
		override public function toObject():Object
		{
			var o:Object = super.toObject();
			if(term) o.term = term;
			return o;
		}
		/**
		 * @inheritDoc
		 */
		override public function get defaultType() : String
		{
			return CATALOG_TYPE_TITLE;
		}
	}
}