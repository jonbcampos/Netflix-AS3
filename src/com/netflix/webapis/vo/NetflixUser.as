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
	[RemoteClass(alias="com.netflix.webapis.vo.NetflixUser")]
	/**
	 * Netflix User VO Object.
	 * 
	 * <p>
	 *  Example XML Structure:<br />
	 * 	&lt;user&gt;<br />
	 * 	&lt;user_id&gt;userId&lt;/user_id&gt;<br />
	 * 	&lt;first_name&gt;Joe&lt;/first_name&gt;<br />
	 * 	&lt;last_name&gt;Blow&lt;/last_name&gt;<br />
	 * 	&lt;can_instant_watch&gt;true&lt;/can_instant_watch&gt;<br />
	 * 	&lt;preferred_formats&gt;<br />
	 * 		&lt;category scheme="http://api.netflix.com/categories/title_formats" label="Blu-ray" term="Blu-ray"/&gt;<br />
	 * 		&lt;category scheme="http://api.netflix.com/categories/title_formats" label="DVD" term="DVD"/&gt;<br />
	 * 	&lt;/preferred_formats&gt;<br />
	 * 	&lt;link href="http://api.netflix.com/users/userId/queues" rel="http://schemas.netflix.com/queues" title="queues"/&gt;<br />
	 * 	&lt;link href="http://api.netflix.com/users/userId/rental_history" rel="http://schemas.netflix.com/rental_history" title="rental history"/&gt;<br />
	 * 	&lt;link href="http://api.netflix.com/users/userId/recommendations" rel="http://schemas.netflix.com/recommendations" title="recommendations"/&gt;<br />
	 * 	&lt;link href="http://api.netflix.com/users/userId/title_states" rel="http://schemas.netflix.com/title_states" title="title states"/&gt;<br />
	 * 	&lt;link href="http://api.netflix.com/users/userId/ratings" rel="http://schemas.netflix.com/ratings" title="ratings"/&gt;<br />
	 * 	&lt;link href="http://api.netflix.com/users/userId/reviews" rel="http://schemas.netflix.com/reviews" title="reviews"/&gt;<br />
	 * 	&lt;link href="http://api.netflix.com/users/userId/at_home" rel="http://schemas.netflix.com/at_home" title="at home"/&gt;<br />
	 * 	&lt;link href="http://api.netflix.com/users/userId/feeds" rel="http://schemas.netflix.com/feeds" title="feeds"/&gt;<br />
	 * &lt;/user&gt;<br />
	 * </p>
	 * 
	 * @author jonbcampos
	 * 
	 */	
	public class NetflixUser
	{
		public function NetflixUser()
		{
		}
		
		/**
		 * User Id. 
		 */		
		public var userId:String;
		/**
		 * User First Name. 
		 */		
		public var firstName:String;
		/**
		 * User Last Name. 
		 */		
		public var lastName:String;
		
		public var nickName:String;
		
		public var maxMaturityLevel:CategoryItem;
		/**
		 * Can watch instant movies. 
		 */		
		public var canInstantWatch:Boolean = false;
		
		[ArrayElementType("PreferredFormat")]
		/**
		 * Preferred Format.s 
		 */		
		public var preferredFormats:Array;
		/**
		 * Queues Link.
		 * 
		 * Used in Queues Service. 
		 * 
		 * @see com.netflix.webapis.services.QueueService
		 */		
		public var queuesLink:String;
		/**
		 * Rental History Link.
		 * 
		 * Used in Rental History Service.
		 * 
		 * @see com.netflix.webapis.services.RentalHistoryService 
		 */		
		public var rentalHistoryLink:String;
		/**
		 * Recommendations Link.
		 * 
		 * Used in User Service.
		 * 
		 * @see com.netflix.webapis.services.UserService 
		 */		
		public var recommendationsLink:String;
		/**
		 * Title States. 
		 */		
		public var titleStatesLink:String;
		/**
		 * Ratings Link.
		 * 
		 * Used in Ratings Service.
		 * 
		 * @see com.netflix.webapis.services.RatingService 
		 */		
		public var ratingsLink:String;
		/**
		 * Rental History Link.
		 * 
		 * Used in Rental History Service.
		 * 
		 * @see com.netflix.webapis.services.RentalHistoryService 
		 */	
		public var reviewsLink:String;
		/**
		 * Rental History Link.
		 * 
		 * Used in Rental History Service.
		 * 
		 * @see com.netflix.webapis.services.RentalHistoryService 
		 */	
		public var atHomeLink:String;
		/**
		 * Feeds link. 
		 */		
		public var feedsLink:String;
		
	}
}