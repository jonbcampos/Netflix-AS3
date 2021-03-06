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
package com.netflix.webapis.xml
{
	import com.netflix.webapis.services.ServiceStorage;
	import com.netflix.webapis.vo.AtHomeItemVO;
	import com.netflix.webapis.vo.AwardNomineeVO;
	import com.netflix.webapis.vo.AwardWinnerVO;
	import com.netflix.webapis.vo.CatalogItemVO;
	import com.netflix.webapis.vo.CategoryItemVO;
	import com.netflix.webapis.vo.FilmographyItemVO;
	import com.netflix.webapis.vo.FormatAvailabilityVO;
	import com.netflix.webapis.vo.LangaugeFormatVO;
	import com.netflix.webapis.vo.LinkItemVO;
	import com.netflix.webapis.vo.PersonVO;
	import com.netflix.webapis.vo.QueueItemVO;
	import com.netflix.webapis.vo.RatingsItemVO;
	import com.netflix.webapis.vo.RentalHistoryItemVO;
	import com.netflix.webapis.vo.ScreenFormatVO;
	import com.netflix.webapis.vo.TitleFormatVO;
	import com.netflix.webapis.vo.TitleStateItemVO;
	import com.netflix.webapis.vo.TitleStateVO;
	
	/**
	 * Utility file to parse XML results from Netflix API.
	 * @author brianburck
	 * 
	 */
	public class NetflixXMLUtilV1
	{
		public static const ID:String = "id";
		public static const CATALOG_TITLE:String = "catalog_title";
		public static const TITLE:String = "title";
		public static const BOX_ART:String = "box_art";
		public static const LINK : String = "link";
		public static const FORMAT : String = "format";
		public static const RELEASE_YEAR:String = "release_year";
		public static const CATEGORY:String = "category";
		public static const RUNTIME:String = "runtime";
		public static const AVERAGE_RATING:String = "average_rating";
		public static const USER_RATING:String = "user_rating";
		public static const PREDICTED_RATING:String = "predicted_rating";
		
		public static const SHIPPED_DATE:String = "shipped_date";
		public static const ESTIMATED_ARRIVAL_DATE:String = "estimated_arrival_date";
		public static const RETURNED_DATE:String = "returned_date";
		public static const WATCHED_DATE:String = "watched_date";
		public static const VIEWED_TIME:String = "viewed_time";
		
		
		public static const PERSON:String = "person";
		public static const NAME:String = "name";
		public static const BIO:String = "bio";
		
		public static const SYNOPSIS_ATTR:String = "synopsis";
		public static const CAST_ATTR:String = "cast";
		public static const DIRECTOR_ATTR:String = "directors";
		public static const FORMATS_ATTR:String = "formats";
		public static const SCREEN_FORMATS_ATTR:String = "screen formats";
		public static const AUDIO_ATTR:String = "languages and audio";
		public static const SEASONS_ATTR:String = "seasons";
		public static const EPISODES_ATTR:String = "episodes";
		public static const SIMILARS_ATTR:String = "similars";
		public static const OFFICIAL_SITE_ATTR:String = "official webpage";
		public static const NETFLIX_PAGE_ATTR:String = "web page";
		public static const FILMOGRAPHY_ATTR:String = "filmography";
		public static const DISCS_ATTR:String = "discs";
		public static const AWARDS_ATTR:String = "awards";
		public static const ALTERNATE_ATTR:String = "alternate";
		
		public static const POSITION_NODE:String = "position";
		public static const UPDATED_NODE:String = "updated";
		
		public static const ETAG_NODE:String = "etag";
		
		public static const PREFERRED_FORMAT:String = "preferred_format";
		
		public static const TITLE_FORMAT_SCHEME:String = "http://api.netflix.com/categories/title_formats";
		public static const SCREEN_FORMAT_SCHEME:String = "http://api.netflix.com/categories/screen_formats";
		public static const TITLE_STATE_SCHEME:String = "http://api.netflix.com/categories/title_states";
		
		public static const MPAA_RATINGS_SCHEME:String = "http://api.netflix.com/categories/mpaa_ratings";
		public static const TV_RATING_SCHEME:String = "http://api.netflix.com/categories/tv_ratings";
		public static const GENRES_SCHEME:String = "http://api.netflix.com/categories/genres";
		
		public static const AVAILABILITY_SCHEME:String = "http://api.netflix.com/categories/queue_availability";
		
		private static const TITLE_TYPE_INSTANT:String = "Instant";
		private static const TITLE_TYPE_DVD:String = "DVD";
		
		public static const TITLE_FORMAT_INSTANT:String = "instant";
		public static const TITLE_FORMAT_DVD:String = "DVD";
		public static const TITLE_FORMAT_BLURAY:String = "Blu-ray";
		
		private static const TITLE_STATE_IN_QUEUE:String = "In Queue";
		private static const TITLE_STATE_PLAY:String = "Play";
		private static const TITLE_STATE_ADD:String = "Add";
		private static const TITLE_STATE_AT_HOME:String = "At Home";
		
		public static const TITLE_SCHEMA:String = "http://schemas.netflix.com/catalog/title";
		public static const SERIES_TITLE_SCHEMA:String = "http://schemas.netflix.com/catalog/titles.series";
		public static const AVAILABLE_QUEUE_SCHEMA:String = "http://schemas.netflix.com/queues.available";
		public static const AWARDS_SCHEMA:String = "http://schemas.netflix.com/catalog/titles/awards";
		public static const MATURITY_LEVEL_SCHEMA:String = "http://api.netflix.com/categories/maturity_level";
		
		public static const QUEUES_SCHEMA:String = "http://schemas.netflix.com/queues";
		public static const RENTAL_HISTORY_SCHEMA:String = "http://schemas.netflix.com/rental_history";
		public static const RECOMMENDATIONS_SCHEMA:String = "http://schemas.netflix.com/recommendations";
		public static const TITLE_STATES_SCHEMA:String = "http://schemas.netflix.com/title_states";
		public static const RATINGS_SCHEMA:String = "http://schemas.netflix.com/ratings";
		public static const REVIEWS_SCHEMA:String = "http://schemas.netflix.com/reviews";
		public static const AT_HOME_SCHEMA:String = "http://schemas.netflix.com/at_home";
		public static const FEEDS_SCHEMA:String = "http://schemas.netflix.com/feeds";
		
		/**
		 * Converts XML to Catalog Model. 
		 * @param xml
		 * @param model
		 * @return CatalogItemModel
		 */		
		public static function handleXMLToCatalogItemVO(xml:XML,model:CatalogItemVO=null):CatalogItemVO
		{
			if(!model)
				model = new CatalogItemVO();
			
			var resultNode:XML;
			var child:XML;
			model.categories = [];
			model.links = [];
			var i:int = -1;
			var n:int = -1;
			var children:XMLList = xml.children();
			
			for each (resultNode in children)
			{
				var nodeType:String = String(resultNode.name());
				switch (nodeType) {
					case ID:
						model.id = handleStringNode(resultNode);
						break;
					case TITLE:
						model.titleShort = resultNode.@short;
						model.titleRegular = resultNode.@regular;
						break;
					case BOX_ART:
						model.boxArtTiny = model.boxArt88 = resultNode.@small;
						model.boxArtSmall = model.boxArt124 = resultNode.@medium;
						model.boxArtLarge = model.boxArt150 = resultNode.@large;
						break;
					case LINK:
						var linkTitle:String = resultNode.@title;
						switch (linkTitle) {
							case SYNOPSIS_ATTR:
								model.synopsis = handleLink(resultNode);
								if(resultNode.synopsis)
									model.synopsisString = resultNode.synopsis.toString()
								break;
							case CAST_ATTR:
								model.cast = handleLink(resultNode);
								if(resultNode.people != undefined)
								{
									model.castList = [];
									for each(child in resultNode..link)
									model.castList.push(handleLink(child));
								}
								break;
							case DIRECTOR_ATTR:
								model.directors = handleLink(resultNode);
								if(resultNode.people != undefined)
								{
									model.directorList = [];
									for each(child in resultNode..link)
									model.directorList.push(handleLink(child));
								}
								break;
							case AWARDS_ATTR:
								model.awards = handleLink(resultNode);
								if(resultNode.awards != undefined)
								{
									model.awardsList = [];
									for each(child in resultNode..award_winner)
									{
										if(!model.awardsWinnerList)
											model.awardsWinnerList = [];
										var awardWinner:AwardWinnerVO = handleAwardsWinners(child);
										model.awardsWinnerList.push( awardWinner );
										model.awardsList.push( awardWinner );
									}
									for each(child in resultNode..award_nominee)
									{
										if(!model.awardsNomineeList)
											model.awardsNomineeList = [];
										var awardNominee:AwardNomineeVO = handleAwardNominees(child);
										model.awardsNomineeList.push( awardNominee );
										model.awardsList.push( awardNominee );
									}
								}
								break;
							case FORMATS_ATTR:
								model.formats = handleLink(resultNode);
								if(resultNode.delivery_formats != undefined)
								{
									model.formatsList = [];
									for each(child in resultNode..availability)
									model.formatsList.push(handleFormatAvailability(child));
									
									i = -1;
									n = model.formatsList.length;
									var format:FormatAvailabilityVO;
									while(++i<n)
									{
										format = model.formatsList[i] as FormatAvailabilityVO;
										if(format.label == TITLE_FORMAT_INSTANT)
											model.isInstant = true;
										else if(format.label == TITLE_FORMAT_DVD)
											model.isDvd = true;
										else if(format.label == TITLE_FORMAT_BLURAY)
											model.isBluray = true;
									}
								}
								break;
							case SCREEN_FORMATS_ATTR:
								model.screenFormats = handleLink(resultNode);
								if(resultNode.screen_formats != undefined)
								{
									model.screenFormatsList = [];
									for each(child in resultNode..screen_format)
									model.screenFormatsList.push( handleScreenFormat(child) );
								}
								break;
							/*
							case AUDIO_ATTR:
								model.languagesAndAudio = handleLink(resultNode);
								if(resultNode.languages_and_audio != undefined)
								{
									model.languagesAndAudioList = [];
									for each(child in resultNode..language_audio_format)
									model.languagesAndAudioList.push( handleLanguageAudioFormat(child) );
								}
								break;
							*/
							case SEASONS_ATTR:
								model.seasons = handleLink(resultNode);
								if(resultNode.catalog_titles != undefined)
								{
									model.seasonsList = [];
									for each(child in resultNode..link)
									model.seasonsList.push( handleLink(child) );
								}
								break;
							case EPISODES_ATTR:
								model.episodes = handleLink(resultNode);
								break;
							case SIMILARS_ATTR:
								model.similars = handleLink(resultNode);
								if(resultNode.catalog_titles != undefined)
								{
									model.similarsList = [];
									for each(child in resultNode..link)
									model.similarsList.push(handleLink(child));
								}
								break;
							case OFFICIAL_SITE_ATTR:
								model.officialSite = handleLink(resultNode);
								break;
							case NETFLIX_PAGE_ATTR:
								model.webPage = handleLink(resultNode);
								break;
							case DISCS_ATTR:
								model.discs = handleLink(resultNode);
								if(resultNode.catalog_titles != undefined)
								{
									model.discsList = [];
									for each(child in resultNode..link)
									model.discsList.push(handleLink(child));
								}
								break;
							default:
								var link:LinkItemVO = handleLink(resultNode);
								model.links.push(link);
								
								if(link.rel == TITLE_SCHEMA)
									model.netflixId = link.url;
								else if(link.rel == SERIES_TITLE_SCHEMA)
									model.groupId = link.url;
								break;
						}
						break;
					case RELEASE_YEAR:
						model.releaseYear = handleNumber(resultNode);
						break;
					case RUNTIME:
						model.runtime = handleNumber(resultNode);
						break;
					case CATEGORY:
						var category:CategoryItemVO = handleCategory(resultNode); 
						model.categories.push(category);
						
						if(category.scheme == GENRES_SCHEME)
							model.genres.push(category.label);
						else if(category.scheme == MPAA_RATINGS_SCHEME && category.label!="null")
							model.rating = category.label;
						else if(category.scheme == TV_RATING_SCHEME && category.label!="null")
							model.rating = category.label;
						else if(model is QueueItemVO && category.scheme == AVAILABILITY_SCHEME)
							(model as QueueItemVO).availabilityLabel = category.label;
						else if(model is QueueItemVO && category.scheme == TITLE_FORMAT_SCHEME)
							(model as QueueItemVO).format = category.label;
						break;
					case AVERAGE_RATING:
						model.averageRating = handleNumber(resultNode);
						break;
					case USER_RATING:
						if(model is RatingsItemVO)
							(model as RatingsItemVO).userRating = handleUserRating(resultNode);
						break;
					case PREDICTED_RATING:
						if(model is RatingsItemVO)
							(model as RatingsItemVO).predictedRating = handleNumber(resultNode);
						break;
					case POSITION_NODE:
						if (model is QueueItemVO)
							(model as QueueItemVO).queuePosition = handleNumber(resultNode);
						break;
					case UPDATED_NODE:
						if (model is QueueItemVO)
							(model as QueueItemVO).lastUpdated = handleDate(resultNode);
						break;
					case SHIPPED_DATE:
						if(model is AtHomeItemVO)
							(model as AtHomeItemVO).shippedDate = handleDate(resultNode);
						break;
					case ESTIMATED_ARRIVAL_DATE:
						if(model is AtHomeItemVO)
							(model as AtHomeItemVO).shippedDate = handleDate(resultNode);
						break;
					case WATCHED_DATE:
						if(model is RentalHistoryItemVO)
							(model as RentalHistoryItemVO).watchedDate = handleDate(resultNode);
						break;
					case RETURNED_DATE:
						if(model is RentalHistoryItemVO)
							(model as RentalHistoryItemVO).returnedDate = handleDate(resultNode);
						break;
					case VIEWED_TIME:
						if(model is RentalHistoryItemVO)
							(model as RentalHistoryItemVO).viewedTime = handleStringNode(resultNode);
						break;
				}
			}
			
			if(!model.netflixId)
				model.netflixId = model.id;
			
			if(!model.groupId)
				model.groupId = model.netflixId;
			
			return model;
			
		}
		
		/**
		 * Handles the parsing of a <code>person</code> node. 
		 * @param xml <code>person</code> node
		 * @return PersonVO
		 * 
		 */		
		public static function handlePerson(xml:XML):PersonVO
		{
			var resultNode:XML;
			var personVO:PersonVO = new PersonVO();
			personVO.links = [];
			var children:XMLList = xml.children();
			
			for each (resultNode in children)
			{
				var nodeType:String = String(resultNode.name());
				switch (nodeType) {
					case LINK:
						var linkType:String = resultNode.@title;
						switch (linkType) {
							case FILMOGRAPHY_ATTR:
								personVO.filmography = handleLink(resultNode);
								break;
							case NETFLIX_PAGE_ATTR:
								personVO.webPage = handleLink(resultNode);
								break;
							default:
								personVO.links.push(handleLink(resultNode));
								break;
						}
						break;
					case BIO:
						personVO.bio = handleStringNode(resultNode);
						break;
					case NAME:
						personVO.name = handleStringNode(resultNode);
						break;
					case ID:
						personVO.id = handleStringNode(resultNode);
						break;
				}
			}
			return personVO
		}
		
		/**
		 * Handles the ID node parsing. 
		 * @param xml
		 * @return 
		 * 
		 */		
		public static function handleStringNode(xml:XML):String
		{
			return String(xml.valueOf());
		}
		
		/**
		 * Handles the Release Year node parsing.
		 * @param xml
		 * @return 
		 * 
		 */		
		public static function handleNumber(xml:XML):Number {
			return Number(xml.valueOf());
		}
		
		public static function handleInt(xml:XML):int {
			return int(xml.valueOf());
		}
		
		public static function handleUserRating(xml:XML):int
		{
			if(xml.@value && xml.@value=="not_interested")
				return -1;
			return handleInt(xml);
		}
		
		public static function handleBoolean(xml:XML):Boolean
		{
			return (xml.valueOf() == "true")?true:false;
		}
		
		/**
		 * Handles the Link node parsing. 
		 * @param xml
		 * @return 
		 * 
		 */		
		public static function handleLink(xml:XML):LinkItemVO
		{
			var linkVO:LinkItemVO = new LinkItemVO();
			linkVO.url = xml.@href;
			linkVO.rel = xml.@rel;
			linkVO.title = xml.@title;
			var children:XMLList = xml.children();
			var n:int = children.length();
			if(n > 0)
			{
				linkVO.expansion = [];
				var childXML:XML = xml.children()[0] as XML;
				linkVO.expansionTitle = String(childXML.name());
				var subchildren:XMLList = childXML.children();
				for each( var linkXML:XML in subchildren)
				{
					if (linkXML.name() == LINK)
						linkVO.expansion.push(handleLink(linkXML));
				}
			}
			return linkVO;
		}
		
		/**
		 * Handles the Category node parsing. 
		 * @param xml
		 * @return 
		 * 
		 */		
		public static function handleCategory(xml:XML):CategoryItemVO
		{
			var category:CategoryItemVO = new CategoryItemVO();
			category.scheme = xml.@scheme;
			category.label = xml.@label;
			category.term = xml.@term;
			return category;
		}
		
		/**
		 * Handle Updated Date parsing. 
		 * @param xml
		 * @return 
		 * 
		 */		
		public static function handleDate(xml:XML):Date
		{
			return handleDateValue(String(xml.valueOf()));
		}
		
		public static function handleDateValue(value:String):Date
		{
			return new Date(Number(value)*1000);
		}
		
		/**
		 * Handles the parsing of Format Availability Results. 
		 * @param xml
		 * @return 
		 * 
		 */		
		public static function handleFormatAvailability(xml:XML):FormatAvailabilityVO
		{
			var availability:FormatAvailabilityVO = new FormatAvailabilityVO();
			availability.label = xml.category.@label;
			availability.term = xml.category.@term;
			availability.scheme = xml.category.@scheme;
			//availability.availableUntil = (xml.@available_until!=undefined)?handleDateValue(xml.@available_until):null;
			availability.availableFrom = (xml.@available_from!=undefined)?handleDateValue(xml.@available_from):null;
			return availability;
		}
		/**
		 * Handles the parsing of Awards Nominee Results. 
		 * @param xml
		 * @return 
		 * 
		 */		
		public static function handleAwardsWinners(xml:XML):AwardWinnerVO
		{
			var award:AwardWinnerVO = new AwardWinnerVO();
			award.year = xml.@year;
			award.category = new CategoryItemVO();
			award.category.scheme = xml.category.@scheme;
			award.category.label = xml.category.@label;
			award.category.term = xml.category.@term;
			//award.link = new LinkItemVO();
			//award.link.url = xml.link.@href;
			//award.link.rel = xml.link.@rel;
			//award.link.title = xml.link.@title;
			return award;
		}
		/**
		 * Handles the parsing of Awards Nominee Results. 
		 * @param xml
		 * @return 
		 * 
		 */		
		public static function handleAwardNominees(xml:XML):AwardNomineeVO
		{
			var award:AwardNomineeVO = new AwardNomineeVO();
			award.year = xml.@year;
			award.category = new CategoryItemVO();
			award.category.scheme = xml.category.@scheme;
			award.category.label = xml.category.@label;
			award.category.term = xml.category.@term;
			//award.link = new LinkItemVO();
			//award.link.url = xml.link.@href;
			//award.link.rel = xml.link.@rel;
			//award.link.title = xml.link.@title;
			return award;
		}
		/**
		 * Handles the parsing of Screen Formats Results.  
		 * @param xml
		 * @return 
		 * 
		 */		
		public static function handleScreenFormat(xml:XML):ScreenFormatVO
		{
			var screenFormat:ScreenFormatVO = new ScreenFormatVO();
			screenFormat.categories = [];
			for each(var x:XML in xml..category){
				var category:CategoryItemVO = new CategoryItemVO();
				category.label = x.@label;
				category.scheme = x.@scheme;
				category.term = x.@term;
				if(category.scheme == TITLE_FORMAT_SCHEME)
					screenFormat.titleFormat = category.label;
				else if(category.scheme == SCREEN_FORMAT_SCHEME)
					screenFormat.screenFormat = category.label;
				screenFormat.categories.push(category);
			}
			return screenFormat;
		}
		
		/**
		 * Handles the parsing of Language and Audio Formats. 
		 * @param xml
		 * @return 
		 * 
		 */		
		public static function handleLanguageAudioFormat(xml:XML):TitleFormatVO
		{
			var title:TitleFormatVO = new TitleFormatVO();
			title.format = new CategoryItemVO();
			title.format.label = xml.category.@label;
			title.format.scheme = xml.category.@scheme;
			title.format.term = xml.category.@term;
			title.languages = [];
			
			var children:XMLList = xml.category.children();
			
			for each(var x:XML in children){
				var language:LangaugeFormatVO = new LangaugeFormatVO();
				language.language = x.@label;
				language.audioFormats = [];
				
				var subchildren:XMLList = x.children();
				
				for each(var y:XML in subchildren){
					language.audioFormats.push(y.@label);
				}
				title.languages.push(language);
			}
			return title;
		}
		
		/**
		 * Handles the parsing of Filmography Results.
		 * @param xml
		 * @return 
		 * 
		 */		
		public static function handleFilmography(xml:XML):FilmographyItemVO
		{
			return handleXMLToCatalogItemVO(xml) as FilmographyItemVO;
		}
		
		/**
		 * Handles the parsing of Title States.
		 * @param xml
		 * @return 
		 * 
		 */		
		public static function handleTitleState(xml:XML):TitleStateVO
		{
			var titleState:TitleStateVO = new TitleStateVO();
			titleState.url = xml.link.@href;
			titleState.rel = xml.link.@rel;
			titleState.title = xml.link.@title;
			//formats
			var titleStates:XMLList = xml..title_state_item;
			if(titleStates.length() > 0)
			{
				titleState.titleStates = [];
				for each(var titleStateXML:XML in titleStates)
				{
					var titleStateItem:TitleStateItemVO = new TitleStateItemVO();
					var titleStateChildren:XMLList = titleStateXML.children();
					for each (var titleStateNode:XML in titleStateChildren)
					{
						var titleStateNodeType:String = String(titleStateNode.name());
						switch(titleStateNodeType)
						{
							case LINK:
								if(String(titleStateNode.@rel).indexOf("item")>-1)
								{
									titleStateItem.queueId = titleStateItem.url = titleStateNode.@href;
									titleStateItem.rel = titleStateNode.@rel;
									titleStateItem.title = titleStateNode.@title;
								}
								break;
							case FORMAT:
								titleStateItem.formats = [];
								var categoryItem:CategoryItemVO;
								var formatChildren:XMLList = titleStateXML.format.children();
								for each(var resultNode:XML in formatChildren)
							{
								var nodeType:String = String(resultNode.name());
								switch(nodeType)
								{
									case CATEGORY:
										categoryItem = handleCategory(resultNode);
										titleStateItem.formats.push( categoryItem );
										if(categoryItem.scheme==TITLE_FORMAT_SCHEME)
										{
											if(categoryItem.term==TITLE_TYPE_DVD)
											{
												titleState.isDisc = titleStateItem.isDisc = true;
											} else if(categoryItem.term==TITLE_TYPE_INSTANT)
											{
												titleState.isInstant = titleStateItem.isInstant = true;
											}
										}
										break;
									case PREFERRED_FORMAT:
										titleStateItem.preferredFormat = handleBoolean(resultNode);
										break;
								}
							}
								titleState.titleStates.push(titleStateItem);
								break;
						}
					}
					//title state item transform
					var i:int = -1;
					var n:int = titleStateItem.formats.length;
					while(++i<n)
					{
						categoryItem = titleStateItem.formats[i] as CategoryItemVO;
						if(titleStateItem.isDisc)
						{
							if(categoryItem.term==TITLE_STATE_ADD)
								titleState.addToDisc = true;
							else if(categoryItem.term==TITLE_STATE_AT_HOME)
								titleState.isAtHome = true;
							else if(categoryItem.term==TITLE_STATE_IN_QUEUE)
								titleState.isInDiscQueue = true;
						} else if(titleStateItem.isInstant)
						{
							if(categoryItem.term==TITLE_STATE_ADD)
								titleState.addToInstant = true;
							else if(categoryItem.term==TITLE_STATE_PLAY)
								titleState.isInstantPlay = true;
							else if(categoryItem.term==TITLE_STATE_IN_QUEUE)
								titleState.isInInstantQueue = true;
						}
					}
				}
			}
			
			return titleState;
		}
		
		public static function handleRssResult(xml:XML):Array
		{
			var items:Array = [];
			var itemNode:XML;
			for each(itemNode in xml..item){
				items.push( String(itemNode.link) );
			}
			return items;
		}
		
		//-----------------------------
		//  handle generic xml result
		//-----------------------------
		/**
		 * Handles an unknown result and based on template returns correct result.
		 * 
		 * Incomplete.
		 *  
		 * @param xml
		 * @return 
		 * 
		 */		
		public static function handleXMLResult(xml:XML):Array
		{
			// get template for evaluation
			var urlTemplate:String = (xml.url_template)?xml.url_template:null;
			// if no template, die
			if(!urlTemplate)
				return [];
			
			// temp
			var ratingsTitleUrlTemplate:String = "http://api.netflix.com/users/"+ServiceStorage.getInstance().user.userId+"/ratings/title?{-join|&amp;|title_refs}";
			
			return [];
		}
		
	}
}