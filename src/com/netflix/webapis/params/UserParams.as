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
	import com.netflix.webapis.vo.CatalogItemVO;
	import com.netflix.webapis.services.UserService;
	
	/**
	 * Params for UserService. 
	 * @author jonbcampos
	 * 
	 */	
	public class UserParams extends ParamsBase
	{
		public function UserParams()
		{
			super();
		}
		
		//---------------------------------------------------------------------
		//
		// Public Constant
		//
		//---------------------------------------------------------------------
		public static const USER_TYPE_TITLE_STATES:String = UserService.TITLES_STATES_SERVICE;
		
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
		
		//---------------------------------------------------------------------
		//
		// Public Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override public function toObject() : Object
		{
			var o:Object = super.toObject();
			//titlerefs
			if(titleRefs&&titleRefs.length>0){
				var n:int = titleRefs.length;
				var titleRefString:String = "";
				for(var i:int=0;i<n;i++)
				{
					if(titleRefs[i] is CatalogItemVO)
					{
						if(titleRefs[i].id)
							titleRefString += titleRefs[i].id;
						else if(titleRefs[i].netflixId)
							titleRefString += titleRefs[i].netflixId;
						else
							break;
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
			}
			
			return o;
		}
	}
}