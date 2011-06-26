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
package com.netflix.webapis.vo
{
	[RemoteClass(alias="com.netflix.webapis.vo.TitleStateItem")]
	/**
	 * Individual title state returned from the <code>UserService.titleStatesService()</code> 
	 * or a <code>UserService</code> with <code>UserParams.type</code> being <i>USER_TYPE_TITLE_STATES</i>
	 * or <code>UserService.TITLES_STATES_SERVICE</code>.
	 * 
	 * @author jonbcampos
	 * 
	 * @see com.netflix.webapis.services.UserService#titleStatesService()
	 * @see com.netflix.webapis.services.UserService#TITLES_STATES_SERVICE
	 * @see com.netflix.webapis.params.UserParams
	 */	
	public class TitleStateItemVO extends LinkItemVO
	{
		public function TitleStateItemVO()
		{
		}
		
		/**
		 * Preferred format flag. 
		 */		
		public var preferredFormat:Boolean;
		
		[ArrayElementType("com.netflix.webapis.vo.CategoryItemVO")]
		/**
		 * The different formats of the states. 
		 */		
		public var formats:Array;
		
		public var watchedDate:Date;
		public var isDisc:Boolean;
		public var isInstant:Boolean;
		public var isInQueue:Boolean;
		public var queueId:String;

	}
}