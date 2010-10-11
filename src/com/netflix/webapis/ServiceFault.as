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
package com.netflix.webapis
{
	/**
	 * Generalized Service Fault.
	 * @author jonbcampos
	 * 
	 */	
	public class ServiceFault extends Error
	{
		private var _faultCode:String;
		/**
		 * Fault Code from Service. 
		 * @return 
		 * 
		 */		
		public function get faultCode():String
		{
			return _faultCode;
		}

		private var _faultString:String;
		/**
		 * Simple Fault Information. 
		 * @return 
		 * 
		 */		
		public function get faultString():String
		{
			return _faultString;
		}

		private var _faultDetail:String;
		/**
		 * Entire Fault Details, including some possible information as to how to solve the issue. 
		 * @return 
		 * 
		 */		
		public function get faultDetail():String
		{
			return _faultDetail;
		}

		
		public function ServiceFault(faultCode:String, faultString:String, faultDetail:String = null)
		{
			_faultCode = faultCode;
			_faultString = faultString;
			_faultDetail = faultDetail;
			super(faultCode);
		}
		
	}
}