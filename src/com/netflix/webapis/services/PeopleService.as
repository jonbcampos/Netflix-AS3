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
package com.netflix.webapis.services
{
	import com.netflix.webapis.ServiceFault;
	import com.netflix.webapis.events.NetflixFaultEvent;
	import com.netflix.webapis.events.NetflixResultEvent;
	import com.netflix.webapis.models.CatalogItemModel;
	import com.netflix.webapis.params.ParamsBase;
	import com.netflix.webapis.params.PeopleParams;
	import com.netflix.webapis.vo.Person;
	import com.netflix.webapis.xml.NetflixXMLUtil;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	
	/**
	 * Catalog Services under the <i>People</i> category.
	 * @author jonbcampos
	 * 
	 */	
	public class PeopleService extends ServiceBase
	{
		public static const PEOPLE_SERVICE:String = "people";
		public static const PERSON_SERVICE:String = "person"; 
		public static const FILMOGRAPHY_SERVICE:String = "filmography"; 
		
		protected static const PEOPLE_URL:String = NETFLIX_BASE_URL+"catalog/people";
		protected static const FILMOGRAPHY_PART:String = "filmography";

		public function PeopleService(target:IEventDispatcher=null)
		{
			super(target);
		}

		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override public function send(parameters:ParamsBase=null):void
		{
			super.send(parameters);
			
			switch(type)
			{
				case PEOPLE_SERVICE:
					peopleService(parameters);
				break;
				case PERSON_SERVICE:
					personService(parameters);
				break;
				case FILMOGRAPHY_SERVICE:
					filmographyService(parameters);
					break;
			}
		}
		
		/**
		 * You can retrieve detailed information 
		 * for people in the Catalog, using a name, 
		 * including a bio, featured titles, and a 
		 * complete list of titles.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param params
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.vo.Person
		 */	
		public function peopleService(params:ParamsBase=null):void
		{
			handleServiceLoading(PEOPLE_URL,determineParams(params,PEOPLE_SERVICE));
		}
		
		/**
		 * You can retrieve detailed information 
		 * for a person in the Catalog, using that 
		 * person's ID, including a bio, featured titles, 
		 * and a complete list of titles.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param params
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.vo.Person
		 */	
		public function personService(params:ParamsBase=null):void
		{
			handleServiceLoading(PEOPLE_URL,determineParams(params,PERSON_SERVICE));
		}
		
		/**
		 * Calls for the filmographyService and retrieves a
		 * filmography history for a person. 
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param params
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.FilmographyItemModel
		 */
		public function filmographyService(params:ParamsBase=null):void
		{
			handleServiceLoading(PEOPLE_URL,determineParams(params,FILMOGRAPHY_SERVICE));
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function handleServiceLoading(methodString:String, params:ParamsBase = null):void
		{
			super.handleServiceLoading(methodString, params);
			
			var sendQuery:String = methodString;
			var typeQuery:String;
			
			if(params != null)
			{
				switch(type)
				{
					case PEOPLE_SERVICE:
						//
					break;
					case PERSON_SERVICE:
						PeopleParams(params).term = null;
						if(params.netflixId)
							sendQuery = params.netflixId;
						else
							sendQuery = PeopleParams(params).personID;
					break;
					case FILMOGRAPHY_SERVICE:
						PeopleParams(params).term = null;
						if(params.netflixId)
							sendQuery = params.netflixId+"/"+FILMOGRAPHY_PART;
						else
							sendQuery = PeopleParams(params).personID+"/"+FILMOGRAPHY_PART;
					break;
				}
			}
			
			if(checkForConsumerKey()==false)
				return;
			createLoader(sendQuery, params, _peopleService_CompleteHandler);
		}
		
		private function _peopleService_CompleteHandler(event:Event):void
		{
			var loader:URLLoader = event.target as URLLoader;
			var queryXML:XML = XML(loader.data);
			clearLoader();
			
			if(queryXML.Error == undefined)
				formatAndDispatch(queryXML);
			else
				dispatchFault(new ServiceFault(NetflixFaultEvent.API_RESPONSE, queryXML.Error, queryXML.Error.Message));
		}
		
		/**
		 * @inheritDoc
		 */	
		override protected function formatAndDispatch(returnedXML:XML):void
		{
			super.formatAndDispatch(returnedXML);
			
			var resultsArray:Array = [];
			var resultNode:XML;
			
			//loop through child nodes and build value objects based on catagory type
			switch(type)
			{
				case PEOPLE_SERVICE:
					for each(resultNode in returnedXML..person) {
						resultsArray.push(NetflixXMLUtil.handlePerson(resultNode));
					}
				break;
				case PERSON_SERVICE:
					resultsArray.push(NetflixXMLUtil.handlePerson(returnedXML));
				break;
				case FILMOGRAPHY_SERVICE:
					for each(resultNode in returnedXML..filmography_item){
						resultsArray.push(NetflixXMLUtil.handleXMLToCatalogItemModel(resultNode));
					}
			}
			lastNetflixResult = resultsArray;
			dispatchResult(resultsArray,type,returnedXML);
		}
		
		//---------------------------------------------------------------------
		//
		// No Params Quick Functions
		//
		//---------------------------------------------------------------------
		/**
		 * Quick Helper Function to request a people by name 
		 * without params object. You can retrieve detailed information 
		 * for a person in the Catalog, using that person's ID, 
		 * including a bio, featured titles, and a complete list of titles.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param name
		 * @param startIndex
		 * @param maxResults
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.vo.Person
		 */	
		public function getPeopleByName(name:String, startIndex:uint=0, maxResults:uint=25):void
		{
			var params:PeopleParams = new PeopleParams();
			params.term = name;
			params.startIndex = startIndex;
			params.maxResults = maxResults;
			peopleService(params);
		}
		
		/**
		 * Quick Helper Function to request a person by person id 
		 * without params object. You can retrieve detailed information 
		 * for a person in the Catalog, using that person's ID, 
		 * including a bio, featured titles, and a complete list of titles.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param personId
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.vo.Person
		 */	
		public function getPersonByPersonId(personId:String):void
		{
			var params:PeopleParams = new PeopleParams();
			params.personID = personId;
			personService(params);
		}
		
		/**
		 * Quick Helper Function to request a person by netflix id 
		 * without params object. You can retrieve detailed 
		 * information for a person in the Catalog, using that 
		 * person's ID, including a bio, featured titles, and a 
		 * complete list of titles.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param netflixId
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.vo.Person
		 */	
		public function getPersonByNetflixId(netflixId:String):void
		{
			var params:PeopleParams = new PeopleParams();
			params.netflixId = netflixId;
			personService(params);
		}
		
		/**
		 * Quick Helper Function to request a filmography object by 
		 * person without params object.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param personId
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.FilmographyItemModel
		 */	
		public function getFilmographyByPerson(person:Person, expansions:String=null):void
		{
			getFilmographyByPersonId(person.id, expansions);
		}
		
		/**
		 * Quick Helper Function to request a filmography object by 
		 * person id without params object.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param personId
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.FilmographyItemModel
		 */	
		public function getFilmographyByPersonId(personId:String, expansions:String=null):void
		{
			var params:PeopleParams = new PeopleParams();
			params.expansions = expansions;
			params.personID = personId;
			filmographyService(params);
		}
		
		/**
		 * Quick Helper Function to request a filmography object by 
		 * netflix id without params object.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param netflixId
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.FilmographyItemModel
		 */	
		public function getFilmographyByNetflixId(netflixId:String, expansions:String=null):void
		{
			var params:PeopleParams = new PeopleParams();
			params.expansions = expansions;
			params.netflixId = netflixId;
			filmographyService(params);
		}
		
	}
}