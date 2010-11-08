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
package com.netflix.webapis.models
{
	import com.netflix.webapis.events.ExpansionEvent;
	import com.netflix.webapis.events.NetflixFaultEvent;
	import com.netflix.webapis.events.NetflixResultEvent;
	import com.netflix.webapis.params.TitlesParams;
	import com.netflix.webapis.services.TitlesService;
	import com.netflix.webapis.services.UserService;
	import com.netflix.webapis.vo.FormatAvailability;
	import com.netflix.webapis.vo.LinkItem;
	import com.netflix.webapis.vo.TitleState;
	import com.netflix.webapis.xml.NetflixXMLUtil;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	* Result Event.
	*/	
	[Event(name="result",type="com.netflix.webapis.events.NetflixResultEvent")]
	/**
	* Fault Event.
	*/	
	[Event(name="fault",type="com.netflix.webapis.events.NetflixFaultEvent")]
	
	[Event(name="castChange",type="com.netflix.webapis.events.ExpansionEvent")]
	[Event(name="formatsChange",type="com.netflix.webapis.events.ExpansionEvent")]
	[Event(name="screenFormatsChange",type="com.netflix.webapis.events.ExpansionEvent")]
	[Event(name="similarsChange",type="com.netflix.webapis.events.ExpansionEvent")]
	[Event(name="synopsisChange",type="com.netflix.webapis.events.ExpansionEvent")]
	[Event(name="directorsChange",type="com.netflix.webapis.events.ExpansionEvent")]
	[Event(name="awardsChange",type="com.netflix.webapis.events.ExpansionEvent")]
	[Event(name="languagesAndAudioChange",type="com.netflix.webapis.events.ExpansionEvent")]
	[Event(name="discsChange",type="com.netflix.webapis.events.ExpansionEvent")]
	[Event(name="episodesChange",type="com.netflix.webapis.events.ExpansionEvent")]
	[Event(name="seasonsChange",type="com.netflix.webapis.events.ExpansionEvent")]
	[Event(name="filmographyChange",type="com.netflix.webapis.events.ExpansionEvent")]
	[Event(name="bonusMaterialsChange",type="com.netflix.webapis.events.ExpansionEvent")]
	
	[Event(name="titleStatesChange",type="com.netflix.webapis.events.ExpansionEvent")]
	
	[RemoteClass(alias="com.netflix.webapis.models.CatalogItemModel")]
	/**
	 * Base Model Class for all Catalog Items. 
	 * @author jonbcampos
	 * 
	 */	
	public class CatalogItemModel extends EventDispatcher
	{
		public function CatalogItemModel(target:IEventDispatcher=null)
		{
			super(target);
			_constructor();
		}
		
		private function _constructor():void
		{
			_services = {};
		}
		
		//static properties
		public static const EXPAND_SYNOPSIS:String = "synopsis";
		public static const EXPAND_FORMATS:String = "formats";
		public static const EXPAND_SCREEN_FORMATS:String = "screen formats";
		public static const EXPAND_CAST:String = "cast";
		public static const EXPAND_DIRECTORS:String = "directors";
		public static const EXPAND_LANGUAGES_AND_AUDIO:String = "languages and audio";
		public static const EXPAND_SEASONS:String = "seasons";
		public static const EXPAND_EPISODES:String = "episodes";
		public static const EXPAND_DISCS:String = "discs";
		public static const EXPAND_SIMILARS:String = "similars";
		public static const EXPAND_FILMOGRAPHY:String = "filmography";
		public static const EXPAND_BONUS_MATERIALS:String = "bonus_materials";
		public static const EXPAND_AWARDS:String = "awards";
		
		private static const AVAILABLE_EXPANSIONS_CHANGED:String = "availableExpansionsChanged";
		
		//properties
		/**
		 * Netflix URL Id. Not a specific unique id number. 
		 */		
		public var id:String;
		/**
		 * Unique title id. 
		 */		
		public var netflixId:String;
		public var groupId:String;
		/**
		 * Type of Catalog item such as movie, season, etc. 
		 */		
		public var titleType:String;
		/**
		 * Short Verison of Catalog Title. 
		 */		
		public var titleShort:String;
		/**
		 * Complete Catalog Item Title. 
		 */		
		public var titleRegular:String;
		/**
		 * Box Art: Small Version (38x53)
		 */		
		public var boxArtSmall:String;
		/**
		 * Box Art: Medium Version (64x90). 
		 */		
		public var boxArtMedium:String;
		/**
		 * Box Art: Large Version (110x150). 
		 */		
		public var boxArtLarge:String;
		/**
		 * Title rating. 
		 */		
		public var rating:String = "NR";
		/**
		 * Year of release. 
		 */		
		public var releaseYear:Number;
		/**
		 * Runtime in seconds. 
		 */		
		public var runtime:Number;
		/**
		 * Average Popular Rating. 
		 */		
		public var averageRating:Number;
		/**
		 * Date of last update.
		 */		
		public var lastUpdated:Date;

		[ArrayElementType("com.netflix.webapis.vo.CategoryItem")]
		/**
		 * Title Genres. 
		 */		
		public var genres:Array = [];
		
		//additional categories
		[ArrayElementType("com.netflix.webapis.vo.CategoryItem")]
		/**
		 * Array of Catalogy Items. Can be matched with items from the Categoies Service.
		 * 
		 * @see com.netflix.webapis.services.CategoriesService 
		 * @see com.netflix.webapis.vo.CategoryItem
		 */		
		public var categories:Array;
		//additional links
		[ArrayElementType("com.netflix.webapis.vo.LinkItem")]
		/**
		 * Array of Link Items.
		 * 
		 * @see com.netflix.webapis.vo.LinkItem
		 */		
		public var links:Array;
		
		[Bindable(event="titleStatesChange")]
		/**
		 * Title State.
		 * 
		 * <p>
		 * <code>null</code> by default. You can call
		 * for multiple title states using the
		 * <code>UserService.TITLES_STATES_SERVICE</code>
		 * or by calling the <code>getTitleState()</code>.
		 * </p>
		 * 
		 * @see com.netflix.webapis.models.CatalogItemModel#getTitleState()
		 * @see com.netflix.webapis.services.UserService#TITLES_STATES_SERVICE
		 * @see com.netflix.webapis.services.UserService#getTitlesStates()
		 */		
		public var titleState:TitleState;
		
		//links
		private var _synopsis:LinkItem;
		/**
		 * Catalog Item's Synopsis Link Item. 
		 */		
		public function get synopsis():LinkItem
		{
			return _synopsis;
		}

		public function set synopsis(value:LinkItem):void
		{
			if(_synopsis==value)
				return;
			_synopsis = value;
			dispatchEvent(new Event(AVAILABLE_EXPANSIONS_CHANGED));
		}

		private var _cast:LinkItem;

		/**
		 * Catalog Item's Cast Link Item. 
		 */		
		public function get cast():LinkItem
		{
			return _cast;
		}

		public function set cast(value:LinkItem):void
		{
			if(_cast==value)
				return;
			_cast = value;
			dispatchEvent(new Event(AVAILABLE_EXPANSIONS_CHANGED));
		}

		private var _directors:LinkItem;
		
		/**
		 * Catalog Item's Directors Link Item. 
		 */		
		public function get directors():LinkItem
		{
			return _directors;
		}

		public function set directors(value:LinkItem):void
		{
			if(_directors==value)
				return;
			_directors = value;
			dispatchEvent(new Event(AVAILABLE_EXPANSIONS_CHANGED));
		}

		
		private var _screenFormats:LinkItem;

		/**
		 * Catalog Item's Screen Formats Link Item. 
		 */		
		public function get screenFormats():LinkItem
		{
			return _screenFormats;
		}

		public function set screenFormats(value:LinkItem):void
		{
			if(_screenFormats==value)
				return;
			_screenFormats = value;
			dispatchEvent(new Event(AVAILABLE_EXPANSIONS_CHANGED));
		}

		private var _languagesAndAudio:LinkItem;

		/**
		 * Catalog Item's Languages and Audio Link Item. 
		 */		
		public function get languagesAndAudio():LinkItem
		{
			return _languagesAndAudio;
		}

		public function set languagesAndAudio(value:LinkItem):void
		{
			if(_languagesAndAudio==value)
				return;
			_languagesAndAudio = value;
			dispatchEvent(new Event(AVAILABLE_EXPANSIONS_CHANGED));
		}

		private var _seasons:LinkItem;

		/**
		 * Catalog Item's Seasons Link Item. 
		 */		
		public function get seasons():LinkItem
		{
			return _seasons;
		}

		public function set seasons(value:LinkItem):void
		{
			if(_seasons==value)
				return;
			_seasons = value;
			dispatchEvent(new Event(AVAILABLE_EXPANSIONS_CHANGED));
		}

		private var _episodes:LinkItem;

		/**
		 * Catalog Item's Episodes Link Item.
		 */		
		public function get episodes():LinkItem
		{
			return _episodes;
		}

		public function set episodes(value:LinkItem):void
		{
			if(_episodes==value)
				return;
			_episodes = value;
			dispatchEvent(new Event(AVAILABLE_EXPANSIONS_CHANGED));
		}

		private var _similars:LinkItem;

		/**
		 * Catalog Item's Similars Link Item.
		 */		
		public function get similars():LinkItem
		{
			return _similars;
		}

		public function set similars(value:LinkItem):void
		{
			if(_similars==value)
				return;
			_similars = value;
			dispatchEvent(new Event(AVAILABLE_EXPANSIONS_CHANGED));
		}

		/**
		 * Catalog Item's Official Site Link Item.
		 */		
		public var officialSite:LinkItem;
		/**
		 * Catalog Item's Web Page Link Item.
		 */		
		public var webPage:LinkItem;
		private var _formats:LinkItem;
		
		[Bindable]
		/**
		 * Flag to signify if the title is an instant view title. 
		 */		
		public var isInstant:Boolean;
		
		[Bindable]
		/**
		 * Flag to signify if the title is a disc title. 
		 */		
		public var isDvd:Boolean;
		
		[Bindable]
		/**
		 * Flag to signify if the title is a bluray title. 
		 */		
		public var isBluray:Boolean;
		
		/**
		 * Catalog Item's Formats Link Item.
		 */		
		public function get formats():LinkItem
		{
			return _formats;
		}

		public function set formats(value:LinkItem):void
		{
			if(_formats==value)
				return;
			_formats = value;
			dispatchEvent(new Event(AVAILABLE_EXPANSIONS_CHANGED));
		}

		private var _discs:LinkItem;

		/**
		 * Catalog Item's Discs Link Item.
		 */		
		public function get discs():LinkItem
		{
			return _discs;
		}

		public function set discs(value:LinkItem):void
		{
			if(_discs==value)
				return;
			_discs = value;
			dispatchEvent(new Event(AVAILABLE_EXPANSIONS_CHANGED));
		}

		//-----------------------------
		//  expand items
		//-----------------------------
		private var _castList:Array;
		[Bindable(event="castChange")]
		[ArrayElementType("com.netflix.webapis.vo.Person")]
		/**
		 * Catalog Item's Cast List Expansion. Array of Person.
		 * 
		 * @return 
		 * 
		 * @see com.netflix.webapis.vo.Person
		 */
		public function get castList():Array
		{
			return _castList;
		}
		
		public function set castList(value:Array):void
		{
			if(_castList==value)
				return;
			_castList = value;
			dispatchEvent(new ExpansionEvent(ExpansionEvent.CAST_CHANGE, value, cast));
		}

		private var _formatsList:Array;
		[Bindable(event="formatsChange")]
		[ArrayElementType("com.netflix.webapis.vo.TitleFormat")]
		/**
		 * Catalog Item's Formats List Expansion. Array of TitleFormat.
		 * 
		 * @return 
		 * 
		 * @see com.netflix.webapis.vo.TitleFormat
		 */
		public function get formatsList():Array
		{
			return _formatsList;
		}
		
		public function set formatsList(value:Array):void
		{
			if(_formatsList==value)
				return;
			_formatsList = value;
			dispatchEvent(new ExpansionEvent(ExpansionEvent.FORMATS_CHANGE, value, formats));
		}
		
		private var _screenFormatsList:Array;
		[Bindable(event="screenFormatsChange")]
		[ArrayElementType("com.netflix.webapis.vo.ScreenFormat")]
		/**
		 * Catalog Item's Screen Formats List Expansion. Array of ScreenFormat.
		 * 
		 * @return 
		 * 
		 * @see com.netflix.webapis.vo.ScreenFormat
		 */
		public function get screenFormatsList():Array
		{
			return _screenFormatsList;
		}
		
		public function set screenFormatsList(value:Array):void
		{
			if(_screenFormatsList==value)
				return;
			_screenFormatsList = value;
			dispatchEvent(new ExpansionEvent(ExpansionEvent.SCREEN_FORMATS_CHANGE, value, screenFormats));
		}
		
		private var _similarsList:Array;
		[Bindable(event="similarsChange")]
		[ArrayElementType("com.netflix.webapis.models.CatalogItemModel")]
		/**
		 * Catalog Item's Similars List Expansion. Array of CatalogItemModelBases.
		 * 
		 * @return 
		 */
		public function get similarsList():Array
		{
			return _similarsList;
		}
		
		public function set similarsList(value:Array):void
		{
			if(_similarsList==value)
				return;
			_similarsList = value;
			dispatchEvent(new ExpansionEvent(ExpansionEvent.SIMILARS_CHANGE, value, similars));
		}
		
		private var _synopsisString:String;
		[Bindable(event="synopsisChange")]
		/**
		 * Catalog Item's Synopsis Expansion.
		 * 
		 * @return 
		 */
		public function get synopsisString():String
		{
			return _synopsisString;
		}
		
		public function set synopsisString(value:String):void
		{
			if(_synopsisString==value)
				return;
			_synopsisString = value;
			dispatchEvent(new ExpansionEvent(ExpansionEvent.SYNOPSIS_CHANGE, value, synopsis));
		}
		
		private var _directorList:Array;
		[Bindable(event="directorsChange")]
		[ArrayElementType("com.netflix.webapis.vo.Person")]
		/**
		 * Catalog Item's Director List Expansion. Array of Person.
		 * 
		 * @return 
		 * 
		 * @see com.netflix.webapis.vo.Person
		 */
		public function get directorList():Array
		{
			return _directorList;
		}
		
		public function set directorList(value:Array):void
		{
			if(_directorList==value)
				return;
			_directorList = value;
			dispatchEvent(new ExpansionEvent(ExpansionEvent.DIRECTORS_CHANGE, value, directors));
		}
		
		private var _awardsList:Array;
		[Bindable(event="awardsChange")]
		[ArrayElementType("com.netflix.webapis.vo.AwardNominee")]
		/**
		 * Catalog Item's Award List Expansion. Array of AwardNominee.
		 * 
		 * @return 
		 * 
		 * @see com.netflix.webapis.vo.AwardNominee
		 */
		public function get awardsList():Array
		{
			return _awardsList;
		}
		
		public function set awardsList(value:Array):void
		{
			if(_awardsList==value)
				return;
			_awardsList = value;
			dispatchEvent(new ExpansionEvent(ExpansionEvent.AWARDS_CHANGE, value, null));
		}
		
		private var _languagesAndAudioList:Array;
		[Bindable(event="languagesAndAudioChange")]
		[ArrayElementType("com.netflix.webapis.vo.LangaugeFormat")]
		/**
		 * Catalog Item's Language and Audio List Expansion. Array of LangaugeFormat.
		 * 
		 * @return 
		 * 
		 * @see com.netflix.webapis.vo.LangaugeFormat
		 */
		public function get languagesAndAudioList():Array
		{
			return _languagesAndAudioList;
		}
		
		public function set languagesAndAudioList(value:Array):void
		{
			if(_languagesAndAudioList==value)
				return;
			_languagesAndAudioList = value;
			dispatchEvent(new ExpansionEvent(ExpansionEvent.LANGUAGES_AND_AUDIO_CHANGE, value, languagesAndAudio));
		}
		
		private var _discsList:Array;
		[Bindable(event="discsChange")]
		[ArrayElementType("com.netflix.webapis.models.CatalogItemModel")]
		/**
		 * Catalog Item's Disc List Expansion. Array of CatalogItemModel.
		 * 
		 * @return 
		 * 
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */
		public function get discsList():Array
		{
			return _discsList;
		}
		
		public function set discsList(value:Array):void
		{
			if(_discsList==value)
				return;
			_discsList = value;
			dispatchEvent(new ExpansionEvent(ExpansionEvent.DISCS_CHANGE, value, discs));
		}
		
		private var _episodesList:Array;
		[Bindable(event="episodesChange")]
		[ArrayElementType("com.netflix.webapis.models.CatalogItemModel")]
		/**
		 * Catalog Item's Episodes List Expansion. Array of CatalogTitleVO.
		 * 
		 * @return 
		 * 
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */
		public function get episodesList():Array
		{
			return _episodesList;
		}
		
		public function set episodesList(value:Array):void
		{
			if(_episodesList==value)
				return;
			_episodesList = value;
			dispatchEvent(new ExpansionEvent(ExpansionEvent.EPISODES_CHANGE, value, episodes));
		}
		
		private var _seasonsList:Array;
		[Bindable(event="seasonsChange")]
		[ArrayElementType("com.netflix.webapis.models.CatalogItemModel")]
		/**
		 * Catalog Item's Seasons List Expansion. Array of CatalogTitleVO.
		 * 
		 * @return 
		 * 
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */
		public function get seasonsList():Array
		{
			return _seasonsList;
		}
		
		public function set seasonsList(value:Array):void
		{
			if(_seasonsList==value)
				return;
			_seasonsList = value;
			dispatchEvent(new ExpansionEvent(ExpansionEvent.SEASONS_CHANGE, value, seasons));
		}
		
		private var _filmographyList:Array;
		[Bindable(event="filmographyChange")]
		[ArrayElementType("com.netflix.webapis.models.FilmographyItemModel")]
		/**
		 * Catalog Item's Filmography List Expansion. Array of FilmographyItemModels.
		 * 
		 * @return 
		 * 
		 * @see com.netflix.webapis.models.FilmographyItemModel
		 */
		public function get filmographyList():Array
		{
			return _filmographyList;
		}
		
		public function set filmographyList(value:Array):void
		{
			if(_filmographyList==value)
				return;
			_filmographyList = value;
			dispatchEvent(new ExpansionEvent(ExpansionEvent.FILMOGRAPHY_CHANGE, value, null));
		}
		
		private var _bonusMaterialsList:Array;
		[Bindable(event="bonusMaterialsChange")]
		[ArrayElementType("com.netflix.webapis.vo.LinkItem")]
		/**
		 * Catalog Item's Bonus Materials List Expansion. Array of LinkItem.
		 * 
		 * @return 
		 * 
		 * @see com.netflix.webapis.vo.LinkItem
		 */
		public function get bonusMaterialsList():Array
		{
			return _bonusMaterialsList;
		}
		
		public function set bonusMaterialsList(value:Array):void
		{
			if(_bonusMaterialsList==value)
				return;
			_bonusMaterialsList = value;
			dispatchEvent(new ExpansionEvent(ExpansionEvent.FILMOGRAPHY_CHANGE, value, null));
		}
		
		[Bindable(event="availableExpansionsChanged")]
		/**
		 * List of availableExpansions. 
		 * @return 
		 * 
		 */		
		public function get availableExpansions():Array
		{
			var expands:Array = [];
			if(synopsis)
				expands.push(EXPAND_SYNOPSIS);
			if(formats)
				expands.push(EXPAND_FORMATS);
			if(screenFormats)
				expands.push(EXPAND_SCREEN_FORMATS);
			if(cast)
				expands.push(EXPAND_CAST);
			if(directors)
				expands.push(EXPAND_DIRECTORS);
			if(languagesAndAudio)
				expands.push(EXPAND_LANGUAGES_AND_AUDIO);
			if(seasons)
				expands.push(EXPAND_SEASONS);
			if(episodes)
				expands.push(EXPAND_EPISODES);
			if(discs)
				expands.push(EXPAND_DISCS);
			if(similars)
				expands.push(EXPAND_SIMILARS);
			expands.push(EXPAND_FILMOGRAPHY);
			expands.push(EXPAND_BONUS_MATERIALS);
			expands.push(EXPAND_AWARDS);
			return expands;
		}

		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------
		
		private var _services:Object;
		
		/**
		 * @inheritDoc
		 */		
		public function expandProperty(expandItem:String,params:TitlesParams=null, startIndex:uint=0, maxResults:uint=25, expansions:String=null):void
		{
			if(!params)
				params = new TitlesParams();
			_clearService(expandItem);
			var service:TitlesService = new TitlesService();
			_services[expandItem] = service;
			params.expandItem = expandItem;
			params.startIndex = startIndex;
			params.maxResults = maxResults;
			params.expansions = expansions;
			params.netflixId = netflixId;
			params.retrieveExpansionOnly = true;
			service.addEventListener(NetflixResultEvent.RESULT,_onExpandResult);
			service.addEventListener(NetflixFaultEvent.FAULT,_onExpandFault);
			service.send(params);
			
		}
		
		private function _onExpandResult(event:NetflixResultEvent):void
		{
			var service:TitlesService = event.target as TitlesService;
			var expandItem:String = TitlesParams(service.request).expansions;
			_clearService(expandItem);
			var i:int = -1;
			var n:int = -1;
			//set expansion list
			switch(expandItem){
				case EXPAND_SYNOPSIS:
					var s:Array = event.result as Array;
					synopsisString = s[0].toString();
				break;
				case EXPAND_FORMATS:
					formatsList = event.result as Array;
					
					i = -1;
					n = formatsList.length;
					var format:FormatAvailability;
					while(++i<n)
					{
						format = formatsList[i] as FormatAvailability;
						if(format.label == NetflixXMLUtil.TITLE_FORMAT_INSTANT)
							isInstant = true;
						else if(format.label == NetflixXMLUtil.TITLE_FORMAT_DVD)
							isDvd = true;
						else if(format.label == NetflixXMLUtil.TITLE_FORMAT_BLURAY)
							isBluray = true;
					}
				break;
				case EXPAND_SCREEN_FORMATS:
					screenFormatsList = event.result as Array;
				break;
				case EXPAND_CAST:
					castList = event.result as Array;
				break;
				case EXPAND_DIRECTORS:
					directorList = event.result as Array;
				break;
				case EXPAND_LANGUAGES_AND_AUDIO:
					languagesAndAudioList = event.result as Array;
				break;
				case EXPAND_SEASONS:
					seasonsList = event.result as Array;
				break;
				case EXPAND_EPISODES:
					episodesList = event.result as Array;
				break;
				case EXPAND_DISCS:
					discsList = event.result as Array;
				break;
				case EXPAND_SIMILARS:
					similarsList = event.result as Array;
				break;
				case EXPAND_FILMOGRAPHY:
					filmographyList = event.result as Array;
				break;
				case EXPAND_BONUS_MATERIALS:
					bonusMaterialsList = event.result as Array;
				break;
				case EXPAND_AWARDS:
					awardsList = event.result as Array;
				break;
				default:
					//do nothing
					break;
			}
			dispatchEvent(event);
		}
		
		private function _onExpandFault(event:NetflixFaultEvent):void
		{
			var service:TitlesService = event.target as TitlesService;
			var expandItem:String = TitlesParams(service.request).expansions;
			_clearService(expandItem);
			dispatchEvent(event);
		}
		
		private function _clearService(expandItem:String):void
		{
			if(_services[expandItem]!=undefined)
			{
				var service:TitlesService = _services[expandItem];
				service.removeEventListener(NetflixResultEvent.RESULT,_onExpandResult);
				service.removeEventListener(NetflixFaultEvent.FAULT,_onExpandFault);
				service = null;
				delete _services[expandItem];
			}
		}
		
		/**
		 * Calls to retrieve the expanded synopsis. 
		 */		
		public function expandSynopsis():void
		{
			expandProperty(EXPAND_SYNOPSIS);
		}
		/**
		 *  Calls to retrieve the expanded formats. 
		 */		
		public function expandFormats():void
		{
			expandProperty(EXPAND_FORMATS);
		}
		/**
		 *  Calls to retrieve the expanded screen formats. 
		 */		
		public function expandScreenFormats():void
		{
			expandProperty(EXPAND_SCREEN_FORMATS);
		}
		/**
		 *  Calls to retrieve the expanded cast. 
		 */		
		public function expandCast():void
		{
			expandProperty(EXPAND_CAST);
		}
		/**
		 *  Calls to retrieve the expanded directors. 
		 */		
		public function expandDirectors():void
		{
			expandProperty(EXPAND_DIRECTORS);
		}
		/**
		 *  Calls to retrieve the expanded languages and audio. 
		 */		
		public function expandLanguagesAndAudio():void
		{
			expandProperty(EXPAND_LANGUAGES_AND_AUDIO);
		}
		/**
		 *  Calls to retrieve the expanded seasons. 
		 */		
		public function expandSeasons():void
		{
			expandProperty(EXPAND_SEASONS);
		}
		/**
		 *  Calls to retrieve the expanded episodes. 
		 */		
		public function expandEpisodes():void
		{
			expandProperty(EXPAND_EPISODES);
		}
		/**
		 *  Calls to retrieve the expanded discs. 
		 */		
		public function expandDiscs():void
		{
			expandProperty(EXPAND_DISCS);
		}
		/**
		 * Calls to retrieve additional titles that are similar to this CatalogItemModelBase.
		 * @param startIndex
		 * @param maxResults
		 * 
		 */		
		public function expandSimilars(startIndex:int=-1,maxResults:int=-1):void
		{
			var params:TitlesParams = new TitlesParams();
			if(startIndex!=-1)
				params.startIndex = startIndex;
			if(maxResults!=-1)
				params.maxResults = maxResults;
			expandProperty(EXPAND_SIMILARS,params);
		}
		/**
		 *  Calls to retrieve the expanded filmography. 
		 */		
		public function expandFilmography():void
		{
			expandProperty(EXPAND_FILMOGRAPHY);
		}
		/**
		 *  Calls to retrieve the expanded bonus materials. 
		 */		
		public function expandBonusMaterials():void
		{
			expandProperty(EXPAND_BONUS_MATERIALS);
		}
		/**
		 *  Calls to retrieve the expanded awards. 
		 */		
		public function expandAwards():void
		{
			expandProperty(EXPAND_AWARDS);
		}
		
		/**
		 * @inheritDoc
		 */		
		public function expandAll():void
		{
			if(synopsis)
				expandSynopsis();
			if(formats)
				expandFormats();
			if(screenFormats)
				expandScreenFormats();
			if(cast)
				expandCast();
			if(directors)
				expandDirectors();
			if(languagesAndAudio)
				expandLanguagesAndAudio();
			if(seasons)
				expandSeasons();
			if(episodes)
				expandEpisodes();
			if(discs)
				expandDiscs();
			if(similars)
				expandSimilars();
			expandFilmography();
			expandBonusMaterials();
			expandAwards();
		}
		
		/**
		 * @inheritDoc
		 */
		public function contractAll():void
		{
			synopsisString = null;
			formatsList = null;
			screenFormatsList = null;
			castList = null;
			directorList = null;
			languagesAndAudioList = null;
			seasonsList = null;
			episodesList = null;
			discsList = null;
			similarsList = null;
			filmographyList = null;
			bonusMaterialsList = null;
			awardsList = null;
		}
		
		private var _userService:UserService;
		public function getTitleState():void
		{
			if(!_userService)
			{
				_userService = new UserService();
				_userService.addEventListener(NetflixResultEvent.RESULT, _onGetTitleStateResult);
				_userService.addEventListener(NetflixFaultEvent.FAULT, _onGetTitleStateFault);
			}
			_userService.getTitlesStates([netflixId]);
		}
		
		private function _onGetTitleStateResult(event:NetflixResultEvent):void
		{
			_userService.removeEventListener(NetflixResultEvent.RESULT, _onGetTitleStateResult);
			_userService.removeEventListener(NetflixFaultEvent.FAULT, _onExpandFault);
			_userService = null;
			titleState = (event.result as Array)[0] as TitleState;
			dispatchEvent(new ExpansionEvent(ExpansionEvent.TITLE_STATES_CHANGE, titleState, null));
		}
		
		private function _onGetTitleStateFault(event:NetflixFaultEvent):void
		{
			_userService.removeEventListener(NetflixResultEvent.RESULT, _onGetTitleStateResult);
			_userService.removeEventListener(NetflixFaultEvent.FAULT, _onExpandFault);
			_userService = null;
			dispatchEvent(new ExpansionEvent(ExpansionEvent.TITLE_STATES_CHANGE, null, null));
		}
	}
}