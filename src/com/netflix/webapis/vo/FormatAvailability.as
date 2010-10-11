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
	[RemoteClass(alias="com.netflix.webapis.vo.FormatAvailability")]
	/**
	 * FormatAvailabilityVO returned as part of the <code>TitlesService</code> <i>formats</i> expansion.</code>. 
	 * 
	 * @author jonbcampos
	 */
	public class FormatAvailability
	{
		public function FormatAvailability()
		{
		}
		
		/**
		 * From Date. 
		 */		
		public var availableFrom:Date;
		/**
		 * Includes From Date. 
		 */		
		public var availableFromAvailable:Boolean;
		/**
		 * To Date. 
		 */		
		public var availableUntil:Date;
		/**
		 * Includes To Date. 
		 */		
		public var availableUntilAvailable:Boolean;
		/**
		 * Visual Label. 
		 */		
		public var label:String;
		/**
		 * Netflix Term. 
		 */		
		public var term:String;

	}
}