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
	import com.netflix.webapis.params.TitlesParams;
	import com.netflix.webapis.vo.AutoCompleteItem;
	import com.netflix.webapis.xml.NetflixOdataUtil;
	import com.netflix.webapis.xml.NetflixXMLUtil;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	
	import org.iotashan.utils.URLEncoding;

	/**
	 * Catalog Services under the <i>Titles</i> category. This is the main catagory for retrieving movie and series information.
	 * @author jonbcampos
	 * 
	 */	
	public class TitlesService extends ServiceBase
	{
		public function TitlesService(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		//---------------------------------------------------------------------
		//
		// Public Static Consts
		//
		//---------------------------------------------------------------------
		public static const AUTOCOMPLETE_SERVICE:String = "autoComplete";
		public static const CATALOG_SERVICE:String = "catalog";		
		public static const TITLE_SERVICE:String = "title";		
		public static const GENRE_SERVICE:String = "genre";		
		public static const ADVANCED_TITLE_SERVICE:String = "advancedTitle";		
		
		//---------------------------------------------------------------------
		//
		// Protected Static Consts
		//
		//---------------------------------------------------------------------
		protected static const TITLES_AUTOCOMPLETE_URL:String = NETFLIX_BASE_URL+"catalog/titles/autocomplete";
		protected static const TITLES_CATALOG_URL:String = NETFLIX_BASE_URL+"catalog/titles";
		protected static const TITLES_GENRE_URL:String = "http://odata.netflix.com/Catalog/Genres";
		protected static const ADVANCED_TITLES_CATALOG_URL:String = "http://odata.netflix.com/Catalog/Titles?";
		//---------------------------------------------------------------------
		//
		// Private Properties
		//
		//---------------------------------------------------------------------
		private namespace atom = "http://www.w3.org/2005/Atom";
		use namespace atom;
		//---------------------------------------------------------------------
		//
		// Public Methods
		//
		//---------------------------------------------------------------------
		/**
		 * @inheritDoc
		 */		
		override public function send(parameters:ParamsBase = null):void
		{
			super.send(parameters);
			
			//run service based on type
			switch(type)
			{
				case AUTOCOMPLETE_SERVICE:
					autoCompleteService( parameters );
				break;
				case CATALOG_SERVICE:
					catalogService( parameters );
				break;
				case TITLE_SERVICE:
					titleService( parameters );
				break;
				case GENRE_SERVICE:
					genreService( parameters );
				break;
				case ADVANCED_TITLE_SERVICE:
					advancedTitleService( parameters );
					break;
			}
		}
		
		/**
		 * Calls for the autoComplete Service. 
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param params
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.vo.AutoCompleteItem
		 */		
		public function autoCompleteService(params:ParamsBase=null):void
		{
			handleServiceLoading(TITLES_AUTOCOMPLETE_URL,determineParams(params,AUTOCOMPLETE_SERVICE));
		}
		
		/**
		 * Calls for the catalog Service.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 *  
		 * @param params
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */		
		public function catalogService(params:ParamsBase=null):void
		{
			handleServiceLoading(TITLES_CATALOG_URL,determineParams(params,CATALOG_SERVICE));
		}
		
		/**
		 * Calls for the title Service, details about a specific title.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 *  
		 * @param params
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */		
		public function titleService(params:ParamsBase=null):void
		{
			handleServiceLoading(TITLES_CATALOG_URL,determineParams(params,TITLE_SERVICE));
		}
		
		public function genreService(params:ParamsBase=null):void
		{
			handleServiceLoading(TITLES_GENRE_URL,determineParams(params,GENRE_SERVICE));
		}
		
		public function advancedTitleService(params:ParamsBase=null):void
		{
			handleServiceLoading(ADVANCED_TITLES_CATALOG_URL, determineParams(params, ADVANCED_TITLE_SERVICE));
		}
		
		//---------------------------------------------------------------------
		//
		// Override Methods: ServiceBase
		//
		//---------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */	
		override protected function handleServiceLoading(methodString:String, params:ParamsBase = null):void
		{
			super.handleServiceLoading(methodString, params);
			
			if(checkForConsumerKey()==false)
				return;
			
			var method:String = ServiceBase.GET_REQUEST_METHOD;
			var sendQuery:String = methodString;
			var typeQuery:String;
			
			if(!params)
				return;
			
			switch(type)
			{
				case AUTOCOMPLETE_SERVICE:
					// do no adjustment
					break;
				case CATALOG_SERVICE:
					// do no adjustment
					break;
				case TITLE_SERVICE:
					TitlesParams(params).term = null;
					if(params.netflixId)
						sendQuery = params.netflixId;
					else
						sendQuery = TitlesParams(params).title.netflixId;
					if(TitlesParams(params).retrieveExpansionOnly && TitlesParams(params).expandItem)
						sendQuery += "/"+TitlesParams(params).expandItem;
					break;
				case GENRE_SERVICE:
					method = ServiceBase.ODATA_REQUEST_METHOD;
					var genre:String = TitlesParams(params).genre.replace(/\s/g,"%20");
					sendQuery += "('"+URLEncoding.encode(genre)+"')/Titles/?";
					break;
				case ADVANCED_TITLE_SERVICE:
					method = ServiceBase.ODATA_REQUEST_METHOD;
					if(!params.filter)
						params.filter = "";
					if(TitlesParams(params).term && params.filter.length>0)
						params.filter = " and "+params.filter;
					if(TitlesParams(params).term)
						params.filter = "(Name eq trim('"+TitlesParams(params).term+"') or substringof(trim('"+TitlesParams(params).term+"'), Name))"+params.filter;
					break;
			}
			
			createLoader(sendQuery, params, _titlesService_CompleteHandler, method);
		}
		
		/**
		 * @private
		 * Complete Handler. 
		 * @param event
		 * 
		 */		
		private function _titlesService_CompleteHandler(event:Event):void
		{
			var loader:URLLoader = event.target as URLLoader;
			var queryXML:XML = XML(loader.data);
			clearLoader();
			
			if(queryXML=="Timestamp Is Invalid")
				getServerTimeOffset();
			else if(queryXML.Error == undefined)
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
				case AUTOCOMPLETE_SERVICE:
					for each(resultNode in returnedXML..autocomplete_item)
					{
						var autoCompleteVo:AutoCompleteItem = new AutoCompleteItem();
						autoCompleteVo.title = resultNode.title.@short;
						resultsArray.push(autoCompleteVo);
					}
				break;
				case CATALOG_SERVICE:
					for each (resultNode in returnedXML..catalog_title) {
						resultsArray.push(NetflixXMLUtil.handleXMLToCatalogItemModel(resultNode));
					}
				break;
				case TITLE_SERVICE:
					if(request && TitlesParams(request).retrieveExpansionOnly && TitlesParams(request).expandItem){
						resultsArray = handleExpansionOptions(request,returnedXML);
					} else {
						resultsArray.push( NetflixXMLUtil.handleXMLToCatalogItemModel(returnedXML) );
					}
				break;
				case GENRE_SERVICE:
					_currentIndex = request.startIndex;
					_resultsPerPage = request.maxResults;
					_numberOfResults = NetflixOdataUtil.handleCount(returnedXML);
					for each (resultNode in returnedXML..entry)
						resultsArray.push( NetflixOdataUtil.handleOdataToCatalogItemModel(resultNode) );
				break;
				case ADVANCED_TITLE_SERVICE:
					_currentIndex = request.startIndex;
					_resultsPerPage = request.maxResults;
					_numberOfResults = NetflixOdataUtil.handleCount(returnedXML);
					var children:XMLList = returnedXML.children();
					for each (resultNode in children)
					{
						if(resultNode.name() == "http://www.w3.org/2005/Atom::entry")
							resultsArray.push( NetflixOdataUtil.handleOdataToCatalogItemModel(resultNode) );
					}
					break;
			}
			lastNetflixResult = resultsArray;
			dispatchResult(resultsArray,type,returnedXML);
		}
		
		private function handleExpansionOptions(request:ParamsBase,returnedXML:XML):Array
		{
			var resultsArray:Array = [];
			var resultNode:XML;
			switch(TitlesParams(request).expandItem){
				case CatalogItemModel.EXPAND_SYNOPSIS:
					resultsArray.push(returnedXML.toString());
				break;
				case CatalogItemModel.EXPAND_FORMATS:
					for each(resultNode in returnedXML..availability)
						resultsArray.push(NetflixXMLUtil.handleFormatAvailability(resultNode));
				break;
				case CatalogItemModel.EXPAND_SCREEN_FORMATS:
					for each(resultNode in returnedXML..screen_format)
						resultsArray.push(NetflixXMLUtil.handleScreenFormat(resultNode));
				break;
				case CatalogItemModel.EXPAND_CAST:
				case CatalogItemModel.EXPAND_DIRECTORS:
					for each(resultNode in returnedXML..person)
						resultsArray.push(NetflixXMLUtil.handlePerson(resultNode));
				break;
				case CatalogItemModel.EXPAND_LANGUAGES_AND_AUDIO:
					for each(resultNode in returnedXML..language_audio_format)
						resultsArray.push(NetflixXMLUtil.handleLanguageAudioFormat(resultNode))
				break;
				case CatalogItemModel.EXPAND_SEASONS:
				case CatalogItemModel.EXPAND_EPISODES:
				case CatalogItemModel.EXPAND_DISCS:
					for each (resultNode in returnedXML..catalog_title)
						resultsArray.push(NetflixXMLUtil.handleXMLToCatalogItemModel(resultNode));
				break;
				case CatalogItemModel.EXPAND_SIMILARS:
					for each(resultNode in returnedXML..similars_item)
						resultsArray.push(NetflixXMLUtil.handleXMLToCatalogItemModel(resultNode));
				break;
				case CatalogItemModel.EXPAND_FILMOGRAPHY:
				break;
				case CatalogItemModel.EXPAND_BONUS_MATERIALS:
					for each(resultNode in returnedXML..link)
						resultsArray.push(NetflixXMLUtil.handleLink(resultNode));
				break;
				case CatalogItemModel.EXPAND_AWARDS:
					for each(resultNode in returnedXML..award_nominee)
						resultsArray.push(NetflixXMLUtil.handleAwardNominees(resultNode));
					for each(resultNode in returnedXML..award_nominee)
						resultsArray.push( NetflixXMLUtil.handleAwardsWinners(resultNode) );	
				break;
				default:
					resultsArray = [];
				break;
			}
			return resultsArray;
		}
		
		//---------------------------------------------------------------------
		//
		// No Params Quick Functions
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		// autocomplete
		//-----------------------------
		/**
		 * Quick Helper Function to request List of Titles through AutoComplete 
		 * without params object.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 * 
		 * @param term
		 * @param startIndex
		 * @param maxResults
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.vo.AutoCompleteItem
		 */	
		public function getListByAutoComplete(term:String, startIndex:uint=0, maxResults:uint=25):void
		{
			var params:TitlesParams = new TitlesParams();
			params.term = term;
			params.startIndex = startIndex;
			params.maxResults = maxResults;
			autoCompleteService(params);
		}
		
		//-----------------------------
		// catalog
		//-----------------------------
		/**
		 * Quick Helper Function to request list of titles by title without params object.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 *  
		 * @param term
		 * @param startIndex
		 * @param maxResults
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */	
		public function getCatalogListByTitle(term:String, startIndex:uint=0, maxResults:uint=25, expansions:String=null):void
		{
			var params:TitlesParams = new TitlesParams();
			params.term = term;
			params.startIndex = startIndex;
			params.maxResults = maxResults;
			params.expansions = expansions;
			catalogService(params);
		}
		
		//-----------------------------
		// titles
		//-----------------------------
		/**
		 * Calls for the title Service, details about a specific title.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 *  
		 * @param title
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */			
		public function getTitleDetails(title:CatalogItemModel):void
		{
			var params:TitlesParams = new TitlesParams();
			params.title = title;
			titleService(params);
		}
		
		public function getTitleExpansion(title:CatalogItemModel, expandItem:String, startIndex:uint=0, maxResults:uint=25, expansions:String=null):void
		{
			getTitleExpansionByNetflixId(title.netflixId, expandItem, startIndex, maxResults, expansions);
		}
		
		public function getTitleExpansionByNetflixId(netflixId:String, expandItem:String, startIndex:uint=0, maxResults:uint=25, expansions:String=null):void
		{
			var params:TitlesParams = new TitlesParams();
			params.expandItem = expandItem;
			params.expansions = expansions;
			params.startIndex = startIndex;
			params.maxResults = maxResults;
			params.netflixId = netflixId;
			params.retrieveExpansionOnly = true;
			titleService(params);
		}
		
		/**
		 * Calls for the title Service, details about a specific title.
		 * 
		 * Handle <code>result</code> or <code>fault</code> via 
		 * <code>NetflixResultEvent.RESULT</code> or 
		 * <code>NetflixFaultEvent.FAULT</code> respectively.
		 *  
		 * @param id
		 * 
		 * @see com.netflix.webapis.events.NetflixResultEvent#RESULT
		 * @see com.netflix.webapis.events.NetflixFaultEvent#FAULT
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */		
		public function getTitleById(id:String, expansions:String=null):void
		{
			var params:TitlesParams = new TitlesParams();
			params.netflixId = id;
			params.expansions = expansions;
			titleService(params);
		}
		
		public function getTitlesByGenre(genre:String, startIndex:uint=0, maxResults:uint=25, filter:String=null, orderBy:String=null, expansions:String=null):void
		{
			var params:TitlesParams = new TitlesParams();
			params.startIndex = startIndex;
			params.maxResults = maxResults;
			params.genre = genre;
			params.expansions = expansions;
			params.filter = filter;
			params.orderBy = orderBy;
			genreService(params);
		}
		
		public function getTitlesByAdvancedSearch(term:String, startIndex:uint=0, maxResults:uint=25, filter:String=null, orderBy:String=null, expansions:String=null):void
		{
			var params:TitlesParams = new TitlesParams();
			params.startIndex = startIndex;
			params.maxResults = maxResults;
			params.term = term;
			params.filter = filter;
			params.orderBy = orderBy;
			params.expansions = expansions;
			advancedTitleService( params );
		}
		
	}
}