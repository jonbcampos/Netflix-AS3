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
	import com.netflix.webapis.services.PeopleService;
	
	
	/**
	 * Parameters to the People Services.
	 * @author jonbcampos
	 * 
	 */	
	public class PeopleParams extends ParamsBase
	{
		public function PeopleParams()
		{
			super();
		}
		
		//---------------------------------------------------------------------
		//
		// Public Constants
		//
		//---------------------------------------------------------------------
		
		public static const PEOPLE_TYPE_PEOPLE:String = PeopleService.PEOPLE_SERVICE;
		public static const PEOPLE_TYPE_PERSON:String = PeopleService.PERSON_SERVICE;
		public static const PEOPLE_TYPE_FILMOGRAPHY:String = PeopleService.FILMOGRAPHY_SERVICE;
		
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
		 * <li>People Service: The word or term for which to search in people. 
		 * The method searches the name field for a match.</li>
		 * </ul>
		 * </p>
		 */		
		public var term:String = "";
		
		/**
		 * The ID for the person being looked up.
		 */
		public var personID:String;
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
			if(term && term!="") returnString+="&term=" + escape(term);
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
			return PEOPLE_TYPE_PEOPLE;
		}
		
	}
}